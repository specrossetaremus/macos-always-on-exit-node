# Example `tailscale status --json` 

This is a sanitized example of a macOS Tailscale exit node.

## Key points
- `tag:exit-node` allows advertising
- `0.0.0.0/0` and `::/0` enable exit routing
- `Self.ExitNode = false` is expected on the exit node
- `Peer.ExitNode = true` indicates active client routing

This setup assumes the system cannot sleep.
