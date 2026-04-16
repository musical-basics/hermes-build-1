You are working in /home/claude/projects/concept-clone.

Task: do a narrow fidelity pass on the DreamPlay FAQ page so it matches the Shopify Concept reference more closely without changing the site IA or over-rewriting the page.

Reference:
- https://concept-theme-tech.myshopify.com/pages/faqs

Live target:
- https://concept-page-1.vercel.app/faq

Read first:
- /home/claude/projects/concept-clone/REVIEW_FAQ_AND_BUNDLE_FIDELITY_2026-04-10.md
- /home/claude/projects/concept-clone/SESSION_DEBRIEF_2026-04-10_RESOURCES_AND_FAQ.md

Primary file:
- src/app/faq/page.tsx

Goals:
1. Tighten the page hierarchy so it feels closer to the Concept FAQ reference.
2. Keep the broad two-column layout, but refine the proportions, gutters, category-card spacing, and overall vertical rhythm.
3. Make the right-side “Didn’t find your answer?” support area feel more like the reference in width, alignment, input sizing, and button treatment.
4. Reduce any overly custom/editorial hero styling that departs from the reference. Keep DreamPlay branding/copy, but bring the page closer to the reference’s calmer structure.
5. Keep the FAQ cards subtle and theme-native. Avoid over-styling or introducing a new visual system.
6. Preserve current nav/footer shell and current IA exactly.

Constraints:
- Keep scope narrow to /faq unless a tiny shared fix is strictly required.
- Do not change Resources or Features IA.
- Do not rewrite the entire page from scratch if a tighter refinement gets there.
- Do not introduce broken scroll-reveal behavior.

Verification:
- Run npm run lint
- Run npm run build
- Check git diff for cleanliness
- Commit and push if the result is solid

Deliverable:
- a closer Concept-style FAQ page at /faq
- committed + pushed changes
- brief summary of what changed and the commit hash
