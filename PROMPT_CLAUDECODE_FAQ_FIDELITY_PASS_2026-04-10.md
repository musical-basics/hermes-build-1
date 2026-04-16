You are working in /home/claude/projects/concept-clone. Read CLAUDE.md first, then inspect both the Shopify Concept reference FAQ page and the current local /faq page before changing code.

Task:
Do one more narrow fidelity pass on /faq.

Reference page:
- https://concept-theme-tech.myshopify.com/pages/faqs

Current state:
- /faq now has the correct broad two-column structure and right-side support box.
- Lionel wants one more pass specifically for fidelity.
- This is not a rebuild; it is a polish/refinement pass to make the layout feel more reference-accurate.

Scope:
- /faq only
- minimal CSS/support adjustments only if clearly needed
- do not touch unrelated routes
- do not change header IA or other pages in this run

Primary mission:
Tighten /faq so it feels closer to the reference in spacing, proportions, hierarchy, support-box presentation, and FAQ group rhythm.

Focus especially on:
- exact balance between left FAQ column and right support box
- heading/subheading spacing and density
- category label treatment and separation
- support box framing, padding, and visual weight
- overall page cadence and whitespace
- making the page feel reference-like rather than merely structurally similar

Constraints:
- narrow fidelity pass only
- no generic redesign
- no unnecessary shared CSS churn
- preserve the current correct two-column structure
- push once verified so Lionel can review live

Likely files:
- src/app/faq/page.tsx
- src/app/globals.css

Verification requirements:
- inspect reference first
- run npm run lint
- run npm run build
- verify /faq locally in browser
- confirm only intended files changed
- push direct to main

At the end print:
- brief summary
- commit hash
- files touched
- what the main remaining FAQ fidelity gap is, if any
