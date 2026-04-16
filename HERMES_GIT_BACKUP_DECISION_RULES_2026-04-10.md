# Hermes Git Backup Decision Rules

Use this file as a practical guide for deciding what a Hermes backup repo should push to Git and what it should exclude.

## Core principle
Push only what is:
- portable
- reusable
- safe to store in Git
- helpful for restoring Hermes on another machine

Do not push what is:
- secret
- machine-specific runtime state
- sensitive conversation history
- temporary cache/log/process output

## The decision rule
Before pushing any file, ask:

1. Does this help recreate or understand the Hermes setup later?
2. Is it safe if it lives in Git?
3. Is it stable configuration rather than temporary runtime state?
4. Would I want this copied onto a fresh machine?

If the answer is mostly yes:
- include it

If the answer is mostly no:
- exclude it

## Safe to push
These are usually good Git backup candidates.

### 1. Sanitized config
Examples:
- `config.yaml` with API keys/tokens/passwords blanked
- model/provider settings
- display preferences
- tool configuration
- non-secret Hermes behavior settings

Rule:
- push only sanitized config, never raw live secrets

### 2. `.env.example`
Include:
- environment variable names only

Example:
```env
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
TELEGRAM_BOT_TOKEN=
```

Do not include:
```env
OPENAI_API_KEY=real_secret_here
```

### 3. Skills
Usually safe and high value.

Examples:
- `skills/`
- skill references
- templates
- helper scripts that do not contain secrets

Why:
- skills are procedural knowledge and are exactly the kind of thing Git should preserve

### 4. Memory files and user profile files
Examples:
- `MEMORY.md`
- `USER.md`
- `SOUL.md`

Why:
- these help recreate Hermes behavior and persistent context

Caution:
- read them before pushing if they may contain anything overly sensitive

### 5. Service files / restore docs / setup scripts
Examples:
- systemd service file
- install/setup script
- restore script
- inventory markdown
- backup notes

Why:
- these are part of the reproducible setup

## Do NOT push
These are usually bad Git backup candidates.

### 1. Raw secrets
Never push:
- `.env`
- unsanitized config with real API keys
- email app passwords
- bot tokens
- webhook secrets
- PATs / GitHub tokens

### 2. Conversation/session databases
Examples:
- `state.db`
- chat history databases
- transcript stores

Why:
- sensitive
- large
- not needed for normal restore

### 3. Runtime state files
Examples:
- `processes.json`
- `gateway_state.json`
- `channel_directory.json`
- pairing approval maps

Why:
- these represent current live state, not durable reusable config
- often machine- or session-specific

### 4. Logs, caches, screenshots, temp files
Examples:
- `cache/`
- `logs/`
- screenshots
- temporary exports
- generated build artifacts

Why:
- noise
- not portable
- often large and unstable

### 5. Bundled runtimes and local project repos
Examples:
- embedded Node/Python runtime folders
- virtual environments
- cloned project repos
- local workspaces unrelated to Hermes config itself

Why:
- reinstallable
- huge
- not configuration

## Practical include/exclude examples

### Include
- sanitized `config/config.yaml`
- `config/.env.example`
- `skills/`
- `memory/MEMORY.md`
- `memory/USER.md`
- `memory/SOUL.md`
- `service/hermes-gateway.service`
- `docs/INVENTORY.md`
- `docs/REFRESH_NOTE_*.md`
- restore/setup scripts

### Exclude
- `.env`
- `state.db`
- `processes.json`
- `gateway_state.json`
- `pairing/`
- `cache/`
- `logs/`
- `node/`
- `venv/`
- random project repos

## Best workflow for another Hermes bot
When building its backup repo, the bot should:

1. Inspect the live Hermes directories
2. Identify config, memory, skills, and service files
3. Sanitize secrets before writing anything to the repo
4. Generate `.env.example` from variable names only
5. Copy safe files into a backup repo structure
6. Write an inventory note listing:
   - source paths
   - included files
   - excluded files
   - reason for exclusions
7. Run a quick secret sanity check before pushing
8. Commit and push only the sanitized backup

## Simple rule of thumb
If the file is one of these, it usually belongs in Git:
- configuration
- memory
- skills
- setup instructions
- restore instructions

If the file is one of these, it usually does NOT belong in Git:
- secrets
- chats
- runtime state
- caches/logs
- machine-local artifacts

## If you need full disaster recovery
Do not turn the Git repo into a raw runtime dump.
Instead:
- keep Git sanitized
- create a separate encrypted archive for:
  - databases
  - runtime state
  - pairing data
  - any sensitive operational files

That gives you:
- a clean portable Git backup
- a separate disaster-recovery snapshot when needed

## Recommended one-line policy
Git repo = sanitized, portable Hermes configuration backup.
Full runtime snapshot = separate encrypted export, not normal Git content.
