#!/usr/bin/env bash
# Autonomous Fix Loop: robust version with corruption detection, validation, and regeneration
set -euo pipefail

LOOP_DIR="$(cd "$(dirname "$0")/.." && pwd)"
AUTO_BACKLOG="$LOOP_DIR/AUTO_BACKLOG.md"
BACKLOG_SCANNER="$LOOP_DIR/tools/backlog_scanner.py"
CONTEXT_LOADER="$LOOP_DIR/tools/context_loader.py"
PROGRESS_FILE="$LOOP_DIR/tools/.auto_fix_progress"
TMP_BACKUP="/tmp/soc_autopilot_fix_loop_$$.bak"
MIN_BACKLOG_SIZE=10240  # 10KB absolute minimum

log() { echo "[$(date +%H:%M:%S)] $*" >&2; }

# Cleanup on exit
cleanup() {
    rm -f "$TMP_BACKUP" "$LOOP_DIR/AUTO_BACKLOG.md.bak" "$PROGRESS_FILE" 2>/dev/null || true
}
trap cleanup EXIT

# Detect corruption: size below absolute minimum or trivial/invalid content
is_corrupted() {
    local size
    size=$(wc -c < "$AUTO_BACKLOG" 2>/dev/null || echo "0")
    if [[ "$size" -lt "$MIN_BACKLOG_SIZE" ]]; then
        return 0  # corrupted
    fi
    # Check for trivial content like "main.py" only
    local content
    content=$(head -c 20 "$AUTO_BACKLOG" 2>/dev/null || echo "")
    if [[ "$content" == "main.py" || -z "$content" ]]; then
        return 0
    fi
    return 1
}

# Backup to /tmp with PID to avoid conflicts
backup_backlog() {
    cp "$AUTO_BACKLOG" "$TMP_BACKUP"
    log "💾 Backed up AUTO_BACKLOG.md to $TMP_BACKUP (size: $(wc -c < "$TMP_BACKUP"))"
}

# Restore from /tmp backup
restore_backlog() {
    if [[ -f "$TMP_BACKUP" ]]; then
        cp "$TMP_BACKUP" "$AUTO_BACKLOG"
        log "♻️ Restored AUTO_BACKLOG.md from backup"
    else
        log "⚠️ No backup found, regenerating..."
        regenerate_backlog
    fi
}

# Regenerate backlog from scanner if corrupted
regenerate_backlog() {
    log "🔄 Regenerating AUTO_BACKLOG.md from scanner..."
    python3 "$BACKLOG_SCANNER" > /dev/null 2>&1 || true
    # Verify regeneration
    if is_corrupted; then
        log "❌ Regeneration failed, exiting."
        exit 1
    fi
    log "✅ AUTO_BACKLOG.md regenerated successfully"
}

# Remove Aider's garbage files
cleanup_garbage() {
    find "$LOOP_DIR" -maxdepth 3 \( -name "Let me fix*" -o -name "*.py.bak" -o -name "*.orig" -o -name "*~" -o -name "*.swp" \) -delete 2>/dev/null || true
    find "$LOOP_DIR" -maxdepth 1 -name "path" -type d -exec rm -rf {} + 2>/dev/null || true
    find "$LOOP_DIR" -maxdepth 2 -name "assert *" -delete 2>/dev/null || true
}

# Validate Aider output BEFORE committing
validate_aider_output() {
    local test_file="$1"

    # Check for garbage directories
    if find "$LOOP_DIR" -maxdepth 3 -type d -name "path" 2>/dev/null | grep -q .; then
        log "❌ Aider created garbage 'path/' directory"
        return 1
    fi

    # Check for file deletions
    local deleted_files
    deleted_files=$(git diff --name-only --diff-filter=D HEAD 2>/dev/null || true)
    if [[ -n "$deleted_files" ]]; then
        log "❌ Aider deleted files: $deleted_files"
        return 1
    fi

    # Check for files in wrong paths (path/to/...)
    local wrong_path_files
    wrong_path_files=$(git diff --name-only HEAD 2>/dev/null | grep -E "^path/to/" || true)
    if [[ -n "$wrong_path_files" ]]; then
        log "❌ Aider created files in wrong paths: $wrong_path_files"
        return 1
    fi

    # Syntax check for Python files
    local py_files
    py_files=$(git diff --name-only HEAD 2>/dev/null | grep '\.py$' || true)
    for f in $py_files; do
        if [[ -f "$f" ]] && ! python3 -c "compile(open('$f').read(), '$f', 'exec')" 2>/dev/null; then
            log "❌ Syntax error in $f"
            return 1
        fi
    done

    # Diff size guard
    local changed_lines
    changed_lines=$(git diff --stat HEAD 2>/dev/null | tail -1 | sed 's/.* \([0-9]*\) insertion/\1/' || echo "0")
    if [[ "$changed_lines" -gt 200 ]]; then
        log "❌ Diff too large (${changed_lines} lines)"
        return 1
    fi

    # Quality gate
    if ! python3 tools/quality_gate.py >/dev/null 2>&1; then
        log "❌ Quality gate failed"
        return 1
    fi

    # Tests
    if [[ -n "$test_file" && -f "$test_file" ]]; then
        if ! timeout 120 python3 -m pytest "$test_file" -q --tb=no 2>/dev/null; then
            log "❌ Tests failed: $test_file"
            return 1
        fi
    fi

    return 0
}

