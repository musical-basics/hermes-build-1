# DreamPlay Shop First Pass Implementation Plan

Repo
- /home/claude/projects/dreamplay-shop-2
- origin: https://github.com/musical-basics/dreamplay-shop-2.git

Goal
Make /shop feel more premium, merchandised, and DreamPlay-specific without expanding into PDP work or a full catalog rewrite.

Approved scope
1. Refine shop hero/banner
2. Polish toolbar / horizontal filter row
3. Do first premium product-card pass
4. Keep scope to /shop unless a tiny shared style fix is strictly required

Working product direction
- DreamPlay One
- DreamPlay Pro
- DreamPlay Bench
- DreamPlay Premium Bundle as provisional

Current status
- Claude Code was launched once and made partial edits, then hung without a clean completion message.
- Partial local edits currently exist in:
  - src/app/shop/_components/ShopHero.tsx
  - src/app/shop/_components/ProductCard.tsx
  - src/app/shop/_components/QuickBuyDrawer.tsx
  - src/app/shop/_lib/shop-constants.ts
  - src/app/shop/_lib/shop-types.ts
  - src/app/shop/page.tsx
  - src/app/globals.css
- Nothing has been committed or pushed yet.

Observed direction of partial edits
- Replaces generic piano placeholder catalog with DreamPlay-specific products and local assets
- Updates hero from generic all-products framing to DreamPlay collection framing
- Improves card subtitle / price / swatch / badge treatment
- Softens urgency language from mass-retail style to premium tone
- Updates quick-view drawer copy and pricing presentation
- Adjusts shop hero, toolbar, and card styling in globals.css

Open verification tasks
1. Review diff for correctness and fidelity
2. Run lint cleanly
3. Run build cleanly
4. Visually sanity-check /shop if needed
5. Commit and push only if solid

Likely follow-up if partial edits are good
- Keep the DreamPlay-specific catalog and copy changes
- Verify toolbar still preserves horizontal Concept-like behavior
- Push as first /shop merchandising pass

Likely follow-up if partial edits are not good
- Revert only the weak pieces
- Keep the safest narrow improvements
- Relaunch Claude with a smaller step-by-step prompt for the next sub-pass
