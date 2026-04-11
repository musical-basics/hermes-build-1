# INVENTORY

Generated from live Hermes install on disk.

## Live source paths
- /root/.hermes/config.yaml
- /root/.hermes/.env
- /root/.hermes/skills
- /root/.hermes/memories/MEMORY.md
- /root/.hermes/memories/USER.md
- /root/.hermes/SOUL.md
- /root/.config/systemd/user/hermes-gateway.service

## Included in this repo
- Sanitized config at `config/config.yaml`
- Env var names only at `config/.env.example`
- Full `skills/` tree
- Memory files in `memory/`
- Gateway service file in `service/`

## Excluded from git
- Live secrets and .env values
- state.db
- runtime/process state JSON files
- pairing data
- caches/logs/screenshots
- bundled runtimes and project repos

## Notes
- Secret-like config values were blanked before writing `config/config.yaml`.
- `.env.example` contains variable names only, not values.
- This is a sanitized configuration backup, not a full runtime snapshot.
