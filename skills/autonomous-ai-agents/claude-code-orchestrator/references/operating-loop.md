# Hermes -> Claude Code Operating Loop

## Canonical flow
1. Receive Lionel's request.
2. Decide whether it belongs in an advisory repo (`/root/repos/...`) or a code project (`/root/projects/...`).
3. If implementation is needed, prefer the existing persistent tmux Claude Code session for that project.
4. Write a short spec when the task is non-trivial.
5. In Claude Code, set `/effort max` for complex work.
6. Before large file-writing batches, run `/permissions bypassPermissions`.
7. Delegate implementation to Claude Code.
8. Hermes verifies the result independently.
9. Relay the outcome to Lionel concisely.

## Current canonical session
- `claude-concept` -> `/root/projects/concept-clone`

## Hard rules
- Hermes orchestrates; Claude Code implements.
- Hermes should not directly patch or write code in project repos when Claude Code is available.
- Do not delegate email sending, credentials, account changes, or chat replies to Claude Code.
- Prefer continuity: reuse the same tmux session when project context matters.

## Default phrasing for delegation
- Short prompt to Claude Code
- Clear success condition
- Minimal over-explanation

Example:
- "Read SPEC.md, implement the described changes, commit when done, then summarize what changed and anything still broken."

## Verification checklist
- Did Claude change the intended files only?
- Do builds/tests/lint pass if relevant?
- Does the output match the spec?
- Are any follow-up fixes still needed before reporting success?