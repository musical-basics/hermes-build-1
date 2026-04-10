---
name: dreamplay-email
description: Control Lionel's custom DreamPlay Email marketing platform via API. Create campaigns, build drip chains, manage subscribers, and trigger sends — all from natural language.
version: 1.0.0
author: lionel
metadata:
  hermes:
    tags: [Email, Marketing, Campaigns, Drip, Subscribers, API]
---

# DreamPlay Email Platform — Hermes Agent Skill

> Control Lionel's custom email marketing platform via API.
> Create campaigns, build drip chains, manage subscribers, and trigger sends — all from natural language.

---

## Platform Overview

DreamPlay Email is a custom-built Mailchimp/Klaviyo alternative running on Next.js 16, Supabase (PostgreSQL), Resend for delivery, and Inngest for background jobs. It supports:

- **Campaigns** — single-send emails with HTML content, merge tags, scheduling, and A/B rotations
- **Chains** — multi-step drip sequences with delays, branches, and behavioral triggers
- **Subscribers** — audience management with tags, segments, saved views, and CRM data
- **Triggers** — event-based automations that fire chains or campaigns
- **AI Copilot** — built-in Claude/Gemini integration for email copy generation

**Base URL:** `https://dreamplay-email-2.vercel.app`
**Auth:** All endpoints require `Authorization: Bearer $DREAMPLAY_EMAIL_API_KEY` (env var)
**Workspace:** All operations are scoped to a workspace slug, passed as a path parameter.

---

## API Endpoints

### Campaigns

#### List Campaigns
```
GET /api/hermes/{{workspace}}/campaigns
Query: ?status=draft|scheduled|sent&limit=20&offset=0
```
Returns campaign list with id, subject, status, created_at, open_rate, click_rate.

#### Get Campaign
```
GET /api/hermes/{{workspace}}/campaigns/{{campaign_id}}
```
Returns full campaign detail including html_content, subject, from_name, subscriber_filter.

#### Create Campaign
```
POST /api/hermes/{{workspace}}/campaigns
Body:
{
  "subject": "string",
  "from_name": "string (optional, uses workspace default)",
  "preview_text": "string (optional)",
  "html_content": "string (HTML or __dnd_blocks__ JSON)",
  "tags": ["string"] // target subscribers with these tags
}
```
Returns created campaign object with id. Campaign is created in `draft` status.

#### Update Campaign
```
PATCH /api/hermes/{{workspace}}/campaigns/{{campaign_id}}
Body: same fields as create (partial update)
```

#### Send Campaign
```
POST /api/hermes/{{workspace}}/campaigns/{{campaign_id}}/send
Body:
{
  "schedule_at": "ISO 8601 datetime (optional, sends immediately if omitted)"
}
```
Triggers Inngest `send-campaign` or `scheduled-send` function.

#### Generate Email Copy (AI Copilot)
```
POST /api/hermes/{{workspace}}/copilot/generate
Body:
{
  "prompt": "string — describe what the email should say",
  "tone": "professional|casual|friendly|urgent (optional)",
  "model": "claude|gemini (optional, defaults to claude)"
}
```
Returns generated HTML email content. Use this to generate copy, then pass it to create/update campaign.

---

### Chains (Drip Sequences)

#### List Chains
```
GET /api/hermes/{{workspace}}/chains
```
Returns chain list with id, name, status, step_count, active_subscribers.

#### Get Chain
```
GET /api/hermes/{{workspace}}/chains/{{chain_id}}
```
Returns full chain with steps array, each containing: step_number, delay_days, delay_hours, subject, html_content, branch_conditions.

#### Create Chain
```
POST /api/hermes/{{workspace}}/chains
Body:
{
  "name": "string",
  "description": "string (optional)",
  "trigger_tags": ["string"],
  "steps": [
    {
      "step_number": 1,
      "delay_days": 0,
      "delay_hours": 0,
      "subject": "string",
      "html_content": "string",
      "preview_text": "string (optional)"
    },
    {
      "step_number": 2,
      "delay_days": 3,
      "delay_hours": 0,
      "subject": "string",
      "html_content": "string"
    }
  ]
}
```
Returns created chain with id. First step (delay 0) sends immediately on entry.

#### Add Step to Chain
```
POST /api/hermes/{{workspace}}/chains/{{chain_id}}/steps
Body:
{
  "step_number": 3,
  "delay_days": 5,
  "subject": "string",
  "html_content": "string"
}
```

#### Activate Chain
```
POST /api/hermes/{{workspace}}/chains/{{chain_id}}/activate
```
Enables the chain. New subscribers matching trigger_tags will enter automatically.

#### Deactivate Chain
```
POST /api/hermes/{{workspace}}/chains/{{chain_id}}/deactivate
```

---

### Subscribers

#### List Subscribers
```
GET /api/hermes/{{workspace}}/subscribers
Query: ?tag=string&status=active|unsubscribed&search=string&limit=50&offset=0
```

#### Get Subscriber
```
GET /api/hermes/{{workspace}}/subscribers/{{subscriber_id}}
```
Returns full profile with tags, CRM data, chain_processes (active sequences), email history.

