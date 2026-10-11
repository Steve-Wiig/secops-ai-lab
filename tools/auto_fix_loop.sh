#!/usr/bin/env bash
# Autonomous Fix Loop: context load → aider → verify → retry or next
set -euo pipefail

LOCKFILE="/tmp/soc_autopilot_fix_loop.lock"
if [[ -f "$LOCKFILE" ]]; then
    echo "Another fix loop is already running (PID: $(cat "$LOCKFILE"))"
    exit 1
fi
echo $$ > "$LOCKFILE"
trap 'rm -f "$LOCKFILE" AUTO_BACKLOG.md.bak' EXIT

cd "$(dirname "$0")/.."

MAX_RETRIES=2
TIMEOUT_SEC=300
PROGRESS_FILE="tools/.auto_fix_progress"
: > "$PROGRESS_FILE"

log() { echo "[$(date +%H:%M:%S)] $*"; }

run_aider_with_prompt() {
    local prompt="$1"
    shift
    timeout "$TIMEOUT_SEC" aider --read AUTO_BACKLOG.md -m "$prompt" --yes-always "$@" 2>&1 || return 1
}

cleanup_garbage() {
    # Remove Aider's garbage files
    find . -maxdepth 3 \( -name "Let me fix*" -o -name "*.py.bak" -o -name "*.orig" -o -name "*~" -o -name "*.swp" \) -delete 2>/dev/null || true
    # Remove incorrectly-pathed files (Aider sometimes creates path/to/...)
    find . -maxdepth 1 -name "path" -type d -exec rm -rf {} + 2>/dev/null || true
    find . -maxdepth 2 -name "assert *" -delete 2>/dev/null || true
}

