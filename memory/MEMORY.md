Default workspace: "dreamplay_marketing".

RULE — Missing API endpoints: Never guess or try undocumented endpoints. Instead, report: endpoint path, HTTP method, what it does, and a brief implementation note referencing existing codebase patterns. Also update the dreamplay-email skill with the missing endpoint.
§
Himalaya setup complete for lionel@musicalbasics.com. Binary at ~/.local/bin/himalaya. Config at ~/.config/himalaya/config.toml. Gmail app password stored there. Account name: "musicalbasics".

Existing Gmail folders: INBOX, Notes, airbnb, ✔, ✔✔, plus standard Gmail folders. Airbnb folder already exists and Lionel moved Airbnb emails there manually. Still needs Gmail auto-filter set up (requires browser + Gmail password).
§
DreamPlay Email API base URL: https://dreamplay-email-2.vercel.app
§
Cron fix (Apr 9, 2026): Daily Gmail Triage job was failing silently — returned empty response. Root cause: job was using `anthropic` provider but main provider is `openrouter`. Fixed by switching to openrouter. Also changed delivery from "origin" (WhatsApp) to "telegram". Added Step 4 to save triage results to memory so "send N" replies can reference them.
§
Future DreamPlay shop: prioritize real assets, CTA alignment, ergonomic keyboards, pain/strain reduction, DS 5.5 / DS 6.0 sizing, and known catalog starting point of two keyboard models plus a bench.
§
Lionel prefers Hermes to orchestrate Claude Code via tmux for complex tasks. Hermes should write specs and delegate, but NEVER perform implementation work directly. Use '/permissions bypassPermissions' in Claude Code sessions to eliminate interaction overhead for massive file-writing batches.
§
User's canonical Claude Code orchestration preference: small, scoped fixes should be done directly by Hermes with immediate verify/commit/push; larger feature work, new pages, broad UI fidelity passes, or multi-file restructures should go to Claude Code first, with Hermes reviewing and handling only final surgical fixes. claude-code-orchestrator has been updated to reflect this workflow.