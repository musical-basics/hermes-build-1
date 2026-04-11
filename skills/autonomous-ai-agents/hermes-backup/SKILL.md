---
name: hermes-backup
description: Inventory a live Hermes installation on disk and create a sanitized backup repo of config, skills, memory, and restore scripts without leaking secrets or blindly committing runtime state.
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [hermes, backup, configuration, skills, memory, recovery, migration]
    related_skills: [hermes-agent, github-repo-management]
---

# Hermes Backup

Use this when you need to back up or migrate a live Hermes installation to a Git repo.

Goal:
- capture portable Hermes configuration and memory
- exclude secrets and reinstallable runtime artifacts
- avoid blindly pushing live session/runtime state
- leave a clear restore path on a new machine

## What to inventory first

Start by inspecting the real Hermes home and related config paths. On this machine the key locations were:

- `/root/.hermes/config.yaml`
- `/root/.hermes/.env`
- `/root/.hermes/skills/`
- `/root/.hermes/memories/MEMORY.md`
- `/root/.hermes/memories/USER.md`
- `/root/.hermes/SOUL.md`
- `/root/.hermes/state.db`
- `/root/.hermes/processes.json`
- `/root/.hermes/channel_directory.json`
- `/root/.hermes/gateway_state.json`
- `/root/.hermes/pairing/`
- `/root/.config/systemd/user/hermes-gateway.service`
- `/root/.config/himalaya/config.toml`

Also check whether Hermes runtime was installed under something like:
- `/root/.hermes/hermes-agent`
- `/root/.hermes/node`

Those are usually reinstallable runtime/code, not backup targets.

## Important findings from a real backup

For this Hermes install:
- durable conversation history lived in `/root/.hermes/state.db`
- SQLite tables present were:
  - `messages`
  - `messages_fts*`
  - `sessions`
  - `schema_version`
- there was **no standalone `todos` table**
- so todo/task state was not a separate flat file or dedicated DB table in this setup

Do not assume old docs are correct about paths like `~/.hermes/sessions/` or `~/.hermes/logs/` — inspect the live disk layout instead.

## What to commit vs exclude

### Safe to include in a sanitized backup repo

- sanitized copy of `config.yaml` with all API keys/tokens/password-like fields blanked
- `.env.example` containing env var names only, never values
- full `skills/` tree
- `MEMORY.md`, `USER.md`, `SOUL.md`
- service files like `hermes-gateway.service`
- docs explaining what was included/excluded
- setup/restore scripts

### Exclude from git by default

- `.env`
- email client configs containing credentials (example: `/root/.config/himalaya/config.toml`)
- bundled runtime dirs like `/root/.hermes/node/`
- caches and screenshots under `/root/.hermes/cache/`
- logs like `/root/.hermes/whatsapp/bridge.log`
- project repos under `/root/projects/*` and `/root/repos/*`
- live state files unless you intentionally want an encrypted state snapshot:
  - `state.db`
  - `processes.json`
  - `channel_directory.json`
  - `gateway_state.json`
  - `pairing/*`

Reason: these often contain sensitive conversation history, runtime state, approval mappings, or secrets.

## Recommended repo layout

```text
hermes-build/
  README.md
  .gitignore
  config/
    config.yaml
    .env.example
  memory/
    MEMORY.md
    USER.md
    SOUL.md
  skills/
  service/
    hermes-gateway.service
  docs/
    INVENTORY.md
  scripts/
    setup.sh
    export_live_state.sh
```

## Procedure

1. Inventory the live installation
- list files under Hermes home, memories, skills, pairing, and relevant config dirs
- inspect `config.yaml`
- inspect any service unit files
- inspect `state.db` schema before deciding what to back up

2. Identify secrets
- in YAML, blank keys like `api_key`, `token`, `secret`, `password`, and provider-specific variants
- in `.env`, export only variable names into `.env.example`
- do not commit Gmail/Himalaya config if it contains credentials

3. Build a sanitized backup repo
- clone or init the target repo
- copy skills tree
- copy memories
- write sanitized `config/config.yaml`
- write `config/.env.example`
- copy service file(s)
- write `docs/INVENTORY.md` with absolute paths and include/exclude decisions
- add `scripts/setup.sh` to restore sanitized config into `$HERMES_HOME`
- add `scripts/export_live_state.sh` for optional encrypted state export

4. Verify before pushing
- run a secret scan over tracked files
- manually inspect sanitized config and inventory docs
- confirm no live tokens, API keys, or app passwords appear in tracked files

5. Push only the sanitized backup
- commit with a message like:
  - `feat: add sanitized Hermes config backup`

## Suggested setup.sh behavior

A practical restore script should:
- create `$HERMES_HOME`, `$HERMES_HOME/memories`, `$HERMES_HOME/skills`
- copy in sanitized config and memory files
- sync `skills/` into Hermes home
- install/copy the user service file
- create `.env` from `.env.example` if missing
- print next steps instead of pretending secrets/runtime are already restored

## Suggested export_live_state.sh behavior

If full disaster recovery is needed, export these to a separate directory:
- `/root/.hermes/state.db`
- `/root/.hermes/processes.json`
- `/root/.hermes/channel_directory.json`
- `/root/.hermes/gateway_state.json`
- `/root/.hermes/pairing/`

Then encrypt that export before storing it anywhere.

## Pitfalls

- Do not assume Hermes stores sessions in flat files; inspect `state.db`
- Do not commit `.env` even to a private repo
- Do not commit `himalaya/config.toml` if it contains Gmail credentials/app passwords
- Do not back up bundled runtimes (`node`, virtualenvs, binaries) as if they were config
- Do not include project repos in the Hermes backup repo
- Do not blindly commit `pairing/*.json`; they can contain approval/account mappings

## Verification checklist

Before pushing, confirm:
- `config/config.yaml` has blanked secret fields
- `config/.env.example` contains only keys, not values
- no app passwords or bot tokens appear in tracked files
- inventory doc names the real absolute paths on disk
- restore script points to `$HERMES_HOME`, not hardcoded assumptions unless explicitly intended
