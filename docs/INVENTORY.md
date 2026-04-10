
# Hermes disk inventory (absolute paths)

Included in this backup repo

- /root/.hermes/config.yaml -> config/config.yaml (sanitized; secret values removed)
- /root/.hermes/.env -> config/.env.example (keys only; no values)
- /root/.hermes/skills/ -> skills/
- /root/.hermes/memories/MEMORY.md -> memory/MEMORY.md
- /root/.hermes/memories/USER.md -> memory/USER.md
- /root/.hermes/SOUL.md -> memory/SOUL.md
- /root/.config/systemd/user/hermes-gateway.service -> service/hermes-gateway.service

Persistent state discovered on disk

- /root/.hermes/state.db
  - SQLite DB holding session/message history
  - tables present: messages, messages_fts*, sessions, schema_version
  - no standalone todos table found
  - current conclusion: todo/task state is not stored as a separate flat file; durable session history lives here
- /root/.hermes/processes.json
  - background process state / runtime bookkeeping
- /root/.hermes/channel_directory.json
  - platform/channel directory state
- /root/.hermes/gateway_state.json
  - gateway runtime state
- /root/.hermes/pairing/telegram-approved.json
- /root/.hermes/pairing/telegram-pending.json
- /root/.hermes/pairing/whatsapp-approved.json
- /root/.hermes/pairing/whatsapp-pending.json
- /root/.hermes/pairing/_rate_limits.json

Excluded from git backup

- /root/.hermes/.env
  - contains live secrets/tokens
- /root/.config/himalaya/config.toml
  - contains Gmail credentials/app password
- /root/.hermes/node/
  - bundled runtime, reinstall instead of backing up
- /root/.hermes/cache/
  - screenshots/cache artifacts
- /root/.hermes/whatsapp/bridge.log
  - log file
- /root/projects/*
- /root/repos/*
  - project/advisory repos are backed up independently
- /root/.local/bin/himalaya
  - reinstallable dependency, not persistent config
- /root/.hermes/state.db, /root/.hermes/processes.json, /root/.hermes/channel_directory.json, /root/.hermes/gateway_state.json, /root/.hermes/pairing/*
  - intentionally not committed in this first pass to avoid pushing live chat history, runtime state, and approval mappings blindly
  - if desired, these can be exported/encrypted separately

Secret-bearing fields detected

- config.yaml keys with secrets: model.api_key, delegation.api_key, auxiliary.*.api_key, custom_providers[*].api_key
- .env keys found:
- TERMINAL_MODAL_IMAGE
- TERMINAL_TIMEOUT
- TERMINAL_LIFETIME_SECONDS
- BROWSERBASE_PROXIES
- BROWSERBASE_ADVANCED_STEALTH
- BROWSER_SESSION_TIMEOUT
- BROWSER_INACTIVITY_TIMEOUT
- WEB_TOOLS_DEBUG
- VISION_TOOLS_DEBUG
- MOA_TOOLS_DEBUG
- IMAGE_TOOLS_DEBUG
- ANTHROPIC_TOKEN
- ANTHROPIC_API_KEY
- HERMES_MAX_ITERATIONS
- WHATSAPP_ENABLED
- WHATSAPP_MODE
- WHATSAPP_ALLOWED_USERS
- OPENROUTER_API_KEY
- DREAMPLAY_EMAIL_API_KEY
- TELEGRAM_BOT_TOKEN
