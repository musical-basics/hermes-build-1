You are working in /home/claude/projects/concept-clone. Read CLAUDE.md first, then inspect both the reference FAQ page and the current local /faq page before changing code.

Task:
Correct /faq so it matches the Shopify Concept FAQ page format much more closely.

Reference page:
- https://concept-theme-tech.myshopify.com/pages/faqs

Current issue:
- The current DreamPlay /faq diverges too much from the reference.
- The reference uses a clear two-column layout.
- The right column includes a distinct "Didn't find your answer?" contact/help box.
- Our current implementation reads more like a stacked FAQ page and misses that key page structure.

Scope:
- /faq only
- minimal supporting CSS/component changes only if truly needed
- do not touch unrelated routes
- do not change header IA or other pages in this run

Primary mission:
Rework /faq so the page structure is reference-accurate:
- left/main FAQ content column
- right/support sidebar or help box column
- the "Didn't find your answer?" area should visually feel like the reference page's right-side support/contact block
- preserve DreamPlay branding/content, but match the reference layout and hierarchy much more closely

Priorities:
- two-column desktop layout
- right-side support/contact box
- category headings and FAQ grouping that feel reference-like
- cleaner spacing and support-page rhythm
- maintain solid mobile behavior

Constraints:
- narrow correction pass only
- no generic redesign
- avoid unnecessary shared CSS churn
- push once the fix is verified so Lionel can review live

Likely files:
- src/app/faq/page.tsx
- src/app/globals.css

Verification requirements:
- inspect reference first
- run npm run lint
- run npm run build
- verify /faq locally in browser
- confirm only intended files changed
- push direct to main

At the end print:
- brief summary
- commit hash
- files touched
