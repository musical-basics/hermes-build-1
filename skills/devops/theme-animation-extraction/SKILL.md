---
name: theme-animation-extraction
description: >
  Automatically extract CSS animations from live theme demos (Shopify, React apps)
  using Playwright. Targets embedded iframe on marketplace pages when demos are
  password-protected. Extracts @keyframes, transition rules, hover states, and
  timing curves for cloning purposes.
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [playwright, theme-cloning, animation-extraction, shopify, css-analysis]
    category: devops
---

# Theme Animation Extraction & Cloning Workflow

**Use when:** Replicating CSS animations from a live theme/demo that requires login.
Examples: Shopify themes, Angular/React app demos, React component libraries.

## Key Learning: Bypassing Password-Protected Demos
Most theme demos require login. **DO NOT** navigate to the demo URL directly.
Instead, target the **embedded iframe** from the marketplace page:

```
Marketplace: https://themes.shopify.com/themes/concept/presets/concept
Demo embed: Extract from page source → iframe src="https://*.myshopify.com"
```

## Prerequisites
- Playwright installed: `npx playwright install`
- Node.js environment
- Target marketplace page URL

## Step-by-Step Workflow

### Step 1: Navigate to Marketplace Page
```javascript
await page.goto('https://themes.shopify.com/themes/concept/presets/concept');
```

### Step 2: Click "View Demo" Button
```javascript
await page.click('button[aria-label="View Demo"]');
// Wait for iframe to load
await page.waitForSelector('iframe');
```

### Step 3: Extract Iframe URL
```javascript
const iframeSrc = await page.$eval('iframe', el => el.src);
```

### Step 4: Navigate to iframe Content
```javascript
await page.goto(iframeSrc);
```

### Step 5: Scroll Full Page to Trigger Intersection Observers
```javascript
// Concept theme uses scroll reveal animations — must scroll to capture all
for (let pos = 0; pos < 6000; pos += 400) {
  await page.evaluate(() => window.scrollBy(0, 400));
  await page.waitForTimeout(500);
}
```

### Step 6: Extract @keyframes Rules
```javascript
const keyframes = await page.evaluate(() => {
  const rules = [];
  Array.from(document.styleSheets).forEach(ss => {
    try {
      Array.from(ss.cssRules || []).forEach(rule => {
        if (rule.cssType === CSSRule.KEYFRAMES_RULE) {
          rules.push({
            name: rule.name,
            keyframes: Array.from(rule.cssText.split('}')).filter(t => t.trim())
          });
        }
      });
    } catch (e) { /* skip cross-origin stylesheets */ }
  });
  return rules;
});
```

### Step 7: Capture Transition Rules on All Elements
```javascript
const transitions = await page.evaluate(() => {
  const results = [];
  document.querySelectorAll('*').forEach(el => {
    const styles = getComputedStyle(el);
    if (['transform', 'opacity', 'filter', 'clipPath'].some(prop => styles[prop] && 
        (styles.transitionProperty || styles.transitionDuration))) {
      results.push({
        selector: Array.from(el.parents).join(' > '),
        transition: styles.transitionProperty,
        duration: styles.transitionDuration,
        easing: styles.transitionTimingFunction
      });
    }
  });
  return results;
});
```

### Step 8: Capture Hover State Diffs
```javascript
// For each element with hover state, capture before/after
const hoverDiffs = {};
elements.forEach(el => {
  const before = getComputedStyle(el);
  el.dispatchEvent(new MouseEvent('mouseenter'));
  const after = getComputedStyle(el);
  const changes = {};
  Object.keys(after).forEach(prop => {
    if (before[prop] !== after[prop]) {
      changes[prop] = { before: before[prop], after: after[prop] };
    }
  });
  if (Object.keys(changes).length) {
    hoverDiffs[el] = changes;
  }
  el.dispatchEvent(new MouseEvent('mouseleave'));
});
```

## Extracted Animation Specs (Concept Theme Example)
```json
{
  "keyframes": {
    "fadeInSlide": [
      {"0%": "opacity: 0"},
      {"100%": "opacity: 1"}
    ],
    "spin": [
      {"0%": "transform: rotate(0deg)"},
      {"100%": "transform: rotate(360deg)"}
    ]
  },
  "transitionRules": [
    {
      "selector": ".ma .link__arrow-inner",
      "transition": "transform 300ms cubic-bezier(0.4, 0.22, 0.28, 1)",
      "animation": null
    },
    {
      "selector": ".ma .footer-link",
      "transition": "color 300ms ease-in-out",
      "animation": null
    }
  ],
  "hoverDiffs": {
    ".nav-link": {
      "transform": { "before": "translateX(0)", "after": "translateX(4px)" },
      "color": { "before": "#ffffff", "after": "#ff6347" }
    }
  }
}
```

## Output Formats
Save results to:
```
scripts/scrape-output-{version}.json  # Raw scraped data
ANIMATIONS.md                          # Human-readable spec
```

## Token Usage Pattern
- **In:** 3,000-5,000 tokens (prompt + Playwright setup)
- **Out:** 5,000-15,000 tokens (full extraction + formatted output)
- **Total:** 8,000-20,000 tokens per session

## Pitfalls & Workarounds
1. **Cross-origin stylesheets won't load** — catch errors when accessing `ss.cssRules`
2. **Intersection observers need scrolling** — scroll in 400px increments
3. **Frame context issues** — the concept theme sometimes renders in multiple frames; inspect and target the main frame
4. **Timing-sensitive animations** — wait at least 500ms after scroll before capturing

## Integration with Codebase
After extraction:
1. Save to `scripts/scrape-output.json`
2. Generate `ANIMATIONS.md` with CSS code snippets
3. Review and select relevant animations for cloning
4. Create corresponding React components with `useScrollReveal` hook
5. Apply to target pages using extracted easing curves and durations