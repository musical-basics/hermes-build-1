You are working in /home/claude/projects/concept-clone.

Task:
Implement the first real DreamPlay homepage pass on `/` only.

Read these files first:
- /home/claude/projects/concept-clone/HOMEPAGE_MERCHANDISING_MAP_2026-04-10.md
- /home/claude/projects/concept-clone/PLAN_HOMEPAGE_SCOPE_AND_TEMPLATE_PAGE_2026-04-10.md
- /home/claude/projects/concept-clone/CLAUDE.md

Goal:
Turn the homepage into a more intentional DreamPlay homepage using the approved merchandising map, while keeping the page structure relatively tight and preserving `/home-template` as the holding area for moved reference sections.

Critical approved positioning:
- DreamPlay should foreground ergonomic keyboard sizing
- the homepage should emphasize reducing pain and strain for players
- DS 5.5 and DS 6.0 are important named size proof points
- keep the hero headline cleaner, but surface DS 5.5 / DS 6.0 clearly in the first product/detail section below

Scope:
- homepage route only (`/`)
- use real DreamPlay assets already in the repo where possible
- strengthen homepage section order, copy direction, image assignments, and CTA flow
- preserve a clean path to `/shop`, `/build-your-bundle`, `/features`, and `/our-story`

Do not:
- do not work on `/shop` yet
- do not restructure the Resources/Features IA
- do not delete `/home-template`
- do not do a broad site-wide rewrite
- do not re-bloat the homepage with all the template/reference sections that were moved out

Implementation direction:
1. Keep the homepage focused on the core sections only
2. Make the hero feel like DreamPlay, not generic theme demo content
3. Make the first real product/detail section explicitly communicate the ergonomic story
4. Include DS 5.5 and DS 6.0 in that early product/detail framing
5. Keep family/lifestyle and app/connectivity as supporting proof layers
6. Keep a bundle/setup path to `/build-your-bundle`
7. Keep one premium/editorial moment lower on the page if it still fits cleanly
8. Preserve or improve testimonial/trust/value-props if they support the new narrative

Asset guidance from the approved map:
- Hero: Piano-Front-2.jpg or dreamplay-one-main-product-in-studio.avif
- Family/lifestyle: dreamplay-hero-2-4.jpg
- App/connectivity: DreamPlay-piano-with-Midi-app-copy.png
- Bundle/setup: Piano-Bench-Frontal-Bundle.png
- Premium halo: Gold-DS-6.0-full.png
- Founder/authority if used: lionel-yu-carnegie-hall.png

CTA guidance:
- primary homepage CTA should point to `/shop`
- bundle/setup CTA should point to `/build-your-bundle`
- app/connectivity CTA can point to `/features`
- softer editorial/trust CTA can point to `/our-story`

Quality bar:
- the homepage should clearly feel more like DreamPlay than before
- the ergonomic keyboard message should be noticeable early
- DS 5.5 / DS 6.0 should appear as meaningful proof points, not random labels
- page should stay tighter than the old homepage
- avoid filler copy and avoid sounding generic

Required verification before finishing:
- inspect local git diff for scope sanity
- run npm run lint
- run npm run build
- if a verification artifact folder or temp build folder is created, clean it up before finishing
- commit your changes
- push to origin main

When done, leave the repo clean except for intentional untracked planning/prompt docs already in the workspace.