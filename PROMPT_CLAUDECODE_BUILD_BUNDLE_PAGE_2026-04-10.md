You are working in /home/claude/projects/concept-clone. Read CLAUDE.md first, then inspect the Shopify Concept reference bundle page before changing code.

Task:
Create the DreamPlay equivalent of the reference Build Your Bundle page.

Reference page:
- https://concept-theme-tech.myshopify.com/pages/bundle

Route target:
- /build-your-bundle

Scope:
- build only the /build-your-bundle page and any minimal support files it truly needs
- do not touch unrelated routes
- do not do broader Resources nav IA work in this run
- do not modify /features, /collections, /shop, /journal, /our-story, or homepage content unless absolutely required for this route to work

Current project context:
- We are still in the format-copying stage, so reference structure and pacing matter more than original redesign ideas.
- The page should feel like the DreamPlay version of the reference bundle page.
- There is an existing BundleBuilder component in the repo if useful, but do not force it if it hurts fidelity.
- Replace generic placeholder content/images with DreamPlay-relevant bundle content.

What to prioritize:
- reference bundle-page layout and conversion flow
- clear selection states and summary logic
- progress/discount feedback
- premium merchandising feel
- DreamPlay-specific products/accessories/copy instead of generic placeholder items

Constraints:
- keep this run scoped to /build-your-bundle and minimal supporting files only
- avoid broad shared-header edits
- no generic placeholder redesigns
- preserve runtime stability

Likely files:
- src/app/build-your-bundle/page.tsx
- src/components/BundleBuilder.tsx
- src/app/globals.css
- one small support file if clearly justified

Verification requirements:
- inspect the reference page first
- run npm run lint
- run npm run build
- verify /build-your-bundle locally in browser
- confirm only intended files changed before each push
- push meaningful progress directly to main so Lionel can review live

At the end print:
- summary of what changed
- commit(s)
- files touched
- any overlap risk with later Resources/header cleanup
