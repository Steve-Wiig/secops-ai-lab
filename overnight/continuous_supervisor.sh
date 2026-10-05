#!/usr/bin/env bash
set -u

cd "$(dirname "$0")/.."

set -a
source .env
set +a

LOG="overnight/continuous_supervisor.log"

cleanup() {
    echo "[$(date)] Supervisor stopping." >> "$LOG"

    if [[ -n "${CHILD_PID:-}" ]] && kill -0 "$CHILD_PID" 2>/dev/null; then
        echo "[$(date)] Stopping child PID $CHILD_PID." >> "$LOG"
        kill "$CHILD_PID" 2>/dev/null || true
        wait "$CHILD_PID" 2>/dev/null || true
    fi

    exit 0
}

trap cleanup INT TERM

echo "============================================================" >> "$LOG"
echo "[$(date)] Continuous supervisor started." >> "$LOG"
echo "============================================================" >> "$LOG"

while true; do

    if [[ "${SKIP_PREFILL:-0}" != "1" ]]; then
    # PHASE 1: Rate limit prefill to stop log spam
    fi
    PREFILL_LAST_RUN=${PREFILL_LAST_RUN:-0}
    CURRENT_TIME=$(date +%s)
    TIME_SINCE_PREFILL=$((CURRENT_TIME - PREFILL_LAST_RUN))
    
    if [[ "${SKIP_PREFILL:-0}" != "1" ]]; then
    if [[ $TIME_SINCE_PREFILL -gt 3600 ]]; then
    fi
        PREFILL_LAST_RUN=$CURRENT_TIME
    else
    if [[ "${SKIP_PREFILL:-0}" != "1" ]]; then
        # Skip prefill this cycle to reduce noise
    fi
    if [[ "${SKIP_PREFILL:-0}" != "1" ]]; then
        SKIP_PREFILL=1
    fi
    fi

    echo "[$(date)] Starting self-improver cycle." >> "$LOG"

    PYTHONUNBUFFERED=1 python3 overnight/self_improver.py --fixes-per-pass 10 >> "$LOG" 2>&1 &
    CHILD_PID=$!

    echo "[$(date)] Child PID: $CHILD_PID" >> "$LOG"

    wait "$CHILD_PID"
    STATUS=$?

    echo "[$(date)] Child exited with status $STATUS." >> "$LOG"

    # Prevent rapid crash/restart loops.
    sleep 30
done
