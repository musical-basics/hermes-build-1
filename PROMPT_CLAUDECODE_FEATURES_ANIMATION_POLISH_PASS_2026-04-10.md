You are working in /home/claude/projects/concept-clone. Read CLAUDE.md first, then inspect the current local /features page before changing code.

This is a narrow animation-only polish pass.

Scope:
- /features only
- improve motion feel and transitions
- do not redesign layouts or rewrite content
- do not touch unrelated routes

Critical rules:
- Keep the real homepage at / unchanged.
- /home-header-ab and /nav-megamenu-ab remain sandbox routes only.
- Preserve the current /features structure and styling gains.
- Favor subtle premium motion over flashy effects.
- Push after each meaningful improvement so Lionel can review live.
- Use small reviewable commits directly to main.

Current state:
- The overall /features page now looks good enough structurally.
- The main remaining improvement Lionel wants is more animation and motion polish.
- Existing interactions/reveals should be improved, not replaced with something gimmicky.

Primary mission:
Add tasteful, reference-appropriate animation polish to /features so the page feels more alive and premium. Focus on scroll reveals, section entrances, image/copy timing, hover polish, and transitions between modules. Make motion help the editorial rhythm without hurting performance or making content disappear.

Focus especially on:
- stronger but still subtle section reveal choreography
- better stagger/timing for cards or metrics where appropriate
- premium hover/interactivity on feature modules and CTA areas
- smoother perceived pacing between hero, feature cards, and lower showcase sections
- avoiding any brittle logic that could blank content or leave sections invisible

Constraints:
- no heavy JS libraries
- no over-animation
- no runtime fragility
- no broad layout changes unless absolutely necessary to support motion polish

Likely files:
- src/app/features/page.tsx
- src/app/globals.css
- one small support utility/component only if clearly justified

Verification requirements:
- run npm run lint
- run npm run build
- verify /features locally in browser, not just with build success
- confirm only intended files changed before each push

At the end print:
- summary of animation improvements
- commits created
- files touched
- any remaining small polish gap after this pass
