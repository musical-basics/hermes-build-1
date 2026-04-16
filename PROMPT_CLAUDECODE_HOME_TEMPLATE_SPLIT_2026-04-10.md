You are working in /home/claude/projects/concept-clone.

Task: perform a structural homepage split for the DreamPlay storefront project.

Goal
- Keep the strongest sections on the real homepage.
- Move the non-essential but valuable Shopify Concept-inspired sections to a new template page.
- Preserve the work we already did instead of deleting it.
- Do NOT begin the real DreamPlay homepage asset/content replacement pass yet. This run is only for structure.

Important context
- `/` currently exports `./home2/page`.
- The current animated homepage contains many sections. We want the real homepage to become shorter and more conversion-focused.
- We want a separate page that preserves the extra reference sections.
- Keep the existing header, footer, announcement bar, and sitewide shell intact.
- Do not disturb other live routes.

Required outcome
1. Create a new route/page at:
   - `/home-template`
2. Move the non-essential homepage sections there.
3. Leave the real homepage with only the core kept sections.
4. Preserve existing functionality/animations as much as practical.
5. Keep the split clean and maintainable.

Homepage sections to KEEP on `/`
- Hero slider
- Brand intro
- Featured product
- Bundle builder (or current equivalent)
- One supporting lifestyle/ecosystem section
- Testimonial
- Value props
- Footer / popup / back-to-top

Homepage sections to MOVE to `/home-template`
- Full category cards block
- Comparison section
- Marquee
- Social feed
- Countdown timer / sale section
- Product grid
- Tabbed categories
- Blog / journal block
- Any other non-essential reference-preservation sections that make the homepage feel overcrowded

Implementation guidance
- Prefer extracting shared structure/components rather than duplicating huge blocks if that is the cleanest path.
- It is okay if `/home-template` is essentially the “reference showroom” page preserving the moved sections.
- Keep `/` as the real homepage route.
- Keep code easy to understand for the next pass.
- Do not start rewriting homepage copy into final DreamPlay product messaging yet beyond what is necessary for the split.
- Do not remove good work; relocate it.

Suggested architecture
- Keep a clean homepage composition for `/`
- Add a new page for `/home-template`
- If helpful, create shared section groupings or helper components under `src/components` so the split is not brittle

Verification required
- npm run lint
- npm run build
- verify both routes render:
  - /
  - /home-template
- confirm only intended files changed

Git
- Commit with a clear message
- Push to main when done

Deliverable
- Live `/` is a shortened core homepage
- Live `/home-template` preserves the moved sections
- Build remains stable
