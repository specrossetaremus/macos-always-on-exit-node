# macos-always-on-exit-node

Always-on power model for macOS used as a Tailscale exit node.

#Purpose
  macOS defaults are client-biased and will silently break
  VPN routing when idle.
  This repo forces **server semantics**:
- no sleep
- no idle demotion
- no power heuristics reclaiming control

Uptime and routing correctness are prioritized over efficiency.

#What this does
- Runs `caffeinate -d -i -m -s` under launchd
- Disables all sleep paths via `pmset`
- Disables App Nap and timer coalescing
- Keeps Tailscale exit-node routing stable

#Non-goals
- Battery life
- Power efficiency
- Conditional or “smart” sleep logic

If the machine should stop, it should be shut down explicitly.

#Safety
- No kernel patches
- No SMC overrides
- Apple thermal protections remain intact

#Verification
```bash
pmset -g assertions | grep caffeinate
launchctl print gui/$(id -u)/com.local.caffeinate
tailscale status
