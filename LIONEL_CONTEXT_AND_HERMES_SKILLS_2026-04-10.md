# Lionel Context and Hermes Skills

Generated: 2026-04-10
Repo context: /home/claude/projects/dreamplay-shop-2

## 1) What Hermes knows about Lionel

### Identity and working style
- Name: Lionel Yu
- Primary communication channel in this session: Telegram
- Preference: short status summaries instead of long raw tool or agent dumps
- Preference: when asking for review after a push, always include the live URL
- Preference: for obvious UI regressions, make the smallest safe direct fix first
- Preference: if something is badly broken, revert to the last known-good state first, then apply a narrow fix

### Coding workflow preferences
- Small, scoped fixes should usually be done directly by Hermes with immediate verify/commit/push
- Larger feature work, broad UI fidelity passes, new pages, or multi-file restructures should usually go to Claude Code first
- For major delegated work, Lionel wants to review the exact Claude Code prompt before it is sent
- Default Claude Code model preference: Sonnet, unless Lionel explicitly asks for Opus
- Lionel prefers Hermes to orchestrate Claude Code via tmux for complex tasks
- For large Claude Code runs, use `/permissions bypassPermissions` when applicable to reduce interaction overhead

### Repo targeting / safety preference
- For current DreamPlay website UI/fidelity work, default to the DreamPlay shop repo (`dreamplay-shop-2`) unless Lionel explicitly says otherwise
- Avoid risky changes that could disrupt the current Telegram Hermes connection

## 2) DreamPlay company / site context Hermes currently knows

### Brand positioning
- DreamPlay positioning should center on:
  - narrow-key / ergonomic keyboard sizing
  - small hands
  - reduced strain / pain reduction
  - easier, freer playing
- Known sizing language to preserve:
  - DS 5.5
  - DS 6.0
- DreamPlay metadata positioning currently aligned around:
  - DreamPlay Pianos
  - narrow-key digital pianos
  - small hands
  - reducing strain and helping pianists play freely

### Product line rules
- DreamPlay One and DreamPlay Pro must be clearly distinguished
- Gold color is only for DreamPlay Pro
- DreamPlay One should not be merchandised with the gold finish
- Current merchandising logic Hermes is using:
  - DreamPlay One = core model
  - DreamPlay Pro = premium model
  - Gold = Pro only

### Site / IA preferences
- Resources group should contain:
  - Our Story
  - Our Journal
  - FAQ
  - Build Your Bundle
- Features group should contain:
  - Features
  - Piano Guides
  - Comparison Charts

### Current DreamPlay shop work themes
- Use real assets whenever possible
- Keep CTA alignment tight and intentional
- Favor DreamPlay-specific product merchandising over generic template ecommerce language
- Preserve One vs Pro distinction consistently across shop and bundle experiences

## 3) Website/project state relevant to current work

### Active project
- DreamPlay shop repo: `/home/claude/projects/dreamplay-shop-2`
- Live URL: `https://dreamplay-shop-2.vercel.app`

### Recent UI work completed in this repo
- Header/nav text updated to white over hero states where appropriate
- Collections page hero cleaned up
- Hero copy handling updated so on key pages:
  - breadcrumb + large title are on the hero image
  - descriptive supporting copy is below the hero image
- Build Your Bundle merchandising tightened to better match DreamPlay catalog logic

### Current key routes
- `/shop`
- `/collections`
- `/features`
- `/our-story`
- `/faq`
- `/build-your-bundle`
- `/contact`

## 4) Email / company tooling context Hermes knows

### DreamPlay Email platform
- DreamPlay Email API base URL: `https://dreamplay-email-2.vercel.app`
- Hermes has a DreamPlay email skill for campaign/subscriber/email platform tasks

### Lionel email setup Hermes knows
- Himalaya email setup is complete for: `lionel@musicalbasics.com`
- Binary path: `~/.local/bin/himalaya`
- Config path: `~/.config/himalaya/config.toml`
- Account name: `musicalbasics`
- Existing Gmail folders known:
  - INBOX
  - Notes
  - airbnb
  - ✔
  - ✔✔
  - standard Gmail folders
- Airbnb folder already exists and Lionel previously moved Airbnb emails there manually
- Gmail auto-filter setup was still pending because it requires browser access plus Gmail password

## 5) Hermes skills snapshot

Current available skills: 84 total

### DreamPlay-specific / most relevant right now
- `dreamplay-email` — control Lionel's DreamPlay Email marketing platform
- `dreamplay-site-target-verification` — verify correct DreamPlay repo/remote/live URL before editing when similar projects exist
- `shopify-concept-clone` — build/fidelity-clone workflow for the Concept-style reference site
- `nav-dropdown-implementation` — implement Concept-style dropdown behavior
- `requesting-code-review` — pre-commit verification pipeline
- `writing-plans` — create detailed implementation plans
- `systematic-debugging` — structured debugging workflow
- `subagent-driven-development` — structured multi-task development workflow
- `claude-code` — delegate coding work to Claude Code
- `claude-code-orchestrator` — Hermes as I/O router, Claude does implementation thinking

### Skill categories Hermes currently has
- autonomous-ai-agents
- creative
- data-science
- devops
- email
- gaming
- github
- leisure
- mcp
- media
- mlops
- note-taking
- productivity
- red-teaming
- research
- smart-home
- social-media
- software-development
- web-development

### Notable skills by category

#### Autonomous AI agents
- claude-code
- claude-code-orchestrator
- codex
- hermes-agent
- hermes-backup
- opencode

#### Devops / operations
- cron-debugging
- second-hermes-instance
- theme-animation-extraction
- webhook-subscriptions

#### Email
- email-inbox-triage-himalaya
- himalaya
- dreamplay-email

#### GitHub / software delivery
- github-auth
- github-code-review
- github-issues
- github-pr-workflow
- github-repo-management
- codebase-inspection
- repo-split-and-remote-repoint

#### Research / content / docs
- arxiv
- blogwatcher
- llm-wiki
- polymarket
- research-paper-writing
- obsidian
- notion
- google-workspace
- powerpoint
- ocr-and-documents

#### Web / software development
- dreamplay-site-target-verification
- plan
- requesting-code-review
- shopify-concept-clone
- subagent-driven-development
- systematic-debugging
- test-driven-development
- writing-plans
- nav-dropdown-implementation

## 6) Practical rules Hermes should keep following for Lionel
- Use the correct repo first; verify target before editing when there are similar projects
- Keep fixes narrow and reviewable
- Verify with a build before saying work is done
- Push after successful verification when doing direct small fixes
- Include the live URL when asking Lionel to review something
- Keep DreamPlay One vs Pro distinction consistent everywhere
- Keep gold exclusive to DreamPlay Pro
- Prefer DreamPlay-specific merchandising language over generic store-template wording

## 7) Good next updates for this file in future
This file should be updated when any of the following change:
- Lionel's workflow preferences
- DreamPlay catalog rules
- repo/live URL targeting conventions
- new company positioning language
- new Hermes skills that become relevant to DreamPlay work
