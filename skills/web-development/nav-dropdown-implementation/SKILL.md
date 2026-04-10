---
name: nav-dropdown-implementation
description: Implement nav dropdown popup menus matching Shopify Concept theme with hover-triggered animations.
category: web-development
tags: [react, tailwind, animations, navigation, dropdown]
---

# Nav Dropdown Component - Shopify Concept Theme

This skill describes how to implement nav dropdown popup menus that match the Shopify Concept theme's hover-triggered navigation style.

## Reference URL
**https://themes.shopify.com/themes/concept/presets/concept**
- Click "View Demo" button
- Hover over nav items (Products, Features, Resources) to see dropdowns

## Key Animation Characteristics
- **Duration:** 300ms
- **Easing:** `cubic-bezier(0.4, 0.22, 0.28, 1)`
- **Effect:** Fade-in + slide-down (opacity 0→1, translateY)
- **Trigger:** `mouseenter` → show, `mouseleave` → hide
- **Position:** Absolute dropdown below nav item

## Implementation Pattern

### 1. NavDropdown Component Structure
```tsx
"use client";

import { useState, type ReactNode } from "react";
import ScrollReveal from "./ScrollReveal";

interface DropdownItem {
  text: string;
  href: string;
  isExternal?: boolean;
}

interface NavDropdownProps {
  label: string;
  items: DropdownItem[];
  children?: ReactNode;
}

export default function NavDropdown({ label, items, children }: NavDropdownProps) {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div
      className="nav-dropdown"
      onMouseEnter={() => setIsOpen(true)}
      onMouseLeave={() => setIsOpen(false)}
    >
      <a href="#" className="nav-link">
        {children || label}
        <span className="nav-arrow">
          <svg viewBox="0 0 24 24">
            <path d="M6 9l6 6 6-6" stroke="currentColor" strokeWidth="2" fill="none"/>
          </svg>
        </span>
      </a>
      {isOpen && (
        <ScrollReveal scrollReveal="slideDown" scrollRevealDelay="0.1">
          <ul className="nav-dropdown-menu">
            {items.map((item, idx) => (
              <li key={idx} className="nav-dropdown-item">
                <a href={item.href} className="nav-dropdown-link">
                  {item.text}
                  {item.isExternal && <ExternalIcon />}
                </a>
              </li>
            ))}
          </ul>
        </ScrollReveal>
      )}
    </div>
  );
}
```

### 2. CSS Styling Requirements

```css
/* Nav Dropdown Container */
.nav-dropdown {
  position: relative;
  display: inline-block;
}

/* Nav Link with Arrow */
.nav-link {
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 8px 0;
  transition: var(--transition);
}

/* Arrow Icon */
.nav-arrow {
  transition: transform 300ms cubic-bezier(0.4, 0.22, 0.28, 1);
}
.nav-dropdown:hover .nav-arrow {
  transform: translateY(2px);
}

/* Dropdown Menu */
.nav-dropdown-menu {
  position: absolute;
  top: 100%;
  left: 0;
  background: var(--white);
  min-width: 200px;
  padding: 12px 0;
  z-index: 100;
  opacity: 0;
  pointer-events: none;
  transform: translateY(-10px);
  transition: opacity 300ms cubic-bezier(0.4, 0.22, 0.28, 1), 
              transform 300ms cubic-bezier(0.4, 0.22, 0.28, 1);
}

/* Show on hover */
.nav-dropdown:hover .nav-dropdown-menu {
  opacity: 1;
  pointer-events: auto;
  transform: translateY(0);
}

/* Dropdown Items */
.nav-dropdown-item {
  padding: 8px 16px;
}

.nav-dropdown-link {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 13px;
  text-transform: uppercase;
  letter-spacing: 1px;
  transition: color 300ms;
}

.nav-dropdown-link:hover {
  color: var(--gold);
}

/* External Link Icon */
.external-link-icon {
  margin-left: auto;
  opacity: 0.5;
  transition: opacity 300ms;
}
.external-link-icon:hover {
  opacity: 1;
}
```

## Integration Steps

1. **Create NavDropdown.tsx** at appropriate component path
2. **Import into Header.tsx**: `import NavDropdown from "./NavDropdown";`
3. **Wrap nav items** that have dropdowns instead of plain links
4. **Define link arrays** with text, href, and optional isExternal flag
5. **Ensure ScrollReveal** handles the slide-down animation
6. **Add z-index: 100+** to prevent dropdown hiding under other elements

## Styling Conventions (Concept Theme Minimalism)
- No border, no shadow on dropdown menu
- Clean padding (~8-12px per item)
- Text color matches nav (inherit from parent)
- External link arrows with fade transition
- Hover arrow slide with `translateY(2px)`
- Arrow animation: `cubic-bezier(0.4, 0.22, 0.28, 1)`

## Files to Create/Modify
- `src/components/NavDropdown.tsx` — NEW dropdown component
- `src/components/Header.tsx` — MODIFY to use NavDropdown for categories
- `globals.css` — ADD dropdown styles

## Testing Checklist
- [ ] Nav items show dropdown on hover
- [ ] Dropdown animates smoothly (300ms)
- [ ] Dropdown hides on mouse leave
- [ ] Items styled consistently with theme
- [ ] External link arrows present
- [ ] Mobile: dropdown disabled or works differently

## Do NOT Change
- Existing AnnouncementBar, logo, mobile menu
- Basic nav link structure (only wrap categories with dropdowns)