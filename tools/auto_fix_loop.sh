#!/usr/bin/env bash
# Autonomous Fix Loop: context load → aider → verify → retry or next
set -euo pipefail

LOCKFILE="/tmp/soc_autopilot_fix_loop.lock"
if [[ -f "$LOCKFILE" ]]; then
    echo "Another fix loop is already running (PID: $(cat "$LOCKFILE"))"
    exit 1
fi
echo $$ > "$LOCKFILE"
trap 'rm -f "$LOCKFILE"; echo "[$(date +%H:%M:%S)] 🛑 Fix loop interrupted"' EXIT INT TERM

cd "$(dirname "$0")/.."

MAX_RETRIES=2
TIMEOUT_SEC=300

log() { echo "[$(date +%H:%M:%S)] $*"; }

run_aider_with_prompt() {
    local prompt="$1"
    shift
    timeout "$TIMEOUT_SEC" aider --yes-always --no-git \
        --message "$prompt" "$@" 2>&1 || return 1
}

verify_changes() {
    # Syntax check first — catch broken files immediately
    local py_files
    py_files=$(git diff --name-only HEAD 2>/dev/null | grep '\\.py$' || true)
    for f in $py_files; do
        if [[ -f "$f" ]] && ! python3 -c "compile(open('$f').read(), '$f', 'exec')" 2>/dev/null; then
            log "❌ Syntax error in $f"
            return 1
        fi
    done
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
    local test_file="$1"
    if [[ -f "$test_file" ]]; then
        if ! timeout 120 python3 -m pytest "$test_file" -q --tb=no 2>/dev/null; then
            log "❌ Tests failed: $test_file"
            return 1
        fi
    fi
    return 0
}

cleanup_garbage() {
    # Remove any garbage files Aider creates
    find . -maxdepth 2 -name "Let me fix*" -delete 2>/dev/null || true
    find . -maxdepth 2 -name "*.py.bak" -delete 2>/dev/null || true
}

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
        for attempt in $(seq 1 $MAX_RETRIES); do
            log "▶️ Attempt $attempt/$MAX_RETRIES: $LABEL"
            
            if run_aider_with_prompt "$PROMPT" $FILES; then
                cleanup_garbage
                
                if verify_changes "$TEST_FILE"; then
                    log "✅ Fix verified on attempt $attempt"
                    items_fixed=$((items_fixed + 1))
                    echo "$(date +%s)|$LABEL|fixed" >> "$PROGRESS_FILE"
                    # Commit
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
            fi
            
            sleep 2
        done
        
        if [[ "$SUCCESS" != "true" ]]; then
            log "⏭️ Skipping unfixable item after $MAX_RETRIES attempts"
            items_skipped=$((items_skipped + 1))
            echo "$(date +%s)|$LABEL|skipped" >> "$PROGRESS_FILE"
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
