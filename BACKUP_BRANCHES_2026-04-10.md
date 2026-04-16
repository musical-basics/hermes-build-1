# Backup Branches Reference

This note documents the explicit backup branches created to preserve pre-DreamPlay homepage states during the Concept -> DreamPlay transition.

## Purpose
These branches exist so we can safely:
- inspect earlier homepage states
- recover older Concept-theme layouts
- compare DreamPlay changes against the original reference-clone work
- cherry-pick specific sections or ideas back in later if needed

## Backup branches

### 1. `backup/concept-theme-homepage`
Points to commit:
- `8b921bd`

Meaning:
- older full Concept-style animated homepage baseline
- this is the main backup for the pre-DreamPlay `home2` experience before the homepage was refocused around DreamPlay merchandising

Use this when:
- we want to see the older Concept-style homepage treatment
- we want to recover a section, layout rhythm, or animation treatment from the earlier clone state

### 2. `backup/pre-dreamplay-homepage-split`
Points to commit:
- `433b55f`

Meaning:
- homepage/template split right before the real DreamPlay homepage pass
- homepage had already been simplified
- non-essential reference sections had already been moved into `/home-template`

Use this when:
- we want the cleaner pre-DreamPlay homepage shell
- we want to compare the DreamPlay homepage against the exact moment before real DreamPlay merchandising was layered in

## Live preservation inside the codebase
In addition to the git branches, the repo also preserves Concept-style section work at:
- `/home-template`

Meaning:
- the extra cloned/reference sections were not deleted
- they remain available as a section showroom / holding area

## Quick git commands
View the backup branches:
```bash
git branch -a | grep backup/
```

Check out a backup locally:
```bash
git checkout backup/concept-theme-homepage
```

or:
```bash
git checkout backup/pre-dreamplay-homepage-split
```

Compare current homepage against one backup:
```bash
git diff backup/concept-theme-homepage -- src/app/home2/page.tsx src/app/globals.css
```

Compare current homepage against the pre-DreamPlay split state:
```bash
git diff backup/pre-dreamplay-homepage-split -- src/app/home2/page.tsx src/app/globals.css
```

## Recommendation
Unless Lionel asks to fully revert, treat these branches as reference snapshots, not working branches.

Preferred use:
- inspect
- diff
- selectively recover ideas
- avoid broad rollback unless clearly needed