main() {
    log "🔄 AUTONOMOUS FIX LOOP STARTING"
    local items_fixed=0
    local items_skipped=0

    # Initial backup and corruption check
    backup_backlog
    if is_corrupted; then
        log "⚠️ Initial backlog corrupted, regenerating..."
        regenerate_backlog
    fi

    while true; do
        # Check if backlog is corrupted before proceeding
        if is_corrupted; then
            log "⚠️ Backlog corrupted during loop, regenerating..."
            regenerate_backlog
            continue
        fi

        # Read context loader output
        OUTPUT=$(python3 "$CONTEXT_LOADER" 2>&1) || {
            log "❌ Context loader failed, stopping"
            break
        }

        if echo "$OUTPUT" | grep -q "No unchecked issues"; then
            log "✅ All backlog items resolved!"
            break
        fi

        # Extract aider command
        CMD=$(echo "$OUTPUT" | grep "^aider " | head -1 || true)
        if [[ -z "$CMD" ]]; then
            log "⚠️ No aider command generated, stopping"
            # Check if this is an unresolvable item (no files found)
            if echo "$OUTPUT" | grep -q "No relevant files found\|skipping"; then
                log "⏭️ Skipping unresolvable item: ${LABEL:-unknown}"
                # Mark as done in backlog
                python3 -c "
            import re
            c = open('AUTO_BACKLOG.md').read()
            c = re.sub(r'- \[ \] (\*\*.*?\*\*)', r'- [x] \1 *(skipped: no resolvable files)*', c, count=1)
            open('AUTO_BACKLOG.md', 'w').write(c)
            " 2>/dev/null || true
                items_skipped=$((items_skipped + 1))
                echo "$(date +%s)|${LABEL:-unknown}|skipped-no-files" >> "$PROGRESS_FILE"
                continue
            fi
            break
        fi

        # Extract source file for test matching
        SRC=$(echo "$OUTPUT" | grep "Source:" | sed 's/.*Source: //' | tr -d '`' || true)
        TEST_FILE=""
        if [[ -n "$SRC" && "$SRC" == *.py ]]; then
            STEM=$(basename "$SRC" .py)
            for CANDIDATE in "tests/test_${STEM}.py" "tests/${STEM}.py" "tests/unit_${STEM}.py"; do
                [[ -f "$CANDIDATE" ]] && TEST_FILE="$CANDIDATE" && break
            done
        fi

        # Extract label and message
        LABEL=$(echo "$OUTPUT" | grep "Top Issue:" | sed 's/.*Top Issue: //' || true)
        MSG=$(echo "$OUTPUT" | grep "Message:" | sed 's/.*Message: //' | cut -c1-200 || true)

        PROMPT="Fix this issue: ${LABEL}. Details: ${MSG}. Constraints: Surgical edits only. Preserve signatures and docstrings. No except Exception: pass. Do NOT create new files. Edit existing files only. Use proper file paths like 'tests/foo.py' not 'path/to/tests/foo.py'."

        # Extract files from aider command
        FILES=$(echo "$CMD" | sed 's/^aider //' | sed 's/AUTO_BACKLOG.md//g' | sed 's/--read//g' | xargs || true)

        if [[ -z "$FILES" ]]; then
            log "⏭️ No editable files found, skipping"
            items_skipped=$((items_skipped + 1))
            echo "$(date +%s)|${LABEL:-unknown}|skipped-no-files" >> "$PROGRESS_FILE"
            log "--- Moving to next item ---"
            sleep 1
            continue
        fi

        # Backup before Aider call
        backup_backlog

        SUCCESS=false
        for attempt in $(seq 1 2); do
            log "▶️ Attempt $attempt/2: $LABEL"

            # Run aider with timeout
            if timeout 600 aider --edit-format diff --read "$AUTO_BACKLOG" -m "$PROMPT" --yes-always $FILES 2>&1; then
                cleanup_garbage
                restore_backlog
                rm -f "$TMP_BACKUP"

                if validate_aider_output "$TEST_FILE"; then
                    log "✅ Fix verified"
                    items_fixed=$((items_fixed + 1))
                    echo "$(date +%s)|$LABEL|fixed" >> "$PROGRESS_FILE"
                    git add -A 2>/dev/null || true
                    git diff --cached --quiet 2>/dev/null || \
                        git commit -m "auto-fix: ${LABEL}" --no-verify 2>/dev/null || true
                    SUCCESS=true
                    break
                else
                    log "⚠️ Verification failed, reverting"
                    git checkout -- . 2>/dev/null || true
                    git clean -fd 2>/dev/null || true
                fi
            else
                log "⚠️ Aider timed out or failed"
                git checkout -- . 2>/dev/null || true
                git clean -fd 2>/dev/null || true
                restore_backlog
                rm -f "$TMP_BACKUP"
            fi

            sleep 2
        done

        if [[ "$SUCCESS" != "true" ]]; then
            log "⏭️ Skipping unfixable item after 2 attempts"
            items_skipped=$((items_skipped + 1))
            echo "$(date +%s)|$LABEL|skipped" >> "$PROGRESS_FILE"
        fi

        log "--- Moving to next item ---"
        sleep 1
    done

    log "🏁 FIX LOOP COMPLETE: $items_fixed fixed, $items_skipped skipped"
    rm -f "$PROGRESS_FILE"
}

main "$@"
