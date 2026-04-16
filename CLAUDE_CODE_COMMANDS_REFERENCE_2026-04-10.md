# Claude Code Commands Reference

This is a practical command reference for how Hermes drives Claude Code in this environment.

## 1. Check Claude Code version

Run as root:
```bash
claude --version
```

Run as non-root `claude` user:
```bash
su - claude -c 'export PATH="$HOME/bin:/opt/claude-runtime/bin:$PATH" && claude --version'
```

---

## 2. Verify the non-root Claude workspace is healthy

```bash
su - claude -c 'export PATH="$HOME/bin:/opt/claude-runtime/bin:$PATH" && cd /home/claude/projects/concept-clone && git status -sb && claude --version'
```

---

## 3. Write the prompt/spec into a markdown file first

Typical pattern:
```bash
# prompt file lives inside the repo
/home/claude/projects/concept-clone/PROMPT_CLAUDECODE_SOMETHING.md
```

Hermes writes the prompt file first, then Claude reads it.

---

## 4. Foreground Claude Code run using a prompt file

```bash
su - claude -c 'export PATH="$HOME/bin:/opt/claude-runtime/bin:$PATH" && cd /home/claude/projects/concept-clone && claude -p "$(cat /home/claude/projects/concept-clone/PROMPT_CLAUDECODE_SOMETHING.md)" --permission-mode bypassPermissions --output-format json > /tmp/claude-run.json'
```

Use this when you want Claude to run to completion in one shot and save structured output.

---

## 5. Background Claude Code run using a prompt file

This is the pattern Hermes uses most often for bigger tasks:
```bash
su - claude -c 'export PATH="$HOME/bin:/opt/claude-runtime/bin:$PATH" && cd /home/claude/projects/concept-clone && claude -p "$(cat /home/claude/projects/concept-clone/PROMPT_CLAUDECODE_SOMETHING.md)" --permission-mode bypassPermissions --output-format json > /tmp/claude-run.json'
```

Then launch it as a background process from Hermes and monitor the process/session id.

Important notes:
- Hermes starts the shell command in background
- Hermes polls process status
- final structured output is saved to `/tmp/claude-run.json`

---

## 6. Read Claude’s structured output after completion

```bash
cat /tmp/claude-run.json
```

Or inspect it safely with Hermes/file tools.

---

## 7. Verify repo state after Claude finishes

```bash
su - claude -c 'cd /home/claude/projects/concept-clone && git status -sb && git log --oneline -3'
```

Useful for checking:
- whether Claude committed
- whether Claude pushed
- whether there are unexpected modified files

---

## 8. Run verification commands as the non-root Claude user

Lint + build:
```bash
su - claude -c 'cd /home/claude/projects/concept-clone && npm run lint && npm run build'
```

Build only:
```bash
su - claude -c 'cd /home/claude/projects/concept-clone && npm run build'
```

---

## 9. If git complains about dubious ownership when root inspects the non-root repo

Run once:
```bash
git config --global --add safe.directory /home/claude/projects/concept-clone
```

---

## 10. If `.next` or build artifacts have wrong ownership and block builds

Fix ownership and rerun build:
```bash
chown -R claude:claude /home/claude/projects/concept-clone/.next && su - claude -c 'cd /home/claude/projects/concept-clone && npm run build'
```
```

If other temp directories are root-owned, fix those similarly.

---

## 11. Revert unintended changes created by Claude

For a specific tracked file:
```bash
su - claude -c 'cd /home/claude/projects/concept-clone && git checkout -- tsconfig.json'
```

Check status after:
```bash
su - claude -c 'cd /home/claude/projects/concept-clone && git status -sb'
```

---

## 12. Remove temporary artifact folders safely

Python removal pattern Hermes used:
```bash
python3 - <<'PY'
import shutil, os
for p in ['.next-build', '.next-verify', 'tmp']:
    if os.path.exists(p):
        shutil.rmtree(p)
        print('removed', p)
    else:
        print('missing', p)
PY
```
```

Use this only for obvious temporary folders.

---

## 13. Commit and push after Hermes direct fixes

```bash
git add src/components/Footer.tsx && git commit -m "fix(footer): align contact details with contact page" && git push origin main
```

General pattern:
```bash
git add <files> && git commit -m "type(scope): message" && git push origin main
```

---

## 14. Useful status checks while Claude is running

Check if work is appearing in the repo:
```bash
su - claude -c 'cd /home/claude/projects/concept-clone && git status --short'
```

Check recent commits:
```bash
su - claude -c 'cd /home/claude/projects/concept-clone && git log --oneline -5'
```

Check only relevant diffs:
```bash
su - claude -c 'cd /home/claude/projects/concept-clone && git diff --stat -- src/app/contact/page.tsx src/app/globals.css'
```

---

## 15. Example real command used for the contact page

```bash
su - claude -c 'export PATH="$HOME/bin:/opt/claude-runtime/bin:$PATH" && cd /home/claude/projects/concept-clone && claude -p "$(cat /home/claude/projects/concept-clone/PROMPT_CLAUDECODE_CONTACT_PAGE_2026-04-10.md)" --permission-mode bypassPermissions --output-format json > /tmp/claude-contact-page.json'
```

---

## 16. Example real command used for the homepage/template split

```bash
su - claude -c 'export PATH="$HOME/bin:/opt/claude-runtime/bin:$PATH" && cd /home/claude/projects/concept-clone && claude -p "$(cat /home/claude/projects/concept-clone/PROMPT_CLAUDECODE_HOME_TEMPLATE_SPLIT_2026-04-10.md)" --permission-mode bypassPermissions --output-format json > /tmp/claude-home-template-split.json'
```

---

## 17. Recommended operating pattern

Use this order:
1. write prompt file in repo
2. verify workspace/user
3. launch Claude as non-root `claude`
4. save output to `/tmp/*.json`
5. monitor process until done
6. inspect git status/log
7. run lint/build
8. browser-check result if UI work
9. push if needed
10. report short summary + live URL

---

## 18. Important assumptions in this environment

These commands assume:
- non-root coding user: `claude`
- Claude runtime path: `/opt/claude-runtime/bin/claude`
- repo path: `/home/claude/projects/concept-clone`
- Claude auth/config already exists for the `claude` user
- git remote is already configured

If any of those are different on another machine, adjust the paths accordingly.
