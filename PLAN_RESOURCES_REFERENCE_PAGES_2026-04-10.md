# Resources Reference Pages Plan

Goal:
Clone the four reference-inspired Resources pages from the Shopify Concept demo into DreamPlay with high layout/format fidelity during the current copying stage.

Pages in scope:
- Our Story
- Our Journal
- FAQ
- Build Your Bundle

Reference source pages:
- Our Story → https://concept-theme-tech.myshopify.com/pages/about
- Our Journal → https://concept-theme-tech.myshopify.com/blogs/news
- FAQ → https://concept-theme-tech.myshopify.com/pages/faqs
- Build Your Bundle → https://concept-theme-tech.myshopify.com/pages/bundle

Rules:
- We are still in format-copying mode, so reference structure and pacing matter more than original redesign ideas.
- Keep the real homepage at / unchanged.
- /home-header-ab and /nav-megamenu-ab remain sandbox routes only.
- Use Claude Code for the heavier page-building work.
- Push each meaningful finished page so Lionel can review live.
- Prefer two Claude runs at a time, not four, to reduce overlap and confusion.

Current repo facts:
- There are no real app routes yet for these four pages.
- Existing reusable building blocks already present in the repo:
  - src/components/BundleBuilder.tsx
  - src/components/BlogGrid.tsx
  - src/components/BrandIntro.tsx
- Header currently still has old Resources items and will need a follow-up IA cleanup once these pages exist.

Recommended route targets:
- /our-story
- /journal
- /faq
- /build-your-bundle

Why these route names:
- clean and short
- easy to wire into the Resources dropdown later
- avoids nesting churn while we are still rapidly cloning pages

Execution strategy:
Do this in 2 batches of 2 pages.

Batch 1:
1. Our Story
2. Our Journal

Why first:
- both are mostly editorial/content-driven
- they establish the Resources section visually
- they likely benefit from shared rhythm, typography, and image-card patterns

Batch 2:
3. FAQ
4. Build Your Bundle

Why second:
- FAQ is structured/support-oriented
- Bundle is the most interactive page and likely needs the most custom logic/adaptation
- pairing them later lets us reuse whatever support/page-shell patterns batch 1 establishes

Non-overlap guidance for Claude runs:
- Run A should own only the files/routes/components for the first page in the batch.
- Run B should own only the files/routes/components for the second page in the batch.
- Shared header/nav IA changes should NOT be bundled into the page-building runs unless absolutely necessary.
- If shared styling in globals.css is unavoidable, keep each run scoped and review overlaps before pushing.

Per-page target outcome:

1) Our Story
- Copy the reference page’s overall editorial/about-page format.
- Use DreamPlay-specific brand copy, imagery, and product context.
- Prioritize hero composition, large editorial sections, and image/text pacing.
- Reuse/adapt BrandIntro only if it helps; do not force-fit it if it hurts fidelity.

2) Our Journal
- Copy the reference blog/index feeling and card hierarchy.
- Convert the existing generic BlogGrid direction into a real journal page with DreamPlay content.
- Focus on category/tag treatment, featured article hierarchy, card spacing, and reading rhythm.

3) FAQ
- Copy the reference FAQ page structure and interaction style.
- Focus on clean information hierarchy, accordion behavior if present, spacing, and support-page clarity.
- Keep it sturdy and simple rather than overdesigned.

4) Build Your Bundle
- Copy the reference bundle page format and conversion flow.
- Strong chance to reuse and upgrade src/components/BundleBuilder.tsx.
- Replace generic placeholder content/images with DreamPlay-relevant bundles or accessory groupings.
- Prioritize selection clarity, progress/discount feedback, and conversion-ready layout.

Suggested Claude sequence:

Phase 1 — recon/spec
- Inspect each reference page directly before implementation.
- Write short per-page review notes if useful.

Phase 2 — batch 1 implementation
- Run Claude process A: Our Story
- Run Claude process B: Our Journal
- Verify, review overlaps, lint/build, push

Phase 3 — batch 2 implementation
- Run Claude process C: FAQ
- Run Claude process D: Build Your Bundle
- Verify, review overlaps, lint/build, push

Phase 4 — IA hookup pass
- After the four routes exist and are visually solid, do one smaller follow-up pass to update Resources and Features nav grouping:
  - Resources: Our Story, Our Journal, FAQ, Build Your Bundle
  - Features: Piano Guides, Comparison Charts

Verification requirements for every batch:
- inspect the created pages locally in browser
- run npm run lint
- run npm run build
- confirm only intended files changed before push
- include live URL in review messages

My recommendation:
- definitely use 2 Claude runs at a time, not 4
- batch 1 should be Our Story + Our Journal
- batch 2 should be FAQ + Build Your Bundle
- keep header IA cleanup as a separate smaller pass after the pages exist
