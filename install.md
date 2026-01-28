# Installation (Manual)

These steps must be run manually on the target macOS system.
They are intentionally not automated.

## 1. Install the script
sudo cp scripts/always-on-caffeinate.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/always-on-caffeinate.sh

## 2. Install the LaunchAgent
cp launchd.com.local.always-on-caffeinate.plist ~/Library/LaunchAgents/

## 3. Load and start
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents.com.local.always-on-caffeinate.plist
launchctl enable gui/$(id -u)/com.local.always-on-caffeinate
launchctl kickstart -k gui/$(id -u)/com.local.always-on-caffeinate

## 4. Verify
pmset -g assertions | grep caffeinate
launchctl print gui/$(id -u)/com.local.always-on-caffeinate
