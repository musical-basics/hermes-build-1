# Refresh Note - 2026-04-10

This refresh updates the sanitized Hermes backup with the current live configuration state from the active Hermes installation.

## What was refreshed
- `config/config.yaml`
  - sanitized current config snapshot
  - secret-like values blanked
- `config/.env.example`
  - environment variable names only
- `memory/MEMORY.md`
- `memory/USER.md`
- `memory/SOUL.md`
- `service/hermes-gateway.service`
- `skills/`
  - updated skills tree from the live Hermes install

## Notable additions in this refresh
- updated Claude Code orchestration skill content
- current DreamPlay / concept-clone workflow preferences in memory
- additional skills present in the live Hermes install, including:
  - `hermes-backup`
  - `second-hermes-instance`

## What remains intentionally excluded
- live secrets and `.env` values
- `state.db`
- runtime process/state JSON files
- pairing data
- caches, logs, screenshots
- project repositories

## Purpose
This repo is a portable, sanitized Hermes configuration backup.
It is not a complete runtime image and not a blind snapshot of all live system state.
