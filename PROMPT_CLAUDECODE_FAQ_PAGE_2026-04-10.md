You are working in /home/claude/projects/concept-clone. Read CLAUDE.md first, then inspect the Shopify Concept reference FAQ page before changing code.

Task:
Create the DreamPlay equivalent of the reference FAQ page.

Reference page:
- https://concept-theme-tech.myshopify.com/pages/faqs

Route target:
- /faq

Scope:
- build only the /faq page and any minimal support files it truly needs
- do not touch unrelated routes
- do not do broader Resources nav IA work in this run
- do not modify /features, /collections, /shop, /journal, /our-story, or homepage content unless absolutely required for this route to work

Current project context:
- We are still in the format-copying stage, so reference structure and pacing matter more than original redesign ideas.
- The page should feel like the DreamPlay version of the reference FAQ/support page.
- Prioritize clean hierarchy, spacing, accordion behavior if relevant, and reference-like support-page clarity.

What to prioritize:
- reference FAQ page structure and section order
- support-page hierarchy and readability
- accordion/list interaction quality if present
- premium but restrained styling
- DreamPlay-specific questions/answers and content tone

Constraints:
- keep this run scoped to /faq and minimal supporting files only
- avoid broad shared-header edits
- no generic placeholder redesigns
- no over-engineering

Likely files:
- src/app/faq/page.tsx
- src/app/globals.css
- one small support component only if clearly justified

Verification requirements:
- inspect the reference page first
- run npm run lint
- run npm run build
- verify /faq locally in browser
- confirm only intended files changed before each push
- push meaningful progress directly to main so Lionel can review live

At the end print:
- summary of what changed
- commit(s)
- files touched
- any overlap risk with later Resources/header cleanup
