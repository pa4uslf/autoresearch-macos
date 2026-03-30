#!/bin/zsh
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

PID_FILE="${AUTORESEARCH_PID_FILE:-run.pid}"
LOG_FILE="${AUTORESEARCH_LOG_FILE:-run.log}"

if [[ -f "$PID_FILE" ]]; then
  existing_pid="$(<"$PID_FILE")"
  if [[ -n "$existing_pid" ]] && kill -0 "$existing_pid" 2>/dev/null; then
    echo "training already running with pid $existing_pid"
    exit 0
  fi
  rm -f "$PID_FILE"
fi

: > "$LOG_FILE"

nohup env \
  KMP_DUPLICATE_LIB_OK="${KMP_DUPLICATE_LIB_OK:-TRUE}" \
  OMP_NUM_THREADS="${OMP_NUM_THREADS:-1}" \
  .venv/bin/python train.py >> "$LOG_FILE" 2>&1 &

train_pid="$!"
echo "$train_pid" > "$PID_FILE"
echo "started training pid=$train_pid log=$LOG_FILE"
