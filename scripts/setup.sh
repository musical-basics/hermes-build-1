#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT=$(cd "$(dirname "$0")/.." && pwd)
HERMES_HOME=${HERMES_HOME:-/root/.hermes}

mkdir -p "$HERMES_HOME"
mkdir -p "$HERMES_HOME/memories"
mkdir -p "$HERMES_HOME/skills"
mkdir -p /root/.config/systemd/user

cp "$REPO_ROOT/config/config.yaml" "$HERMES_HOME/config.yaml"
cp "$REPO_ROOT/memory/MEMORY.md" "$HERMES_HOME/memories/MEMORY.md"
cp "$REPO_ROOT/memory/USER.md" "$HERMES_HOME/memories/USER.md"
cp "$REPO_ROOT/memory/SOUL.md" "$HERMES_HOME/SOUL.md"
rsync -a --delete "$REPO_ROOT/skills/" "$HERMES_HOME/skills/"
cp "$REPO_ROOT/service/hermes-gateway.service" /root/.config/systemd/user/hermes-gateway.service

if [ ! -f "$HERMES_HOME/.env" ]; then
  cp "$REPO_ROOT/config/.env.example" "$HERMES_HOME/.env"
  echo "Created $HERMES_HOME/.env from template; fill in real secret values before starting Hermes."
fi

echo "Restored sanitized Hermes config/skills/memory into $HERMES_HOME"
echo "Next: install Hermes runtime/CLI dependencies, fill $HERMES_HOME/.env, then systemctl --user daemon-reload && systemctl --user enable --now hermes-gateway"
