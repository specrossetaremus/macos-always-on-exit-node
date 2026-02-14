# macos-always-on-exit-node

Always-on power model for macOS used as a Tailscale exit node.

#Purpose
  macOS defaults are client-biased and will silently break
  VPN routing when idle.
  This repo forces **server semantics**:

Uptime and routing correctness are prioritized over efficiency.

#What this does

#Non-goals

If the machine should stop, it should be shut down explicitly.

#Safety

#Verification
```bash
pmset -g assertions | grep caffeinate
launchctl print gui/$(id -u)/com.local.always-on-caffeinate
tailscale status

 # macos-always-on-exit-node

 Always-on power model for macOS intended for roles like Tailscale exit nodes.

 Key goals:
 - Prevent macOS from idling or sleeping when acting as a network-facing host
 - Keep routing and services stable for long-lived processes

 What this repo provides:
 - A small wrapper script (`scripts/always-on-caffeinate.sh`) that runs `caffeinate`
 - A user `launchd` plist (`launchd.com.local.always-on-caffeinate.plist`) to keep it running
 - Installation and uninstall instructions in `INSTALLATION.md`

 Quick start:

 1. Install the script and plist (see `INSTALLATION.md`)
 2. Bootstrap the LaunchAgent with `launchctl`
 3. Verify with `pmset -g assertions` and `launchctl print` as documented

 Safety & design notes:
 - Does not change firmware / SMC / kernel settings
 - Prioritizes uptime and routing correctness over battery efficiency
 - Apple thermal protections remain in effect

 See `INSTALLATION.md` for full install/uninstall commands and verification steps.
