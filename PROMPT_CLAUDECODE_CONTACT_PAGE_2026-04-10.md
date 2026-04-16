You are working in /home/claude/projects/concept-clone.

Task: build a new /contact page for DreamPlay with high visual fidelity to the Shopify Concept reference page:
https://concept-theme-tech.myshopify.com/pages/contact-with-map

Important constraints
- Preserve the current sitewide header, footer, announcement bar, and overall DreamPlay design system already established in this repo.
- This is a new page/route, not a redesign of other pages.
- Keep the current Resources and Features IA intact.
- Match Concept’s desktop layout closely before adding extra polish.
- Use DreamPlay brand copy/content, not Concept placeholder copy.
- Keep implementation scoped to the new contact page and any minimal supporting CSS needed in globals.css.
- Do not disturb existing pages.

Primary fidelity goals
1. Large editorial “Contact Us” heading with restrained supporting copy.
2. Two-column hero/body layout:
   - left: intro + contact form
   - right: large dark-toned map block
3. Form layout should match the reference structure closely:
   - row 1: Name / Email
   - row 2: Phone number / Subject select
   - row 3: Message textarea full width
   - CTA below: Send message
4. Beneath the form/map area, add a row of compact contact info cards/modules for:
   - Address
   - Email
   - Phone
   - Follow us
5. Keep the page premium, airy, and minimal — avoid making it feel corporate or generic.
6. Match Concept’s spacing rhythm, field sizing, rounded corners, card borders, and overall visual restraint.

DreamPlay-specific content to use
- Heading: Contact Us
- Intro copy: We’d love to hear from you. Whether you’re choosing your first instrument, booking a showroom visit, or need post-purchase support, our team is here to help.
- Address card:
  DreamPlay Showroom
  1825 Market Street
  San Francisco, CA 94103
- Email card:
  support@dreamplay.com
  concierge@dreamplay.com
- Phone card:
  +1 (415) 820-0180
  Mon – Fri: 9:00 – 18:00
- Follow us card:
  Facebook
  Instagram
  YouTube
  X
- Subject options:
  Product Consultation
  Order Support
  Showroom Visit
  Press
  Other

Implementation notes
- Create src/app/contact/page.tsx.
- Reuse the same site shell pattern as the other info pages (AnnouncementBar, Header, Footer, BackToTop).
- Use a page-scoped structure and CSS classes added to src/app/globals.css.
- The map can be implemented as a styled embedded map panel or a convincing static map-style block if needed, but it must visually read like the Concept right-column map area.
- If you use an iframe or embed, make sure it does not break build/runtime.
- Form does not need real backend submission; safe no-op or redirect behavior is fine.
- Keep the page browser-stable and build-stable.

Verification required
- npm run lint
- npm run build
- visually sanity-check the new /contact page structure

Git
- Commit your work with a clear message.
- Push to main when done.

Deliverable
- New live route: /contact
- High-fidelity DreamPlay version of Concept’s contact-with-map page
