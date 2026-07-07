# Playbook: Marketing 2 - Local Traffic & Website-Conversion Campaign

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client selling marketing / SEO / CRO /
traffic-partnership services to **local businesses, trades, and professional service firms** - led by
local relevance + a value-first resource (traffic opportunities or a website-conversion guide), no hard sell.
**Origin:** Abstracted from a local-marketing campaign. All brand-specific values are placeholders -
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. If you offer a guide or "top options", have them ready to send. Keep the opt-out line. Never carry
> one client's specifics into another.

---

## Campaign Goal

Start warm, value-first conversations with local businesses and professional service firms by offering
either **qualified inbound-traffic opportunities** or **simple website-conversion insights** that uncover
lost leads. No hard sell - relevance + utility.

## Ideal Customer Profile (ICP)

**Targets:**
- Local service businesses
- Trade businesses (contractors, home services, etc.)
- Professional service firms
- SMB owners & founders
- Marketing decision-makers at local companies

**Pain points:**
- Relying too heavily on referrals
- Website not generating inbound calls or leads
- Low-quality traffic
- Unclear messaging or weak CTAs
- Losing inquiries without realising it

## Core Messaging Strategy

- Start with **local relevance** (same city)
- Position yourself as a **partner, not a vendor**
- Lead with **resources** (guides, checklists, traffic sources)
- Keep the CTA permission-based ("Can I send it?")
- Always include a respectful opt-out
- Tone: helpful, direct, non-pushy (defer to `clients/{slug}/voice.md`)

---

## Sequences

Merge fields are Instantly variables - keep them as-is (`{{FirstName}}`, `{{City}}`, `{{CompanyName}}`,
`{{SendingAccountFirstName}}`, and the custom industry field `{{lcsi}}`). Pick the angle that fits the
target segment; each ships with an A/B variant to test.

### Angle 1 - Local Traffic Partnerships

**Version A**
```
Hey / Hi / Hello {{FirstName}},

Realized you're in {{City}} and wanted to connect directly. I'm partnering with a few well-known websites that are currently featuring local businesses and sending qualified visitors their way.

{{CompanyName}} stood out as a strong fit.

Mind if I send over a couple that seem like a match?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

**Version B (expanded)**
```
Hey / Hi / Hello {{FirstName}},

Noticed you're in {{City}} and wanted to reach out personally. I'm working with a few reputable websites that feature local businesses and send high-intent visitors their way.

{{CompanyName}} caught my eye as a strong fit.

Would you like me to send over the top options that make the most sense?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 2 - Website Readiness / Inbound Guide (Trade Businesses)

**Version A**
```
Hey / Hi / Hello {{FirstName}},

I created a simple website readiness guide for trade businesses like {{CompanyName}} that want inbound calls coming from their site instead of relying only on referrals.

It flags gaps in messaging, design, speed, mobile experience, SEO basics, and calls to action - all with quick yes/no checks.

Want a copy?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

**Version B**
```
Hey / Hi / Hello {{FirstName}},

I put together a quick guide that highlights where {{CompanyName}} might be losing inquiries on your website without noticing.

It covers messaging clarity, layout friction, load-time signals, and conversion paths in a simple checklist.

Should I send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 3 - Professional Services Conversion Gaps

**Version A**
```
Hey / Hi / Hello {{FirstName}},

I put together a guide showing where professional service websites lose leads without realizing it. It reviews messaging clarity, layout friction, mobile flow, and speed signals.

I pulled a version aligned specifically with {{CompanyName}}.

Want me to share it?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

**Version B (industry-specific)**
```
Hey / Hi / Hello {{FirstName}},

I've been reviewing how professional service sites build trust and pulled a short guide highlighting credibility gaps, weak CTAs, and structure issues.

I drafted a version based on what prospects expect from firms in the {{lcsi}} space.

Should I send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

---

## Key Selling Points

- Hyper-local relevance
- Qualified traffic vs. generic ads
- Simple, actionable website insights
- No pitch upfront
- Works for trades & professional services
- Easy opt-in / opt-out

## When to Use This Playbook

**Use when:**
- Targeting local or regional businesses
- Selling marketing, SEO, CRO, or traffic partnerships
- You want replies without booking pressure
- Outreach to owners or operators

**Avoid when:**
- Targeting large enterprises

---

## Adapting for a client (checklist)

- [ ] `{{FirstName}}` / `{{City}}` / `{{CompanyName}}` / `{{lcsi}}` / `{{SendingAccountFirstName}}` → confirm these Instantly lead/account fields exist and are mapped
- [ ] The guide, checklist, or "top options" actually exist and are ready to send before the hook goes out
- [ ] Confirm the offer and any claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Pick the angle (traffic / trades / professional services) that matches the target segment; run A/B as a test in `test-log.md`
- [ ] Keep the opt-out line
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
