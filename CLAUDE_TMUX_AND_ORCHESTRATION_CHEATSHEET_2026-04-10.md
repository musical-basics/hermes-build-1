# Claude Code tmux + Orchestration Cheatsheet

This is a practical reference for running Claude Code the way Hermes has been doing it in this environment, with a few key principles pulled from the Claude Code Orchestrator skill.

## Core orchestration principles
- Hermes is the orchestrator; Claude Code does the implementation thinking for larger code tasks.
- Small, scoped fixes can be done directly by Hermes.
- Larger feature work, multi-file restructures, broad UI fidelity passes, and new pages should go to Claude Code first.
- Prefer one Claude run per cleanly scoped lane of work.
- If two tasks touch the same files, do not run them in parallel.
- For major work, prefer a persistent tmux Claude session or a background Claude run instead of blocking chat.
- Before major write-heavy tasks, use `/permissions bypassPermissions` when the environment supports it.
- Always verify Claude’s work after it finishes.
- For live review workflows, push promptly so the updated site can be inspected.

## Canonical tmux session naming
Use:
- `claude-<project>`

Example:
- `claude-concept`

## Basic tmux commands

Create a detached session:
```bash
tmux new-session -d -s claude-concept
```

List sessions:
```bash
tmux ls
```

Attach to the session:
```bash
tmux attach -t claude-concept
```

Kill the session:
```bash
tmux kill-session -t claude-concept
```

## Launch interactive Claude Code inside tmux
This is the common pattern when using the non-root `claude` user and the shared runtime:

```bash
tmux new-session -d -s claude-concept

tmux send-keys -t claude-concept 'su - claude -c '\''export PATH="$HOME/bin:/opt/claude-runtime/bin:$PATH" && cd /home/claude/projects/concept-clone && claude --permission-mode bypassPermissions'\''' C-m
```

Then attach when needed:
```bash
tmux attach -t claude-concept
```

## What to do once attached
Inside Claude Code, commonly set:
```text
/effort max
/permissions bypassPermissions
```

Then paste the task prompt or tell Claude to read a prompt/spec markdown file in the repo.

## Preferred prompt workflow
For larger tasks:
1. Write the exact spec into a markdown file inside the repo.
2. Launch Claude in the project session.
3. Give Claude the short, scoped instruction.
4. Let Claude implement.
5. Verify with git/lint/build/browser.
6. Push so the live result can be reviewed.

## Example: tell Claude to read a prompt file
After attaching to tmux, a common instruction would be something like:
```text
Read /home/claude/projects/concept-clone/PROMPT_CLAUDECODE_HOME_TEMPLATE_SPLIT_2026-04-10.md and execute it. Stay scoped. Commit and push when done.
```

## Non-root launch pattern
This setup uses a dedicated coding user:
```bash
su - claude -c 'export PATH="$HOME/bin:/opt/claude-runtime/bin:$PATH" && cd /home/claude/projects/concept-clone && claude --permission-mode bypassPermissions'
```

Why this matters:
- root may not support bypassPermissions cleanly
- a non-root coding user is safer and more reliable for heavy write operations
- it keeps orchestration and implementation roles separated

## One-shot background pattern vs tmux
Use tmux for:
- persistent interactive work
- iterative implementation
- tasks where you may want to re-enter the same Claude context

Use one-shot background runs for:
- tightly scoped prompt-file execution
- batch work that does not need live interaction
- jobs where structured JSON output is useful

Example one-shot run:
```bash
su - claude -c 'export PATH="$HOME/bin:/opt/claude-runtime/bin:$PATH" && cd /home/claude/projects/concept-clone && claude -p "$(cat /home/claude/projects/concept-clone/PROMPT_CLAUDECODE_SOMETHING.md)" --permission-mode bypassPermissions --output-format json > /tmp/claude-run.json'
```

## Verification commands after Claude finishes
Check repo state:
```bash
su - claude -c 'cd /home/claude/projects/concept-clone && git status -sb && git log --oneline -5'
```

Run lint/build:
```bash
su - claude -c 'cd /home/claude/projects/concept-clone && npm run lint && npm run build'
```

## Important safety rules from the orchestrator workflow
- Do not keep stacking broad Claude runs on top of a broken UI state.
- If Claude introduces an obvious regression, identify the bad change and revert the smallest offending piece first.
- For narrow CSS/layout bugs, prefer the smallest safe direct fix instead of launching another huge run.
- For broad work, split by non-overlapping file domains.
- If a Claude run appears stuck with no real diff progress, kill it and relaunch with a narrower scope.
- If partial work is salvageable, continue from the existing diff instead of starting over.

## Suggested default operating loop
1. Decide whether the task is small enough for direct Hermes editing.
2. If not, write a prompt file.
3. Launch Claude via tmux or background one-shot.
4. Keep track of the tmux session name or process id.
5. Monitor progress.
6. Verify changes.
7. Push.
8. Report the result with the live URL if applicable.

## Minimal tmux cheat sheet
```bash
# create
tmux new-session -d -s claude-concept

# start Claude in that session
tmux send-keys -t claude-concept 'su - claude -c '\''export PATH="$HOME/bin:/opt/claude-runtime/bin:$PATH" && cd /home/claude/projects/concept-clone && claude --permission-mode bypassPermissions'\''' C-m

# attach
tmux attach -t claude-concept

# list
tmux ls

# kill
tmux kill-session -t claude-concept
```
