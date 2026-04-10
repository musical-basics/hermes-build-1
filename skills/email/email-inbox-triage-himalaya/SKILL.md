---
name: email-inbox-triage-himalaya
description: Systematically process and organize email inbox using Himalaya CLI with explicit approval gates and folder-based workflows.
version: 1.0.0
author: Lionel Yu workflow
metadata:
  hermes:
    tags: [Email, Himalaya, Organization, Workflow]
prerequisites:
  - Himalaya CLI installed and configured with Gmail account
  - Existing folder structure set up (airbnb, shopify orders, temp, all receipts, etc.)
---

# Email Inbox Triage Workflow (Himalaya CLI)

## Overview
Process inbox emails in batches (~10 at a time), categorize them, and move/delete with explicit user approval at each step.

## Prerequisites
- Himalaya CLI (`~/.local/bin/himalaya`)
- Gmail account configured in `~/.config/himalaya/config.toml`
- Folder structure already created (list with `himalaya folder list`)

## Workflow Steps

### 1. Check Available Folders First
ALWAYS run this before suggesting folder names:
```bash
himalaya folder list
```
Show user the full list. Never assume a folder exists or suggest one without checking.

### 2. List Batch of Emails
```bash
himalaya envelope list --page-size 10 --output json
```
Returns 10 most recent emails with ID, sender, subject, date.

### 3. Read Email Contents (as needed)
```bash
himalaya message read <ID>
```
Show user the content before making decisions.

### 4. Categorize & Recommend
For each email, determine:
- **Keep in inbox**: Actionable, time-sensitive, or important (orders, security alerts, work invites)
- **Move to folder**: Receipts → "all receipts", Orders → "shopify orders", Temp action items → "temp"
- **Unsubscribe**: Low-value newsletters (if link available in email)
- **Trash**: Marketing, promotions, social digests, duplicates

### 5. Get Explicit Approval
Show the user exactly what you plan to do:
```
Trash: #1, #3, #5 (FMP marketing, Onshape tip, Weee promo)
Move to shopify orders: #7 (Order #7048)
Keep in inbox: #4 (Supabase security alert)
```
Wait for "yes" or specific changes before executing.

### 6. Execute Actions
Move emails:
```bash
himalaya message move --folder "INBOX" "target-folder" <ID1> <ID2>
himalaya message move "[Gmail]/Trash" <ID1> <ID2>
```

Unsubscribe (browser):
- Extract unsubscribe link from email body
- Navigate to link in browser
- Some sites may have bot protection (Cloudflare)

### 7. Next Batch
After approval and execution, pull next 10 emails and repeat.

## Common Patterns

### Gmail Filters (Setup Email-Side)
For recurring senders → folder routing:
- Gmail Settings → Filters and Blocked Addresses → Create new filter
- Example: All MusicalBasics orders → skip inbox, apply "shopify orders" label
- From: `support@musicalbasics.com`, Subject contains: `[MusicalBasics] Order`

### Folder Organization
- **all receipts**: OpenRouter, bunny.net, invoices
- **shopify orders**: MusicalBasics order confirmations
- **temp**: Action items (Linear invites, pending decisions)
- **airbnb**: Airbnb reservation emails
- **Notes**: Personal notes folder (rarely used for email)

### Unsubscribe Strategy
- Check email for unsubscribe link (usually at footer)
- Prefer unsubscribe over setting up filters for obvious newsletter spam
- Some links work via CLI (direct URL), others require browser interaction
- Cloudflare bot protection may block automated unsubscribe attempts

## Hard Rules

**NEVER without explicit approval:**
- Delete, trash, or move ANY email without showing the user first
- Assume a folder exists—always check `himalaya folder list` first
- Batch-action based on assumed preferences

**Approval pattern:**
- Show: "I recommend trashing X, Y, Z. Move A to B. Keep C in inbox. Approve?"
- Wait for clear yes/confirmation before executing
- If user changes mind, restore from Trash

## Pitfalls

- **Bot detection on unsubscribe**: Skillshare, Instagram, etc. use Cloudflare. May need user to click link manually.
- **Folder names with spaces**: Use quotes in Himalaya commands: `"shopify orders"`
- **Message IDs change**: After moving/deleting, re-list to get fresh IDs for next batch.
- **Gmail app password vs. regular password**: Only app passwords work with Himalaya + Gmail 2FA.

## Example Session

```bash
# 1. Check folders
himalaya folder list

# 2. List 10 emails
himalaya envelope list --page-size 10 --output json

# 3. Read one email
himalaya message read 68467

# 4. Show user recommendations (no action yet)

# 5. User approves: "Trash 1, 3, 5. Move 7 to shopify orders."

# 6. Execute
himalaya message move "[Gmail]/Trash" 68431 68430 68427
himalaya message move --folder "INBOX" "shopify orders" 68422

# 7. Pull next 10
himalaya envelope list --page-size 10 --output json
```

## Tips

- Process in batches of 10 for manageable workflow
- High-value emails (receipts, orders, security alerts) get dedicated folders
- Marketing/promo emails → trash or unsubscribe
- Use `--output json` for structured data parsing
- Always recheck folders after org changes—Himalaya may cache old list