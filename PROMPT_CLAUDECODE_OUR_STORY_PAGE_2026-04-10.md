You are working in /home/claude/projects/concept-clone. Read CLAUDE.md first, then inspect the Shopify Concept reference page before changing code.

Task:
Create the DreamPlay equivalent of the reference Our Story page.

Reference page:
- https://concept-theme-tech.myshopify.com/pages/about

Route target:
- /our-story

Scope:
- build only the /our-story page and any minimal support files it truly needs
- do not touch unrelated routes
- do not do the Resources nav IA cleanup in this run
- do not modify /features, /collections, /shop, or homepage content

Current project context:
- We are still in the format-copying stage, so reference structure and pacing matter more than original redesign ideas.
- The page should feel like the DreamPlay version of the reference about/story page.
- Use DreamPlay imagery/content tone, but copy the reference page format, hierarchy, and editorial rhythm closely.
- There is an existing BrandIntro component in the repo if parts of it are useful, but do not force it if it hurts fidelity.

What to prioritize:
- overall page structure and pacing
- hero/editorial layout composition
- image-text rhythm
- spacing, hierarchy, and section transitions
- premium reference-like feel

Constraints:
- keep this run scoped to /our-story and minimal supporting files only
- avoid broad shared-header edits
- no generic placeholder redesigns
- use DreamPlay-appropriate imagery/content rather than generic content

Likely files:
- src/app/our-story/page.tsx
- src/app/globals.css
- optionally one small data/support component if clearly justified

Verification requirements:
- inspect the reference page first
- run npm run lint
- run npm run build
- verify /our-story locally in browser
- confirm only intended files changed before each push
- push meaningful progress directly to main so Lionel can review live

At the end print:
- summary of what changed
- commit(s)
- files touched
- any overlap risk with future Resources/header IA cleanup
