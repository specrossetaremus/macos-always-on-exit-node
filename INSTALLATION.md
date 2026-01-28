# Installation (Recommended)

Follow these steps on the target macOS machine.

Install the script

```sh
sudo install -m 0755 scripts/always-on-caffeinate.sh /usr/local/bin/always-on-caffeinate.sh
```

Install the per-user LaunchAgent

```sh
cp launchd.com.local.always-on-caffeinate.plist ~/Library/LaunchAgents/
```

Load and start the agent

```sh
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/launchd.com.local.always-on-caffeinate.plist
launchctl enable gui/$(id -u)/com.local.always-on-caffeinate
launchctl kickstart -k gui/$(id -u)/com.local.always-on-caffeinate
```

Verify

```sh
pmset -g assertions | grep caffeinate
launchctl print gui/$(id -u)/com.local.always-on-caffeinate
```

Uninstall

```sh
launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/launchd.com.local.always-on-caffeinate.plist || true
rm -f ~/Library/LaunchAgents/launchd.com.local.always-on-caffeinate.plist
sudo rm -f /usr/local/bin/always-on-caffeinate.sh
```

Notes
- For a system-wide daemon, use `/Library/LaunchDaemons` and `launchctl bootstrap system` (requires root).
- This project intentionally keeps installation manual to avoid surprising changes on hosts.
