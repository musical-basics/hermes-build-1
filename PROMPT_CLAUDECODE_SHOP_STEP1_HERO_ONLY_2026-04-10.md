You are working in /home/claude/projects/dreamplay-shop-2.

Task: make only the first small /shop improvement pass.

Scope for this run:
- hero/banner area only
- no product card work yet
- no toolbar/filter redesign yet
- no catalog rewrite
- no nav/header/footer changes

Read first:
- /home/claude/projects/dreamplay-shop-2/PLAN_SHOP_NEXT_STEPS_2026-04-10.md
- /home/claude/projects/dreamplay-shop-2/DREAMPLAY_CURRENT_CATALOG_2026-04-10.csv

Goal:
Make the top of /shop feel more premium and more DreamPlay-specific while keeping the existing structure simple.

Focus only on:
- breadcrumb polish if needed
- page title
- short supporting copy
- spacing / visual hierarchy in the hero area

Use this product direction:
- DreamPlay One
- DreamPlay Pro
- ergonomic key sizing
- premium home piano shopping

Constraints:
- change as little as possible outside the hero section
- keep the result elegant and restrained
- preserve current IA exactly
- do not touch product grid behavior
- do not touch filters yet

Likely files:
- src/app/shop/_components/ShopHero.tsx
- src/app/globals.css

Verification:
- run npm run lint
- run npm run build
- check git diff is limited and clean
- commit and push if solid

Deliverable:
- only the hero/top-of-page improvement for /shop
- commit hash
- live URL for review
