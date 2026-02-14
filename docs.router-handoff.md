
# Router Handoff: When to Remove Always-On Caffeinate

# Context
This repository forces macOS into server-like behavior to support
always-on roles (e.g. VPN exit nodes).

This is a **temporary infrastructure role** when macOS is acting as the edge.

# When this script is no longer needed
Remove the always-on caffeinate setup when:
- Exit-node routing is moved to a dedicated router (e.g. GL.iNet)
- The router advertises `0.0.0.0/0` and `::/0`
- Clients route through the router directly
- macOS is no longer a routing dependency

At that point, macOS can safely return to client power semantics.

# Decommission steps
```bash
launchctl bootout gui/$(id -u)/com.local.always-on-caffeinate
rm ~/Library/LaunchAgents/com.local.always-on-caffeinate.plist
rm /usr/local/bin/always-on-caffeinate.sh
#  > Note  
> This script may still be useful even after router handoff for:
> - local AI workloads
> - sustained compute tasks
> - infrastructure or service roles where macOS must behave as an always-on node
>
> With this setup, the user—not the OS—decides when power efficiency applies.
