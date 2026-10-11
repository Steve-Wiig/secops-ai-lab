#!/usr/bin/env bash
# Autonomous Fix Loop: context load → aider → verify → retry or next
set -euo pipefail

# ── Configuration ────────────────────────────────────────────────────────
MAX_RETRIES="${AUTO_FIX_MAX_RETRIES:-2}"
TIMEOUT_SEC="${AUTO_FIX_TIMEOUT_SEC:-300}"
DRY_RUN="${AUTO_FIX_DRY_RUN:-false}"
VERBOSE="${AUTO_FIX_VERBOSE:-true}"
PROGRESS_FORMAT="${AUTO_FIX_PROGRESS_FORMAT:-pipe}"

# Resolve repo root robustly
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

# ── Helpers ──────────────────────────────────────────────────────────────
log() {
    if [[ "$VERBOSE" == "true" ]] || [[ $# -gt 0 && ( "$1" == "🔴"* || "$1" == "🟠"* || "$1" == "🟡"* || "$1" == "🟢"* ) ]]; then
        echo "[$(date +%H:%M:%S)] $*"
    fi
}

cleanup_garbage() {
    # Remove any garbage files Aider creates
    find . -maxdepth 2 \( -name "Let me fix*" -o -name "*.py.bak" -o -name "*.orig" -o -name "*~" \) -delete 2>/dev/null || true
}

# ── Syntax Check ─────────────────────────────────────────────────────────
check_syntax() {
    local f="$1"
    if ! python3 -c "compile(open('$f').read(), '$f', 'exec')" 2>/dev/null; then
        log "❌ Syntax error in $f"
        return 1
    fi
    return 0
}

# ── Verification ─────────────────────────────────────────────────────────
verify_changes() {
    local test_file="$1"
    local parse_ok=0

    # Syntax check on changed .py files (word-split safe)
    while IFS= read -r f; do
        [[ -z "$f" ]] && continue
        if [[ "$f" == *.py ]]; then
            if ! check_syntax "$f"; then
                return 1
            fi
            parse_ok=1
        fi
    done <<< "$(git diff --name-only HEAD 2>/dev/null | grep '\\.py$' || true)"

    # Reject massive rewrites (>200 lines changed = probably not surgical)
    local changed_lines
    changed_lines=$(git diff --stat HEAD 2>/dev/null | tail -1 | grep -oP '\d+(?= insertion)' || echo "0")
    if [[ "$changed_lines" -gt 200 ]]; then
        log "❌ Diff too large (${changed_lines} lines) — rejecting non-surgical change"
        return 1
    fi

    # Run quality gate
    if ! python3 tools/quality_gate.py >/dev/null 2>&1; then
        log "❌ Quality gate failed"
        return 1
    fi

    # Run relevant tests if test file exists
    if [[ -n "$test_file" && -f "$test_file" ]]; then
        if ! timeout 120 python3 -m pytest "$test_file" -q --tb=no 2>/dev/null; then
            log "❌ Tests failed: $test_file"
            return 1
        fi
    fi

    return 0
}

# ── Aider Runner ─────────────────────────────────────────────────────────
run_aider_with_prompt() {
    local prompt="$1"
    shift
    if [[ "$DRY_RUN" == "true" ]]; then
        log "🔍 [dry-run] Would run aider with prompt: $prompt"
        log "🔍 [dry-run] Files: $*"
        return 0
    fi
    timeout "$TIMEOUT_SEC" aider --yes-always --no-git \
        --message "$prompt" "$@" 2>&1 || return 1
}

# ── Progress Tracking ────────────────────────────────────────────────────
log_progress() {
    local status="$1" label="$2"
    if [[ "$DRY_RUN" == "true" ]]; then
        return 0
    fi
    if [[ "${PROGRESS_FORMAT:-json}" == "json" ]]; then
        echo "{\"ts\": \"$(date +%s)\", \"label\": \"$label\", \"status\": \"$status\"}" >> "tools/.auto_fix_progress"
    else
        echo "$(date +%s)|$label|$status" >> "tools/.auto_fix_progress"
    fi
}

# ── Main Loop ────────────────────────────────────────────────────────────
main() {
    log "🔄 AUTONOMOUS FIX LOOP STARTING"
    local items_fixed=0
    local items_skipped=0
    PROGRESS_FILE="tools/.auto_fix_progress"
    : > "$PROGRESS_FILE"

    while true; do
        # Get next issue
        OUTPUT=$(python3 tools/context_loader.py 2>&1)
        echo "$OUTPUT"

        if echo "$OUTPUT" | grep -q "No unchecked issues"; then
            log "✅ All backlog items resolved!"
            break
        fi

        # Extract the aider command
        CMD=$(echo "$OUTPUT" | grep "^aider " | head -1)
        if [[ -z "$CMD" ]]; then
            log "⚠️ No aider command generated, skipping"
            break
        fi

        # Extract source file for test discovery
        SRC=$(echo "$OUTPUT" | grep "Source:" | sed 's/.*Source: //' | tr -d '`')
        TEST_FILE=""
        if [[ -n "$SRC" && "$SRC" == *.py ]]; then
            STEM=$(basename "$SRC" .py)
            CANDIDATE="tests/test_${STEM}.py"
            [[ -f "$CANDIDATE" ]] && TEST_FILE="$CANDIDATE"
        fi

        # Build prompt from top issue
        LABEL=$(echo "$OUTPUT" | grep "Top Issue:" | sed 's/.*Top Issue: //')
        MSG=$(echo "$OUTPUT" | grep "Message:" | sed 's/.*Message: //' | cut -c1-200)

        PROMPT="Fix this issue: ${LABEL}. Details: ${MSG}. Constraints: Surgical edits only. Preserve signatures and docstrings. No except Exception: pass. Do NOT create new files. Edit existing files only."

        # Extract file args from CMD
        FILES=$(echo "$CMD" | sed 's/^aider //')

        SUCCESS=false
        for attempt in $(seq 1 "$MAX_RETRIES"); do
            log "▶️ Attempt $attempt/$MAX_RETRIES: $LABEL"

            if run_aider_with_prompt "$PROMPT" $FILES; then
                cleanup_garbage

                if verify_changes "$TEST_FILE"; then
                    log "✅ Fix verified on attempt $attempt"
                    items_fixed=$((items_fixed + 1))
                    log_progress "fixed" "$LABEL"
                    # Commit (skip in dry-run)
                    if [[ "$DRY_RUN" != "true" ]]; then
                        git add -A 2>/dev/null || true
                        if git diff --cached --quiet 2>/dev/null; then
                            log "ℹ️ No changes to commit"
                        else
                            git commit -m "auto-fix: ${LABEL}" --no-verify 2>/dev/null || true
                        fi
                    fi
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
            fi

            sleep 2
        done

        if [[ "$SUCCESS" != "true" ]]; then
            log "⏭️ Skipping unfixable item after $MAX_RETRIES attempts"
            items_skipped=$((items_skipped + 1))
            log_progress "skipped" "$LABEL"
            # Mark as skipped in backlog so we don't loop forever
            python3 -c "
import re
p = 'AUTO_BACKLOG.md'
c = open(p).read()
# Check off the first unchecked item with skip note
c = re.sub(r'- \[ \] (\*\*.*?\*\*)', r'- [x] \1 *(skipped: auto-fix failed)*', c, count=1)
open(p, 'w').write(c)
" 2>/dev/null || true
        fi

        log "--- Moving to next item ---"
        sleep 1
    done

    log "🏁 FIX LOOP COMPLETE: $items_fixed fixed, $items_skipped skipped"
    rm -f "$PROGRESS_FILE"
}

main "$@"