#### Create Subscriber
```
POST /api/hermes/{{workspace}}/subscribers
Body:
{
  "email": "string",
  "first_name": "string (optional)",
  "last_name": "string (optional)",
  "tags": ["string"],
  "custom_fields": {}
}
```

#### Tag Subscribers (Bulk)
```
POST /api/hermes/{{workspace}}/subscribers/bulk-tag
Body:
{
  "subscriber_ids": ["string"],
  "tags": ["string"]
}
```

#### Search Subscribers
```
POST /api/hermes/{{workspace}}/subscribers/search
Body:
{
  "query": "string — natural language search, e.g. 'distributors who opened last campaign'"
}
```
Uses AI to translate natural language into subscriber filters.

---

### Tags

#### List Tags
```
GET /api/hermes/{{workspace}}/tags
```

#### Create Tag
```
POST /api/hermes/{{workspace}}/tags
Body: { "name": "string", "color": "string (hex, optional)" }
```

#### Delete Tag
```
DELETE /api/hermes/{{workspace}}/tags/{{tag_id}}
```
Deletes the tag and removes it from all subscribers. Returns `{ "success": true, "removedFrom": N }` where N is the number of subscribers cleaned up.

#### Delete Tag ⚠️ NOT YET IMPLEMENTED
Missing endpoint — needs to be added to the codebase:
- Path: `DELETE /api/hermes/{{workspace}}/tags/{{tag_id}}`
- Method: `DELETE`
- What it does: Deletes tag by ID and removes it from all subscriber associations
- Implementation: Follow pattern of POST /tags handler. Run `DELETE FROM tags WHERE id = tag_id AND workspace = workspace`, then `DELETE FROM subscriber_tags WHERE tag_id = tag_id`. Return `{ success: true }` or 404.

---

### Merge Tags

#### List Merge Tags
```
GET /api/hermes/{{workspace}}/merge-tags
```
Returns available merge tags like {{first_name}}, {{company}}, etc.

---

### Triggers

#### List Triggers
```
GET /api/hermes/{{workspace}}/triggers
```

#### Create Trigger
```
POST /api/hermes/{{workspace}}/triggers
Body:
{
  "name": "string",
  "event": "signup|tag_added|link_clicked|custom",
  "conditions": {},
  "action": "start_chain|send_campaign",
  "action_id": "string — chain_id or campaign_id"
}
```

---

### Analytics

#### Campaign Analytics
```
GET /api/hermes/{{workspace}}/campaigns/{{campaign_id}}/analytics
```
Returns sends, opens, clicks, unsubscribes, bounce_rate.

#### Chain Analytics
```
GET /api/hermes/{{workspace}}/chains/{{chain_id}}/analytics
```
Returns per-step open/click rates and drop-off data.

---

## Lionel's Preferences

- **Tone:** Professional but warm for hardware stakeholders. Direct and brief for factory contacts. Friendly and encouraging for piano students.
- **Structure:** Emails should be concise — 3-5 short paragraphs max. No fluff.
- **Merge tags:** Always use {{first_name}} in greetings when available.
- **Chains:** Default delay between steps is 3 days unless specified otherwise.
- **Approval:** Always show draft content and ask for approval before sending. Never auto-send without confirmation.
- **Workspace:** Default workspace is `dreamplay_marketing` unless specified.

## Common Tasks

### "Create a 3-email sequence for [segment]"
1. Generate copy for each step using `/copilot/generate`
2. Create chain with steps via `POST /chains`
3. Show Lionel the drafts for approval
4. On approval, activate the chain

### "Send an update to [person/group] about [topic]"
1. Check if subscribers exist and are tagged appropriately
2. Generate copy via `/copilot/generate`
3. Create campaign targeting the relevant tag
4. Show draft for approval
5. On approval, send campaign

### "How did the last campaign do?"
1. List recent campaigns sorted by date
2. Fetch analytics for the most recent sent campaign
3. Summarize opens, clicks, and any notable patterns

---

## Missing Endpoint Protocol

If Lionel asks to do something the API doesn't support, NEVER guess or try undocumented endpoints. Instead report:
1. The missing endpoint path + HTTP method
2. What it does
3. Brief implementation note referencing existing codebase patterns

Then ask if he wants to look at the codebase for exact file path and code snippet.

---

## Known Quirks & Pitfalls

- **Campaign list returns empty subjects** — `GET /campaigns` does not populate `subject`, `from_name`, `tags`, or `preview_text` in list responses. Fetch individual campaigns via `GET /campaigns/{{id}}` to get full detail.
- **Campaign list has no tag filter** — cannot filter campaigns by tag/label from the list endpoint. No "master template" category exists in the API; ask Lionel how templates are identified in his platform (naming convention, UI label, etc.).
- **Many duplicate draft campaigns** — expect to see campaigns with identical HTML content saved multiple times.

---

## Error Handling

- **401:** API key invalid or expired. Ask Lionel to check the key.
- **404:** Resource not found. Confirm the ID or workspace slug.
- **422:** Validation error. Response body contains field-level errors.
- **429:** Rate limited. Wait 60 seconds and retry.
- **500:** Server error. Log the response and notify Lionel.
