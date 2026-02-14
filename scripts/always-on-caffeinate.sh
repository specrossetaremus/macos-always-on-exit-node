#!/usr/bin/env bash

# always-on-caffeinate.sh
# Purpose: run macOS `caffeinate` with flags that prevent sleep
# Intended to be installed to `/usr/local/bin/always-on-caffeinate.sh`

set -euo pipefail

CAFFEINATE_BIN="/usr/bin/caffeinate"
if [[ ! -x "${CAFFEINATE_BIN}" ]]; then
  echo "error: ${CAFFEINATE_BIN} not found or not executable" >&2
  exit 1
fi

# Flags: prevent display, idle system, disk sleep, and system sleep on AC
CAFFEINATE_FLAGS=( -d -i -m -s )

# If a caffeinate process already exists, exit quietly (idempotent)
if /usr/bin/pgrep -x caffeinate >/dev/null 2>&1; then
  exit 0
fi

# Exec into caffeinate so PID is the real caffeinate process for launchd
exec "${CAFFEINATE_BIN}" "${CAFFEINATE_FLAGS[@]}"
