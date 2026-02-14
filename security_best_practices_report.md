# Security Best Practices Report

## Executive Summary

This repository is a small macOS LaunchAgent wrapper around `caffeinate` (Bash + `launchd` plist). There is no Node/TypeScript/Python/Go application code to review, so the best-practices guidance below focuses on safe shell scripting and safe `launchd` usage.

Key outcomes from this review:

- The `always-on-caffeinate` script uses absolute paths for system binaries (reduces PATH-hijack risk).
- The LaunchAgent plist no longer logs to fixed paths in `/tmp` (avoids avoidable log-file clobber/symlink pitfalls).
- Install docs and the repo security policy were corrected.

## Scope / Stack

- Bash script: `scripts/always-on-caffeinate.sh`
- LaunchAgent plist: `launchd.com.local.always-on-caffeinate.plist`
- Installation docs: `INSTALLATION.md`, `install.md`, `README.md`

Notes on skill references:

- The `security-best-practices` skill reference set in `/home/ayopausesir/.codex/skills/security-best-practices/references/` covers Python/Go and common JS web frameworks, but not Bash or `launchd`, so this report uses general Unix/macOS secure-default guidance instead.

## Findings

### Medium

**MED-1: Avoid PATH-based resolution for privileged or security-relevant binaries**

- Impact: If execution environment `PATH` is compromised, a different binary than intended could be invoked.
- Status: Fixed by pinning to `/usr/bin/caffeinate` and `/usr/bin/pgrep`.
- Evidence:
  - `scripts/always-on-caffeinate.sh:9` uses `CAFFEINATE_BIN="/usr/bin/caffeinate"`.
  - `scripts/always-on-caffeinate.sh:19` uses `/usr/bin/pgrep ...`.

### Low

**LOW-1: Avoid writing LaunchAgent logs to predictable paths in `/tmp`**

- Rationale: Predictable `/tmp` paths are easy to pre-create or manipulate on multi-user systems, and can cause confusion or undesirable file clobbering. (Risk is limited here because a LaunchAgent runs as the logged-in user, but it is still a sharp edge.)
- Status: Fixed by removing `StandardOutPath` / `StandardErrorPath` from the plist.
- Evidence:
  - `launchd.com.local.always-on-caffeinate.plist:9` to `launchd.com.local.always-on-caffeinate.plist:20` no longer include these keys.

**LOW-2: Installation docs still include a `sudo cp` variant**

- Rationale: `install` is generally safer than `cp` because it sets permissions atomically and predictably.
- Recommendation: Prefer the `install -m 0755 ...` command in `INSTALLATION.md:8`, and consider aligning `install.md:7` to use `install -m 0755` as well.
- Evidence:
  - `INSTALLATION.md:8` uses `sudo install -m 0755 ...` (preferred).
  - `install.md:7` uses `sudo cp ...` (works, but less strict).

**LOW-3: Ensure `/usr/local/bin/always-on-caffeinate.sh` remains root-owned and not writable by untrusted users**

- Rationale: The LaunchAgent executes `/usr/local/bin/always-on-caffeinate.sh` (`launchd.com.local.always-on-caffeinate.plist:11`). If that path becomes writable by other users, it becomes an easy persistence vector (as the logged-in user).
- Recommendation: Keep ownership `root:wheel` and mode `0755` (or stricter), consistent with `INSTALLATION.md:8`.

## Additional Hardening Suggestions (Optional)

- Consider adding a short note to `INSTALLATION.md` about verifying file ownership/permissions on `/usr/local/bin/always-on-caffeinate.sh` after installation.
- If you ever convert this from a per-user LaunchAgent to a system-wide LaunchDaemon (root), re-review all file paths, logging, and PATH assumptions (root context increases impact).

