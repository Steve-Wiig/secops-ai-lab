#!/usr/bin/env bash
set -u

PATCHER_FILE=$(find . -name "multi_file_patcher.py" -type f 2>/dev/null | head -n 1)
LEDGER_FILE=$(find . -name "ledger.py" -type f 2>/dev/null | head -n 1)
AIDER_PROVIDER=$(find . -name "aider_provider.py" -type f 2>/dev/null | head -n 1)

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
PASS_COUNT=0; FAIL_COUNT=0; WARN_COUNT=0

log_pass() { echo -e "${GREEN}[PASS]${NC} $1"; PASS_COUNT=$((PASS_COUNT + 1)); }
log_fail() { echo -e "${RED}[FAIL]${NC} $1"; FAIL_COUNT=$((FAIL_COUNT + 1)); }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; WARN_COUNT=$((WARN_COUNT + 1)); }
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }

echo "========================================================"
echo " soc-autopilot P0 Read-Only Verification (Final)"
echo "========================================================"

log_info "Checking P0.1: Local-Only Inference Fail-Closed..."
CLOUD_URLS=$(grep -rE "api\.openai\.com|api\.anthropic\.com|generativelanguage\.googleapis\.com" . 2>/dev/null | grep -v "verify_p0" | grep -v "^\./overnight/" | grep -v "^\./docs/" | grep -v "^\./tests/" | grep -v "\.bak" | grep -v "\.aider\.chat\.history\.md" | grep -v "run_aider_p0_fix" | grep -v "fix_p0_deterministic" | grep -v "wire_p0_guards" | grep -v "polish_p0_runtime" || true)

if [ -z "$CLOUD_URLS" ]; then
    log_pass "No hardcoded cloud LLM endpoints in core runtime."
else
    log_fail "Hardcoded cloud LLM endpoints in core runtime: $CLOUD_URLS"
fi

if [ -n "$AIDER_PROVIDER" ]; then
    if grep -qE "except.*(ConnectionError|Timeout|LocalModelException).*:|sys\.exit\(1\)|raise.*InferenceFailed" "$AIDER_PROVIDER" 2>/dev/null; then
        log_pass "Fail-closed error handling detected in $AIDER_PROVIDER."
    else
        log_fail "No explicit fail-closed logic found in $AIDER_PROVIDER."
    fi
fi

log_info "Checking P0.2: Patch Mutation Boundary..."
if [ -n "$PATCHER_FILE" ]; then
    if grep -qE "os\.path\.realpath|os\.path\.abspath" "$PATCHER_FILE" 2>/dev/null && grep -qE "startswith|is_relative_to" "$PATCHER_FILE" 2>/dev/null; then
        log_pass "Path traversal protections found in $PATCHER_FILE."
    else
        log_fail "Missing path traversal protections in $PATCHER_FILE."
    fi
    if grep -qE "os\.path\.islink|os\.lstat" "$PATCHER_FILE" 2>/dev/null; then
        log_pass "Symlink escape protection detected in $PATCHER_FILE."
    else
        log_fail "No symlink checks found in $PATCHER_FILE."
    fi
else
    log_fail "Could not auto-detect multi_file_patcher.py."
fi

log_info "Checking P0.3: Strict Human Gates..."
AUTO_MERGE=$(grep -rE "^[^#]*subprocess\.run\(\[.*git.*merge|^[^#]*subprocess\.run\(\[.*git.*push|^[^#]*auto_merge\s*=\s*True" . 2>/dev/null | grep -v "verify_p0" | grep -v "^\./tests/" || true)
if [ -z "$AUTO_MERGE" ]; then
    log_pass "No active automated git merge/push commands found."
else
    log_fail "Active automated git merge/push commands detected: $AUTO_MERGE"
fi

if [ -n "$LEDGER_FILE" ]; then
    if grep -qE "human_verified|requires_merge|status.*==.*'human_review'" "$LEDGER_FILE" 2>/dev/null; then
        log_pass "Ledger enforces human verification gates ($LEDGER_FILE)."
    else
        log_fail "No explicit human gate found in $LEDGER_FILE."
    fi
else
    log_warn "Could not auto-detect ledger.py."
fi

echo ""
echo "========================================================"
echo " Summary: ${GREEN}Pass: $PASS_COUNT${NC} | ${RED}Fail: $FAIL_COUNT${NC} | ${YELLOW}Warn: $WARN_COUNT${NC}"
echo "========================================================"
[ "$FAIL_COUNT" -gt 0 ] && echo -e "${RED}ACTION REQUIRED${NC}" || echo -e "${GREEN}ALL P0 CHECKS PASSED${NC}"
