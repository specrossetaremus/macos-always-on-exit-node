#!/#!/usr/bin/env bash
#
# always-on-caffeinate.sh
#
# Purpose:
#   Force macOS into server-like behavior by preventing all sleep states.
#   Designed for always-on roles (e.g. VPN exit nodes, edge services).
#
# Philosophy:
#   - Uptime > efficiency
#   - Explicit shutdown > idle heuristics
#   - Let hardware enforce thermal safety (SMC untouched)
#

set -euo pipefail

CAFFEINATE_BIN="/usr/bin/caffeinate"

# Flags:
# -d  Prevent display sleep
# -i  Prevent idle system sleep
# -m  Prevent disk sleep
# -s  Prevent system sleep while on AC power
CAFFEINATE_FLAGS=(-d -i -m -s)

# Ensure only one instance exists
if pgrep -x caffeinate >/dev/null; then
  exit 0
fi

exec "${CAFFEINATE_BIN}" "${CAFFEINATE_FLAGS[@]}"
/sh

#  scripts:always-on-caffeinate.sh
#  
#
#  Created by Christopher Quinonez-Leyva on 1/28/26.
#  
