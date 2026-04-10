---
name: cron-debugging
description: Debug Hermes cron jobs that run but produce no output or fail to deliver messages.
version: 1.0.0
author: hermes
metadata:
  hermes:
    tags: [cron, debugging, scheduled-jobs, delivery]
---

# Cron Job Debugging — Hermes Agent Skill

> Systematic approach for diagnosing cron jobs that report "ok" but deliver nothing.

---

## Symptom: Job runs, status "ok", but no message delivered

### Step 1: Check the output file
```bash
ls -lt ~/.hermes/cron/output/{job_id}/
cat ~/.hermes/cron/output/{job_id}/*.md
```
Look for `## Response` section. If it says "(No response generated)", the agent ran but produced empty output — the delivery pipeline is fine, the LLM is the problem.

### Step 2: Check why final_response is empty
The cron runner (`scheduler.py` line 744-747) returns `final_response = result.get("final_response", "") or ""`. If empty:
- `should_deliver = bool(deliver_content)` → False → delivery skipped
- This means the AIAgent completed but its last message had no text content

Common causes:
1. **Wrong provider** — job was created with `provider: anthropic` but auth only works via `openrouter`. The model call may fail silently.
2. **Model rate limit** — the model returned an error that got swallowed
3. **Tool-only loop** — agent made tool calls but never produced a final text response (all iterations were tool calls, hit max_iterations)

### Step 3: Check provider/auth
```bash
# Check what provider the job uses
cat ~/.hermes/cron/jobs.json | python3 -c "import json,sys; jobs=json.load(sys.stdin)['jobs']; [print(j['id'], j.get('provider'), j.get('model')) for j in jobs]"
```
If provider is `anthropic` but the system's working provider is `openrouter`, switch it:
```
cronjob update job_id=XXX model={"model": "claude-sonnet-4.6", "provider": "openrouter"}
```

### Step 4: Check delivery target
Job origin might be a disconnected platform (e.g., WhatsApp). Switch to the active platform:
```
cronjob update job_id=XXX deliver=telegram
```

### Step 5: Test himalaya manually
If the job uses himalaya for email triage, verify it works:
```bash
~/.local/bin/himalaya envelope list --page-size 10 --output json 2>/dev/null | head -5
```

### Step 6: Trigger manual run and monitor
```
cronjob run job_id=XXX
```
Then check the new output file:
```bash
ls -lt ~/.hermes/cron/output/{job_id}/
cat ~/.hermes/cron/output/{job_id}/latest.md
```

---

## Delivery Pipeline Architecture

```
cron tick → run_job() → AIAgent.run_conversation(prompt)
                              ↓
                     final_response (string)
                              ↓
              should_deliver = bool(final_response)
                              ↓
              _deliver_result(job, final_response) → platform adapter
```

Key files:
- `~/.hermes/hermes-agent/cron/scheduler.py` — run_job(), delivery logic
- `~/.hermes/hermes-agent/cron/jobs.py` — job CRUD, schedule parsing
- `~/.hermes/cron/jobs.json` — job storage
- `~/.hermes/cron/output/{job_id}/` — run output logs

---

## Quick Reference: Cron Job Fields

| Field | Purpose |
|-------|---------|
| `model` | LLM model name (e.g., "claude-sonnet-4.6") |
| `provider` | API provider ("openrouter", "anthropic") |
| `deliver` | Delivery target ("origin", "telegram", "local") |
| `origin` | Source platform where job was created |
| `skills` | Skills to load before running |
| `schedule` | Parsed schedule (kind + expr/minutes/run_at) |

---

## Pitfalls

- **Empty final_response = no delivery.** The system treats empty string as "nothing to report" and skips delivery. There's no error raised.
- **Origin may be stale.** Jobs created on WhatsApp won't deliver if WhatsApp adapter is down. Always verify the deliver target matches an active platform.
- **"ok" status is misleading.** It means the agent loop completed without throwing an exception — not that it produced useful output.
- **Himalaya stderr warnings.** `himalaya` emits WARN lines to stderr about `imap_codec`. These are harmless but can break JSON parsing if stderr isn't redirected. Use `2>/dev/null` or `2>&1` carefully.