verify_changes() {
    local test_file="$1"
    
    # Check for garbage files Aider might have created
    if find . -maxdepth 2 -name "path" -type d | grep -q .; then
        log "❌ Aider created garbage 'path/' directory"
        return 1
    fi
    
    # Check if any files were actually modified
    local modified_files
    modified_files=$(git diff --name-only HEAD 2>/dev/null | grep -v "AUTO_BACKLOG.md" || true)
    if [[ -z "$modified_files" ]]; then
        log "❌ No files were actually modified"
        return 1
    fi
    
    # Check for files created in wrong locations
    local new_files
    new_files=$(git ls-files --others --exclude-standard 2>/dev/null | grep -v "tools/.auto_fix_progress" | grep -v "AUTO_BACKLOG.md.bak" || true)
    if [[ -n "$new_files" ]]; then
        log "❌ Aider created unexpected files: $new_files"
        return 1
    fi

    # Check for deleted files (catastrophic if unintended)
    local deleted_files
    deleted_files=$(git diff --name-only --diff-filter=D HEAD 2>/dev/null || true)
    if [[ -n "$deleted_files" ]]; then
        log "❌ Aider deleted files: $deleted_files"
        return 1
    fi

    # Check for files in wrong paths (path/to/... or similar)
    local wrong_path_files
    wrong_path_files=$(git diff --name-only HEAD 2>/dev/null | grep -E "^path/to/" || true)
    if [[ -n "$wrong_path_files" ]]; then
        log "❌ Aider created files in wrong paths: $wrong_path_files"
        return 1
    fi
    
    # Syntax check
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
    changed_lines=$(git diff --stat HEAD 2>/dev/null | tail -1 | grep -oP '\d+(?= insertion)' || echo "0")
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

restore_backlog() {
    if [[ -f AUTO_BACKLOG.md.bak ]]; then
        local current_size backup_size
        current_size=$(wc -c < AUTO_BACKLOG.md 2>/dev/null || echo "0")
        backup_size=$(wc -c < AUTO_BACKLOG.md.bak 2>/dev/null || echo "0")
        
        if [[ "$current_size" -lt "$((backup_size / 2))" ]]; then
            log "⚠️ Backlog corrupted (${current_size}b vs ${backup_size}b), restoring"
            cp AUTO_BACKLOG.md.bak AUTO_BACKLOG.md
        fi
    fi
}

main() {
    log "🔄 AUTONOMOUS FIX LOOP STARTING"
    local items_fixed=0
    local items_skipped=0

    while true; do
        OUTPUT=$(python3 tools/context_loader.py 2>&1)
        echo "$OUTPUT"

        if echo "$OUTPUT" | grep -q "No unchecked issues"; then
            log "✅ All backlog items resolved!"
            break
        fi

        CMD=$(echo "$OUTPUT" | grep "^aider " | head -1)
        if [[ -z "$CMD" ]]; then
            log "⚠️ No aider command generated, stopping"
            break
        fi

        SRC=$(echo "$OUTPUT" | grep "Source:" | sed 's/.*Source: //' | tr -d '`')
        TEST_FILE=""
        if [[ -n "$SRC" && "$SRC" == *.py ]]; then
            STEM=$(basename "$SRC" .py)
            for CANDIDATE in "tests/test_${STEM}.py" "tests/${STEM}.py" "tests/unit_${STEM}.py"; do
                [[ -f "$CANDIDATE" ]] && TEST_FILE="$CANDIDATE" && break
            done
        fi

        LABEL=$(echo "$OUTPUT" | grep "Top Issue:" | sed 's/.*Top Issue: //')
        MSG=$(echo "$OUTPUT" | grep "Message:" | sed 's/.*Message: //' | cut -c1-200)
        PROMPT="Fix this issue: ${LABEL}. Details: ${MSG}. Constraints: Surgical edits only. Preserve signatures and docstrings. No except Exception: pass. Do NOT create new files. Edit existing files only. Use proper file paths like 'tests/foo.py' not 'path/to/tests/foo.py'."
        
        FILES=$(echo "$CMD" | sed 's/^aider //' | sed 's/AUTO_BACKLOG.md//g' | sed 's/--read//g' | xargs)

        if [[ -z "$FILES" ]]; then
            log "⏭️ No editable files found, skipping"
            items_skipped=$((items_skipped + 1))
            echo "$(date +%s)|$LABEL|skipped-no-files" >> "$PROGRESS_FILE"
            log "--- Moving to next item ---"
            sleep 1
            continue
        fi

        SUCCESS=false
        for attempt in $(seq 1 $MAX_RETRIES); do
            log "▶️ Attempt $attempt/$MAX_RETRIES: $LABEL"

            # Backup backlog before each Aider call
            cp AUTO_BACKLOG.md AUTO_BACKLOG.md.bak 2>/dev/null || true

            if run_aider_with_prompt "$PROMPT" $FILES; then
                cleanup_garbage
                restore_backlog
                rm -f AUTO_BACKLOG.md.bak

                if verify_changes "$TEST_FILE"; then
                    log "✅ Fix verified on attempt $attempt"
                    items_fixed=$((items_fixed + 1))
                    echo "$(date +%s)|$LABEL|fixed" >> "$PROGRESS_FILE"
                    git add -A 2>/dev/null || true
                    git diff --cached --quiet 2>/dev/null || \
                        git commit -m "auto-fix: ${LABEL}" --no-verify 2>/dev/null || true
                    SUCCESS=true
                    break
                else
                    log "⚠️ Verification failed on attempt $attempt, reverting"
                    git checkout -- . 2>/dev/null || true
                    git clean -fd 2>/dev/null || true
                fi
            else
                log "⚠️ Aider timed out or failed on attempt $attempt"
                git checkout -- . 2>/dev/null || true
                git clean -fd 2>/dev/null || true
                restore_backlog
                rm -f AUTO_BACKLOG.md.bak
            fi

            sleep 2
        done

        if [[ "$SUCCESS" != "true" ]]; then
            log "⏭️ Skipping unfixable item after $MAX_RETRIES attempts"
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
