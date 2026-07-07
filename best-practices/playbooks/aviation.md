# Playbook: HNWI / Private-Aviation Campaign

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client selling a discreet,
high-consideration service to **high-net-worth individuals and executives** - led by a helpful,
low-commitment "pricing overview" hook rather than a hard sell. Written around private aviation, but the
*offer-a-helpful-overview / opt-out / concierge* structure adapts to other HNWI concierge offers.
**Origin:** Abstracted from a private-flight campaign. All brand-specific values are placeholders -
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. Keep the opt-out line - it builds trust with this audience. Never carry one client's specifics
> into another.

---

## Campaign Goal

Start high-intent conversations with HNWIs by offering a **pricing / service overview** that feels helpful,
discreet, and low-commitment - not a hard sell.

## Ideal Customer Profile (ICP)

**Targets:**
- High-net-worth individuals
- Founders & CEOs
- C-suite executives
- Investors
- Senior operators who fly private or charter occasionally

**Common use cases:**
- Short-notice business travel
- Executive meetings
- Deal travel
- Regional and cross-country routes
- No interest in ownership or memberships

## Core Messaging Strategy

- Lead with **utility** (pricing overview, route visibility)
- Emphasise **simplicity** (no memberships, no commitments)
- Position the service as **on-demand & concierge-level**
- Keep the CTA ultra-light ("Can I send it over?")
- Add an **opt-out line** to maintain trust and reduce friction

---

## Sequence

Merge fields are Instantly variables - keep them as-is (`{{FirstName}}`, `{{City2}}`,
`{{SendingAccountFirstName}}`). `{{COMPANY}}` = the active client's brand.

### Email 1 - Pricing Overview Hook

```
Hey / Hi / Hello {{FirstName}},

I built a private flight overview highlighting typical pricing from {{City2}} to common destinations executives tend to book.

Would you like me to send it your way?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Follow Up 1 - Service Context + Flexibility

```
Hey / Hi / Hello {{FirstName}},

I put together a private flight overview outlining typical pricing from {{City2}} to destinations our executive clients book most often for short-notice and business travel.

{{COMPANY}} operates without memberships or ongoing commitments. You simply reach out when a flight is needed and we handle everything - with full coordination and coverage across key private aviation routes.

Can I send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Follow Up 2 - Simplicity & No-Commitment Angle

```
Hey / Hi / Hello {{FirstName}},

I put together a flight pricing overview for {{City2}} routes that executives often book.

No memberships required, no upfront fees, and flights are fully coordinated whenever needed.

Would it be helpful if I sent the list over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

Not relevant? Let me know.
```

---

## Optional Variants (other channels)

**Ultra-short:**
```
Hi {{FirstName}}, I put together private flight pricing from {{City2}} to common exec routes. Want me to send it over?
```

**LinkedIn DM:**
```
Hi {{FirstName}}, quick note - I built a private flight pricing overview for routes execs often book from {{City2}}. Happy to share if helpful.
```

**SMS:**
```
{{FirstName}}, I put together private flight pricing for common exec routes from {{City2}}. Want the overview?
```

---

## Key Selling Points (adapt to the client's real, approved points)

- Transparent private-flight pricing
- Executive-focused routes
- No memberships or long-term commitments
- Fully coordinated, concierge-level service
- Ideal for short-notice or business travel
- Discreet and on-demand

## When to Use This Playbook

**Use when:**
- Targeting HNWIs or executives
- Reaching founders, investors, C-suite
- Offering charter or private aviation services
- You want replies without selling upfront

**Avoid when:**
- Targeting leisure-only travellers
- Promoting jet ownership or fractional models
- Targeting price-sensitive audiences

---

## Adapting for a client (checklist)

- [ ] `{{COMPANY}}` → client brand (from `clients/{slug}/_config.md`)
- [ ] `{{FirstName}}` / `{{City2}}` / `{{SendingAccountFirstName}}` → confirm these Instantly fields exist and are mapped (`{{City2}}` is a custom lead field - verify it's populated)
- [ ] Confirm pricing/route/coverage claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Keep the opt-out line - it's core to trust with this audience
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
