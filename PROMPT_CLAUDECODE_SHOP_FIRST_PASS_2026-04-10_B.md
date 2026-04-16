You are working in /home/claude/projects/dreamplay-shop-2.

Task: do the next implementation pass on the DreamPlay /shop page first.

This is a premium merchandising/fidelity pass, not a full catalog-system rewrite.

Read first:
- /home/claude/projects/dreamplay-shop-2/PLAN_SHOP_NEXT_STEPS_2026-04-10.md
- /home/claude/projects/dreamplay-shop-2/DREAMPLAY_CURRENT_CATALOG_2026-04-10.csv
- /home/claude/projects/dreamplay-shop-2/SESSION_DEBRIEF_2026-04-10_RESOURCES_AND_FAQ.md

Reference:
- Shopify Concept live demo collection behavior and visual language
- Keep the Concept-style horizontal filter/toolbar behavior and premium collection feel

Live target:
- https://concept-page-1.vercel.app/shop

Primary goal:
Make /shop feel more premium, merchandised, and DreamPlay-specific.

Scope for this first pass:
1. Top-of-page merchandising and structure
- refine the collection hero/banner
- improve breadcrumbs/title/value proposition
- make the top framing feel like premium DreamPlay piano shopping, not generic “all products” browsing

2. Toolbar / horizontal filters polish
- preserve horizontal filter behavior
- improve spacing, hierarchy, chip/button styling, and overall weight
- make category quick-links feel more curated and premium

3. Product card premium pass
- improve image presentation where possible
- refine title/price hierarchy
- tighten badge treatment
- make swatches/variant cues cleaner
- polish hover / quick-view affordances
- reduce any generic mass-retail urgency tone

Catalog direction to use:
- DreamPlay One
- DreamPlay Pro
- DreamPlay Bench
- DreamPlay Premium Bundle is provisional, use carefully

Important constraints:
- Keep scope to /shop only unless a tiny shared fix is strictly required
- Do not start PDP work
- Do not do a giant catalog/data model rewrite
- Do not bundle nav/header redesign into this task
- Preserve current Resources and Features IA exactly

Files likely involved:
- src/app/shop/page.tsx
- src/app/shop/_components/*
- src/app/shop/_lib/*
- src/app/globals.css

Verification:
- Run npm run lint
- Run npm run build
- Visually sanity-check the page if feasible
- Check git diff for cleanliness
- Commit and push if solid

Deliverable:
- improved /shop page pushed live
- brief summary of what changed
- commit hash
- live URL for review
