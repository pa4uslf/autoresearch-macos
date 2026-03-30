#!/bin/zsh
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

PID_FILE="${AUTORESEARCH_PID_FILE:-run.pid}"

if [[ ! -f "$PID_FILE" ]]; then
  echo "no pid file"
  exit 0
fi

train_pid="$(<"$PID_FILE")"
if [[ -n "$train_pid" ]] && kill -0 "$train_pid" 2>/dev/null; then
  kill "$train_pid"
  echo "stopped pid=$train_pid"
else
  echo "pid not running: ${train_pid:-unknown}"
fi

rm -f "$PID_FILE"
