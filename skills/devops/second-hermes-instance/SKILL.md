---
name: second-hermes-instance
description: Set up a second isolated Hermes Agent instance on the same Linux host using a separate Unix user, separate checkout, separate HERMES_HOME, and a staged systemd service.
version: 1.0.0
author: Hermes Agent
---

# Second Hermes Instance

Use this when adding a second Hermes bot (for example a PA bot) to a machine that already runs a primary Hermes instance.

## Recommended pattern
Prefer full isolation:
- separate Unix user
- separate repo checkout
- separate venv
- separate `HERMES_HOME`
- separate Telegram bot token
- no shared WhatsApp account/session

Do **not** reuse the same Telegram bot token across two Hermes processes.
Do **not** enable WhatsApp on the second instance unless it has its own isolated account/session.

## Preflight
1. Inspect the current install first:
   - `which hermes`
   - `readlink -f $(which hermes)`
   - `systemctl status hermes-gateway.service --no-pager -l || true`
   - `ps -ef | grep -i '[h]ermes'`
   - `free -h && swapon --show && df -h / /home`
2. Read the current install instructions from the live repo:
   - `read_file /root/.hermes/hermes-agent/README.md`
3. If the host is small (for example ~4 GB RAM), add swap before installing a second instance.

## Swap on small VPSes
On a ~4 GB box, a safe first move is a 4 GB swapfile:
```bash
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
printf '/swapfile none swap sw 0 0\n' >> /etc/fstab
swapon --show
free -h
```
Check `/etc/fstab` first so you do not duplicate the line.

## Install the second instance (recommended isolated-user flow)
1. Create the user:
```bash
adduser --disabled-password --gecos '' hermes-pa
```
2. Clone Hermes as that user:
```bash
su - hermes-pa -c 'git clone https://github.com/NousResearch/hermes-agent.git /home/hermes-pa/hermes-agent'
```
3. Install `uv` as that user:
```bash
su - hermes-pa -c 'curl -LsSf https://astral.sh/uv/install.sh | sh'
```
4. Create venv + install Hermes:
```bash
su - hermes-pa -c 'export PATH=/home/hermes-pa/.local/bin:$PATH && cd /home/hermes-pa/hermes-agent && uv venv venv --python 3.11 && . venv/bin/activate && uv pip install -e ".[all]"'
```

## Create isolated PA state/config
Seed a separate Hermes home, for example:
- `/home/hermes-pa/.hermes/config.yaml`
- `/home/hermes-pa/.hermes/.env`
- `/home/hermes-pa/.hermes/SOUL.md`

Start from a copy of the main instance config, then restrict aggressively.

### Minimum PA changes
- New `TELEGRAM_BOT_TOKEN`
- New `TELEGRAM_ALLOWED_USERS`
- New/empty `TELEGRAM_HOME_CHANNEL` until first message arrives
- `WHATSAPP_ENABLED=false`
- clear any WhatsApp-specific state/channel values
- use a PA-specific identity/persona in `SOUL.md`

### Tool restriction pattern
For a PA-only bot, restrict toolsets to a small allowlist such as:
- `web`
- `browser`
- `vision`
- `skills`
- `todo`
- `memory`
- `session_search`
- `clarify`
- `tts`

Do **not** enable for the PA bot:
- `terminal`
- `process`
- `file`
- `execute_code`
- `delegate_task`
- coding-oriented orchestration

If using config-level platform toolsets, set both top-level `toolsets` and `platform_toolsets.telegram` to the restricted list.

## PA identity file
Write a `SOUL.md` that explicitly says:
- this is Hermes PA
- no coding work
- no terminal/process/file actions even if asked
- no Claude Code orchestration
- do not access coding repos unless explicitly told to hand work back to the coding bot

## Manual test before systemd
Do **not** skip this.

Run manually as the new user first:
```bash
su - hermes-pa
export HERMES_HOME=/home/hermes-pa/.hermes
export PATH=/home/hermes-pa/hermes-agent/venv/bin:/home/hermes-pa/.local/bin:$PATH
cd /home/hermes-pa/hermes-agent
/home/hermes-pa/hermes-agent/venv/bin/python -m hermes_cli.main gateway run --replace
```
Then message the new Telegram bot and verify:
- it responds
- it has the intended identity
- it does **not** expose coding tools
- no WhatsApp conflict appears

Only after manual verification should you enable the service.

## systemd unit template
Create `/etc/systemd/system/hermes-pa.service`:
```ini
[Unit]
Description=Hermes PA Agent
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=hermes-pa
Group=hermes-pa
WorkingDirectory=/home/hermes-pa/hermes-agent
Environment="HOME=/home/hermes-pa"
Environment="USER=hermes-pa"
Environment="LOGNAME=hermes-pa"
Environment="HERMES_HOME=/home/hermes-pa/.hermes"
Environment="PATH=/home/hermes-pa/hermes-agent/venv/bin:/home/hermes-pa/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ExecStart=/home/hermes-pa/hermes-agent/venv/bin/python -m hermes_cli.main gateway run --replace
Restart=on-failure
RestartSec=10
MemoryHigh=800M
MemoryMax=1G
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
```
Then:
```bash
systemctl daemon-reload
systemctl enable hermes-pa
systemctl start hermes-pa
systemctl status hermes-pa --no-pager -l
journalctl -u hermes-pa -f
```

## Findings worth remembering
- A host can show `hermes-gateway.service` as enabled but still be running a manually started gateway process.
- A prior WhatsApp session can cause systemd startup failure with a conflict like: another local Hermes gateway is already using this WhatsApp session.
- On the second instance, disable WhatsApp unless you explicitly provision a separate WhatsApp identity/session.
- If the user pivots platforms mid-setup (for example Telegram -> Discord -> WhatsApp), treat that as a configuration rewrite task, not a reason to start services early. Keep the second instance dormant until the messaging platform choice is settled.
- Copying the primary bot's WhatsApp env/session into a second isolated checkout is not enough by itself. A manual PA gateway run can still fail with `WhatsApp: Node.js not installed or bridge not configured` / `No adapter available for whatsapp`. That means you must verify the bridge/tooling in the second checkout before promising a WhatsApp cutover.
- If the user wants to move the existing WhatsApp identity from the coding bot to the PA bot, the safest sequence is: update config files only, do **not** restart the primary gateway yet, and stop immediately if the user worries about losing Telegram connectivity. Preserve the live primary process until the user explicitly approves a maintenance window.
- The safe stopping point is: install complete, config skeleton complete, service file staged, but **do not start** until the chosen platform credential/session is available and the manual test has passed.

## Verification checklist
- `id hermes-pa`
- `ls -la /home/hermes-pa/hermes-agent`
- `ls -la /home/hermes-pa/.hermes`
- `free -h`
- `swapon --show`
- manual gateway run works with the new Telegram token
- `systemctl status hermes-pa`
- no shared-token/shared-session conflicts with the primary bot

## Pitfalls
- Do not start the second instance with the first bot's Telegram token.
- Do not enable systemd before manual validation.
- Do not leave PA toolsets as `hermes-telegram` if you want a restricted assistant; that preset includes the full core tool list.
- Do not let the PA instance inherit the primary bot's WhatsApp session settings.
- When Hermes itself is running as root on the same machine, be extra conservative with `/etc/systemd/`, user creation, and ownership changes.