# FAQ + Build Your Bundle Fidelity Review

Generated: 2026-04-10
Repo: /home/claude/projects/concept-clone
Live site: https://concept-page-1.vercel.app
Reference demo: https://concept-theme-tech.myshopify.com

## Scope
Focused comparison for:
- /faq vs /pages/faqs
- /build-your-bundle vs /pages/bundle

Keep current DreamPlay IA intact:
- Resources = Our Story, Our Journal, FAQ, Build Your Bundle
- Features = Features, Piano Guides, Comparison Charts

---

## FAQ — current status
Live URL: https://concept-page-1.vercel.app/faq
Reference: https://concept-theme-tech.myshopify.com/pages/faqs

### What already matches reasonably well
- Broad two-column desktop structure exists
- Right-side support form exists
- Stacked FAQ category cards exist
- Accordion rows and plus/cross affordance exist
- Footer/trust-strip overall page framing is present

### Highest-value remaining fidelity gaps
1. Hero/title treatment is too custom and too separated from the reference
- Current page uses a stronger editorial hero with breadcrumb + horizontal rule
- Reference is more direct: oversized title, short intro, then content
- Reduce the bespoke hero feel and match the calmer reference hierarchy

2. Sidebar support block still feels too detached from the reference treatment
- Current support area reads like a plain floating form
- Reference feels more intentionally aligned and proportioned against the FAQ stack
- Tighten vertical alignment, width, spacing, and input/button proportions

3. Card and spacing rhythm still needs Concept-style restraint
- Current page feels premium but slightly too custom/roomy in places
- Match the reference more closely for card padding, gutter size, and category spacing
- Keep borders subtle; avoid over-styling

4. Category labels and descriptions should mirror the reference more tightly
- Reference naming/order is simpler: Shipping & Returns, Orders, Products
- Current copy is acceptable but should feel closer to the reference cadence and density

### Desired end state for FAQ
- Feels recognizably like the Concept FAQ page in structure and spacing
- Keeps DreamPlay copy/content
- Preserves current nav/footer/IA
- Avoids over-designing or introducing new systems

---

## Build Your Bundle — current status
Live URL: https://concept-page-1.vercel.app/build-your-bundle
Reference: https://concept-theme-tech.myshopify.com/pages/bundle

### What already matches reasonably well
- Hero exists and is directionally similar
- “Buy 3 and save 30%” framing exists
- Right-side bundle summary exists
- Preset bundle section exists below the builder
- Overall page has a premium DreamPlay adaptation rather than a raw placeholder

### Highest-value remaining fidelity gaps
1. Builder structure is too custom and too dense versus the reference
- Current page shows top slot pills + a dense product-card grid immediately under the intro
- Reference gives more breathing room and a more restrained custom-builder zone with the summary module doing more visual work
- Reduce the feeling of a full ecommerce grid dropped into the page

2. Right-side summary module is too lightweight / too different from the reference
- Current summary reads more like a progress widget than a bundle cart panel
- Reference summary is the main structural counterpart to the left builder area
- Strengthen the card structure, line-item treatment, total row, and CTA posture

3. Preset bundle cards are too editorial-list-like compared with the reference’s simpler module rhythm
- Current “Popular Bundle Sets” cards feel like separate merchandising rows
- Reference preset sections are simpler, more theme-native, and more integrated into the page flow
- Rework preset blocks to feel closer to Concept bundle modules without losing DreamPlay branding

4. Product data should align with the current DreamPlay catalog seed where sensible
Use the current catalog file as the source of truth where possible:
- /home/claude/projects/concept-clone/DREAMPLAY_CURRENT_CATALOG_2026-04-10.csv
Current strongest product family priorities:
- DreamPlay One
- DreamPlay Pro
- DreamPlay Bench
- DreamPlay Premium Bundle (provisional)
Do not invent random non-DreamPlay product families if they are avoidable.

5. Fix copy consistency around the bundle discount
- Keep the page consistently at 30% off
- Avoid any 33% language drift or mismatched progress copy

### Desired end state for Build Your Bundle
- Closer to Concept page hierarchy: hero -> custom builder zone with stronger right summary -> simpler preset bundle modules
- Still DreamPlay-branded and compatible with current site shell
- Uses current product catalog direction instead of placeholder/random accessory taxonomy where possible
- No nav/footer/IA regressions

---

## Recommended execution approach
Because FAQ and Build Your Bundle are separate routes with non-overlapping primary files, run them as two separate Claude Code lanes:

1. FAQ lane
- Main target: src/app/faq/page.tsx
- Goal: tighten structure/spacing/sidebar fidelity against the reference

2. Build Your Bundle lane
- Main target: src/app/build-your-bundle/page.tsx
- Goal: simplify the builder structure, strengthen the right summary module, and align the data/copy direction with DreamPlay catalog reality

## Guardrails for both lanes
- Preserve current Resources + Features IA
- Do not touch nav grouping/content except if a page import requires a minimal safe fix
- Do not create new shared global systems unless absolutely necessary
- Verify with npm run lint and npm run build
- Push when done so live Vercel can be reviewed
