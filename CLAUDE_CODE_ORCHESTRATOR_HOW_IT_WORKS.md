# How the `claude-code-orchestrator` Skill Works

Generated: 2026-04-10

## Core idea
The `claude-code-orchestrator` skill treats Hermes as the coordinator and Claude Code as the implementer.

Short version:
- Hermes handles intake, routing, specs, verification, and reporting
- Claude Code handles the actual implementation work
- Repos act as persistent memory

The skill’s own summary is:
- "Hermes is a pure I/O router. Claude Code does ALL thinking. Repos are persistent memory."

## What Hermes is supposed to do
According to the skill, Hermes should:
1. Receive Lionel’s message
2. Pick the correct repo/project
3. Prefer the persistent Claude Code tmux session for complex work
4. Write a clear spec when needed
5. Delegate execution to Claude Code
6. Verify the result independently
7. Relay a concise result back to Lionel

Important framing:
- Hermes is not meant to do the heavy implementation thinking when Claude Code is the better tool
- Hermes is meant to orchestrate inputs/outputs and quality control

## What Claude Code is supposed to do
Claude Code is the implementation engine.

That means Claude Code is expected to:
- read the spec or prompt
- reason through the requested change
- modify files
- perform implementation work
- sometimes commit/push when instructed
- summarize what changed

## The canonical operating loop
The linked operating loop reference describes the default flow like this:
1. Receive Lionel’s request
2. Decide if it belongs in an advisory repo or a code project
3. If implementation is needed, prefer the existing persistent tmux Claude session for that project
4. Write a short spec when the task is non-trivial
5. In Claude Code, set `/effort max` for complex work
6. Before large file-writing batches, run `/permissions bypassPermissions`
7. Delegate implementation to Claude Code
8. Hermes verifies independently
9. Hermes reports back concisely

## When to use it
This skill is mainly for:
- larger feature work
- multi-file changes
- ambiguous implementation tasks
- broad UI fidelity passes
- bigger restructures
- work that benefits from persistent repo/session context
- partitioned work across multiple Claude Code runs

## When not to use it
The skill explicitly says Hermes may act directly for small, surgical fixes.

Examples where Hermes may do the work directly instead of orchestrating Claude Code:
- tiny CSS/layout fixes
- small one-off corrections
- narrow routing or link fixes
- obvious visual regressions where a direct surgical repair is safer/faster

The skill also says not to delegate these to Claude Code:
- email sending
- WhatsApp/Telegram messages
- cron jobs
- credentials
- account changes
- chat replies

## Preferred execution pattern in practice
The skill includes a very opinionated workflow:

### Small work
- Hermes may edit directly
- then verify
- then commit and push

### Bigger work
- use persistent Claude Code sessions in tmux
- prefer continuity instead of throwaway one-shot runs
- explicitly choose stronger effort/model for heavier jobs
- write a spec/prompt file when needed
- verify carefully after Claude finishes
- push so Lionel can review the live result

## Prompt philosophy
The skill strongly prefers short prompts.

Its guidance is basically:
- don’t over-explain
- keep prompts short and clear
- give Claude Code a crisp success condition
- let Claude Code do the reasoning

Example pattern from the skill:
- "Read SPEC.md, implement the described changes, commit when done, then summarize what changed and anything still broken."

## Session / tmux conventions
The skill assumes persistent tmux sessions matter.

Key ideas:
- use session names like `claude-<project>`
- reuse the same session when continuity matters
- common example from the skill:
  - `claude-concept` -> `/root/projects/concept-clone`

Helpful tmux commands listed by the skill:
- create detached session:
  - `tmux new-session -d -s claude-<project>`
- attach:
  - `tmux attach -t claude-<project>`
- list:
  - `tmux ls`
- kill:
  - `tmux kill-session -t claude-<project>`

## Effort and permissions rules
The skill explicitly says:
- always set effort level
- for complex work, use `/effort max`
- before big write-heavy tasks, use `/permissions bypassPermissions` when available

It also records an environment-specific lesson:
- root Claude Code may not support bypassPermissions reliably
- the preferred durable fix is to run Claude Code under a dedicated non-root user such as `claude`

## Repo routing model
The skill distinguishes between:
- advisory/thinking repos in `/root/repos/...`
- actual code projects in `/root/projects/...`

Meaning:
- strategy/research/context can live in a repo used as a “thinking library”
- real implementation happens in the project repo

## Architectural pattern: “thinking library”
The skill describes a pattern where repos hold context so Claude Code can think inside the repo context instead of Hermes carrying everything mentally.

That pattern is:
1. identify whether the task is advisory or execution
2. consult Claude in the relevant repo
3. keep context updated in repo files
4. let the repo serve as durable working memory

## Verification expectations
Hermes is supposed to verify after Claude Code finishes.

The skill’s verification checklist includes questions like:
- did Claude touch the intended files only?
- do build/tests/lint pass if relevant?
- does the output match the spec?
- for UI fidelity work, did Hermes compare against the live reference?
- if parallel Claude runs were used, were they split by file domain?
- is any follow-up still needed before reporting success?

## Recovery / failure handling rules
The skill includes a lot of guidance for when Claude Code runs go wrong.

Key themes:
- do not blindly stack more changes on top of broken output
- inspect diffs first
- salvage coherent partial work if possible
- if Claude hangs or overthinks, split the task into smaller runs
- if a visible regression appears, revert the narrow offending change first
- verify visually, not just by build success
- keep implementation-plan markdown files for continuity on bigger tasks

## Current Lionel-specific workflow reflected in the skill
The skill has already been adapted to Lionel’s preferences.

Important points embedded in it:
- small scoped fixes can be done directly by Hermes
- larger work should go to Claude Code first
- for major delegated work, Lionel wants to review the prompt first
- for live-review repos, pushing is part of completion
- for UI work, visual verification matters, not just passing build/lint

## The most important practical summary
If you want the skill in one sentence:

`claude-code-orchestrator` is a workflow that makes Hermes act like a dispatcher, reviewer, and verifier, while Claude Code acts like the actual implementation brain inside the right repo and persistent session.

## Extremely short cheat sheet
- Small fix? Hermes can do it directly
- Bigger fix? Route to Claude Code
- Use the correct repo first
- Prefer persistent tmux Claude sessions
- Write a spec when the task is non-trivial
- Use `/effort max` for complex work
- Use `/permissions bypassPermissions` when available
- Verify independently after Claude finishes
- Push so Lionel can review live
- Keep summaries concise
