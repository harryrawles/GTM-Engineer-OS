# Playbook: Home Services — Google Reviews & Local Visibility

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client selling review management,
local SEO, or reputation tools to home-service / trades businesses — led by **analysis and pattern
recognition** and small practical wins, not an upfront pitch.
**Origin:** Abstracted from a reviews/local-visibility campaign. All brand-specific values are placeholders —
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. If you claim to have "reviewed hundreds of businesses" or run an audit, that work must be real —
> and if Angle 4 offers a business-specific audit, actually run it before sending. Swap `{{AUDIT_TOOL}}` for
> the client's real tool. Keep the opt-out line. Never carry one client's specifics into another.

---

## Campaign Goal

Start value-first conversations with home-service businesses by showing how reviews actually influence local
visibility and bookings, and offering **simple, practical ways to improve ratings over time** — without
selling upfront.

## Ideal Customer Profile (ICP)

**Targets:**
- Plumbers
- HVAC companies
- Electricians
- Roofers
- Other service-area businesses

**Decision makers:**
- Owners
- GMs
- Operations managers
- Marketing managers

**Pain points:**
- Inconsistent Google reviews
- Strong service but weaker online perception
- Losing jobs to competitors with better ratings
- Not knowing what actually moves local rankings
- Review volume without real booking lift

## Core Messaging Strategy

- Lead with **analysis + pattern recognition** (you've studied hundreds of businesses)
- Focus on **what influences homeowner decisions**, not vanity metrics
- Offer **small, practical improvements** (3 ideas / quick wins)
- Keep the CTA extremely low friction
- Include an easy opt-out to build trust
- Tone: practical, grounded, non-salesy (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables — keep them as-is (`{{firstname}}`, `{{SendingAccountFirstName}}`).
`{{AUDIT_TOOL}}` = the client's real audit/reputation tool. Pick the angle that fits the target.

### Angle 1 — Ratings Influence Audit

```
Hi {{firstname}},

I've reviewed hundreds of service-area businesses and built a simple audit showing what most influences their Google ratings.

From that work, I pulled three practical ideas teams use to strengthen ratings over time.

Want me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 2 — Trades Review Patterns

```
Hi {{firstname}},

I've studied review patterns across plumbers, HVAC teams, electricians, and roofers to understand what actually shifts local visibility.

I pulled three straightforward opportunities teams use to strengthen booking activity.

Would you like me to share it?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 3 — Checklist + Homeowner Choice

```
Hi {{firstname}},

I've analyzed patterns from service contractors across the U.S. and built a checklist for improving review visibility.

It includes three quick wins that help homeowners choose you first.

Want me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 4 — Business-Specific Review Audit

```
Hi {{firstname}},

I just ran a review audit for your business using the same setup top service teams use on {{AUDIT_TOOL}}.

It shows your rating, recent customer feedback trends, and how you compare to nearby competitors.

Want me to send it over?

{{RANDOM|Thanks|Best|Regards}},
{{SendingAccountFirstName}}

Not relevant? Just let me know.
```

---

## Key Value Points (use only real, approved points)

- Based on real review data from service businesses
- Focuses on booking impact, not just star count
- Simple actions teams can implement immediately
- Competitive benchmarking included
- No pitch — just insight

## When to Use This Playbook

**Use when:**
- Targeting local service contractors
- Selling review management, local SEO, or reputation tools
- Outreach to owners/operators
- You want replies without demo pressure

**Avoid when:**
- Targeting multi-location enterprises only
- Businesses without Google Business Profiles
- Non-local service companies

---

## Adapting for a client (checklist)

- [ ] `{{firstname}}` / `{{SendingAccountFirstName}}` → confirm these Instantly fields exist and are mapped
- [ ] `{{AUDIT_TOOL}}` → the client's real audit/reputation tool (`offer.md`)
- [ ] "Reviewed hundreds of businesses" / audit claims are real — and for Angle 4, the business-specific audit is actually run before sending
- [ ] Confirm the offer and any claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Keep the opt-out line
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
