# DreamPlay Shop Page - Next Steps Plan

## Goal
Turn `/shop` from a clean reference-clone collection page into a more premium DreamPlay merchandising page without trying to solve every PDP/catalog problem at once.

## Current status
What is already true:
- `/shop` is live and structurally functional
- horizontal toolbar/filter pattern already exists
- pagination exists
- quick view exists
- product cards already support swatches and badges
- page is cleaner than an unstyled collection, but it still reads as a generic theme adaptation rather than a premium DreamPlay storefront

## Main diagnosis
The shop page is not failing because it is broken.
It is underperforming because its merchandising and luxury cues are too weak.

Current weaknesses:
1. hero is too generic
2. toolbar/filter system is too light and not premium enough
3. product cards feel placeholder/generic for high-ticket instruments
4. assortment story is weak
5. overall polish is competent but not yet luxury

## Recommended priority order
We should not touch everything at once.

### Phase 1 - Top-of-page merchandising and structure
Focus first on the highest-visibility part of `/shop`:
- collection hero/banner
- breadcrumbs/title/value proposition
- toolbar/filter row
- category chip system

Why first:
- this sets the frame for the whole shopping experience
- if the top of the page feels premium, the product grid reads better immediately

### Phase 2 - Product card premium pass
Then upgrade the cards themselves:
- image quality and consistency
- title/price hierarchy
- badge treatment
- swatch treatment
- hover/quick-view polish
- any low-stock messaging that feels too mass-retail

Why second:
- this is where most of the page quality is won or lost
- current cards work, but they do not yet feel expensive enough

### Phase 3 - Lower-page merchandising and editorial support
After the top and cards are stronger:
- refine the lower editorial section
- decide whether Recently Viewed stays, changes, or becomes more premium
- tighten end-of-page trust/story flow

## Recommended immediate scope for the first shop pass
The first pass should stay narrow.

### Do now
1. Shop hero/banner refinement
- stronger DreamPlay collection positioning
- better luxury copy
- less generic "All products" feel
- keep the current structure if possible, but make it merchandised

2. Toolbar refinement
- make it feel more premium and substantial
- improve spacing, weight, and chip styling
- preserve horizontal filter behavior
- keep the controls understandable at a glance

3. Card review and ranking system
- identify which parts of the current card design are weakest:
  - imagery
  - card spacing
  - quick-view affordance
  - swatches
  - badge language
  - stock urgency tone

### Do not do yet
- no PDP work yet
- no whole-site metadata cleanup pass bundled into this
- no giant catalog/data model rewrite
- no broad nav/header redesign bundled into shop work

## Concrete high-value changes for the next implementation round

### A. Hero/banner
Target outcome:
- page opens with a stronger DreamPlay shopping proposition

Recommended changes:
- replace purely generic collection framing with DreamPlay-specific collection positioning
- keep title simple, but add stronger supporting copy beneath or near it
- make the banner feel like premium instrument shopping, not generic collection browsing
- consider copy angle around:
  - ergonomic key sizing
  - modern premium home pianos
  - finding the right fit for your hands and space

### B. Toolbar
Target outcome:
- toolbar feels premium and useful, not basic

Recommended changes:
- strengthen chip/button styling
- improve visual hierarchy between filters, count, and sort
- make category quick-links feel more curated
- potentially add one stronger placeholder action if it improves the composition

### C. Product cards
Target outcome:
- cards feel credible for expensive instruments

Recommended changes:
- use stronger image art direction where possible
- make title/price hierarchy more elegant
- reduce generic retail feel in urgency copy
- refine badge treatment so it feels curated, not promotional spam
- make swatches cleaner and more premium
- polish hover/quick-view behavior

## Best execution approach
This should be done in two steps, not one giant messy pass.

### Step 1
Write a short review/prompt for the shop top section and product-card pass.

### Step 2
Launch one Claude Code run scoped to `/shop` only.

Files likely involved:
- `src/app/shop/page.tsx`
- `src/app/shop/_components/*`
- `src/app/shop/_lib/*`
- `src/app/globals.css`

## My recommendation for the very next task
The next best move is:

### Write the shop pass prompt for:
- hero/banner refinement
- toolbar/filter polish
- product card premium pass

That is the right first implementation scope.

## Short version
- yes, we should begin work on `/shop` now
- do not start with everything
- start with the top of page plus product card premium pass
- keep it scoped to `/shop`
- make it feel more premium, merchandised, and DreamPlay-specific before touching deeper catalog problems
