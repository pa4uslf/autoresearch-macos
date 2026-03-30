#!/bin/zsh
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

PID_FILE="${AUTORESEARCH_PID_FILE:-run.pid}"
LOG_FILE="${AUTORESEARCH_LOG_FILE:-run.log}"
TAIL_LINES="${TAIL_LINES:-40}"

if [[ -f "$PID_FILE" ]]; then
  train_pid="$(<"$PID_FILE")"
  if [[ -n "$train_pid" ]] && kill -0 "$train_pid" 2>/dev/null; then
    echo "status=running pid=$train_pid"
  else
    echo "status=stopped stale_pid=${train_pid:-unknown}"
  fi
else
  echo "status=stopped pid=missing"
fi

if [[ -f "$LOG_FILE" ]]; then
  echo "--- tail $LOG_FILE ---"
  tail -n "$TAIL_LINES" "$LOG_FILE"
else
  echo "log_missing=$LOG_FILE"
fi
