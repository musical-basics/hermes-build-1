You are working in /home/claude/projects/concept-clone. Read CLAUDE.md first, then inspect the Shopify Concept reference page before changing code.

Task:
Create the DreamPlay equivalent of the reference Our Journal page.

Reference page:
- https://concept-theme-tech.myshopify.com/blogs/news

Route target:
- /journal

Scope:
- build only the /journal page and any minimal support files it truly needs
- do not touch unrelated routes
- do not do the Resources nav IA cleanup in this run
- do not modify /features, /collections, /shop, or homepage content

Current project context:
- We are still in the format-copying stage, so reference structure and pacing matter more than original redesign ideas.
- The page should feel like the DreamPlay version of the reference journal/blog index page.
- There is an existing BlogGrid component in the repo if pieces of it are useful, but do not force it if it hurts fidelity.

What to prioritize:
- blog index hierarchy and pacing
- featured article treatment vs secondary cards
- card spacing, metadata, and reading rhythm
- reference-like editorial feel rather than generic marketing cards
- DreamPlay-specific content tone/images

Constraints:
- keep this run scoped to /journal and minimal supporting files only
- avoid broad shared-header edits
- no generic placeholder redesigns
- use DreamPlay-appropriate imagery/content rather than generic content

Likely files:
- src/app/journal/page.tsx
- src/app/globals.css
- optionally one small data/support component if clearly justified

Verification requirements:
- inspect the reference page first
- run npm run lint
- run npm run build
- verify /journal locally in browser
- confirm only intended files changed before each push
- push meaningful progress directly to main so Lionel can review live

At the end print:
- summary of what changed
- commit(s)
- files touched
- any overlap risk with future Resources/header IA cleanup
