You are working in /home/claude/projects/concept-clone.

Task: do a fidelity pass on the DreamPlay Build Your Bundle page so it aligns more closely with the Shopify Concept bundle reference while keeping DreamPlay branding and using the current DreamPlay product direction.

Reference:
- https://concept-theme-tech.myshopify.com/pages/bundle

Live target:
- https://concept-page-1.vercel.app/build-your-bundle

Read first:
- /home/claude/projects/concept-clone/REVIEW_FAQ_AND_BUNDLE_FIDELITY_2026-04-10.md
- /home/claude/projects/concept-clone/DREAMPLAY_CURRENT_CATALOG_2026-04-10.csv
- /home/claude/projects/concept-clone/SESSION_DEBRIEF_2026-04-10_RESOURCES_AND_FAQ.md

Primary file:
- src/app/build-your-bundle/page.tsx

Goals:
1. Bring the page hierarchy closer to the Concept reference: hero -> restrained builder zone -> stronger right-side summary module -> simpler preset bundle modules below.
2. Reduce the feeling of a dense custom ecommerce grid inside the builder. The current page is too custom and too busy compared with the reference.
3. Make the right-side “Your Bundle” summary feel more like the core structural counterpart to the builder area, not just a lightweight progress widget.
4. Rework the preset bundle section so it feels simpler and more Concept-like in rhythm and composition, while remaining DreamPlay-branded.
5. Use current DreamPlay product direction where sensible instead of placeholder/random product families:
   - DreamPlay One
   - DreamPlay Pro
   - DreamPlay Bench
   - DreamPlay Premium Bundle is provisional
6. Keep discount/copy logic consistent at 30% off everywhere. Remove any 33% drift.
7. Preserve current nav/footer shell and current IA exactly.

Constraints:
- Keep scope narrow to /build-your-bundle unless a tiny shared fix is strictly required.
- Do not touch Resources or Features IA.
- Do not overbuild a complex app-like configurator if a simpler Concept-style structure is sufficient.
- Prefer a cleaner page structure over more widgets.

Verification:
- Run npm run lint
- Run npm run build
- Check git diff for cleanliness
- Commit and push if the result is solid

Deliverable:
- a more reference-faithful DreamPlay bundle page at /build-your-bundle
- committed + pushed changes
- brief summary of what changed and the commit hash
