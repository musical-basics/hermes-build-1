# hermes-build-1

Sanitized backup of Hermes configuration, skills, memory, and restore scripts.

What is included
- Sanitized Hermes config
- `.env.example` with key names only
- Full `skills/` tree
- Memory files (`MEMORY.md`, `USER.md`, `SOUL.md`)
- systemd user service file
- Inventory of live Hermes paths and backup decisions
- Setup/restore script
- Separate helper script to export live state for encrypted backup

What is intentionally not committed
- Live secrets (`/root/.hermes/.env`, secret values in config)
- Live chat/session DB (`/root/.hermes/state.db`)
- Runtime/process state JSON files
- Pairing approval maps
- Bundled Node/runtime/cache/logs
- Project repos under `/root/projects` and `/root/repos`

Why state.db is excluded
- It contains durable session/message history and possibly sensitive conversation data.
- This repo is for portable Hermes configuration and memory, not blind snapshots of every live conversation.
- If you want it backed up too, use `scripts/export_live_state.sh` and encrypt the result before storage.
