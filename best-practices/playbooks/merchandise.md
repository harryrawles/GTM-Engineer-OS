# Playbook: Merchandise - Apparel & Merch (Church / Community)

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client selling apparel / merch
printing to trust-sensitive, community-led buyers (churches, ministries, and similar) - led by
**experience, proof, and risk-reduction resources** (guides, mockups, buyer's guides), not an upfront pitch.
**Origin:** Abstracted from a church-apparel campaign. All brand-specific values are placeholders -
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. Volume/experience claims (e.g. "thousands of church orders") must be real and approved. Have the
> guide, mockup capability, or buyer's guide ready before the hook. Keep the opt-out line. Never carry one
> client's specifics into another.

---

## Campaign Goal

Start warm, trust-based conversations with church leaders by offering practical, experience-driven resources
(guides, mockups, visuals) that **reduce risk** and help them confidently plan their next merch run. No
selling upfront - proof, education, and helpful tools.

## Ideal Customer Profile (ICP)

**Targets:**
- Church leaders
- Pastors
- Church administrators
- Creative directors / comms leads
- Ministry operations teams

**Pain points:**
- Merch orders not turning out as expected
- Uncertainty around fabrics, fits, and timelines
- Fear of wasting budget on bad prints
- Difficulty visualising designs before ordering
- Limited time to manage merch details

## Core Messaging Strategy

- Lead with **experience & credibility** (volume of church orders - approved claims only)
- Offer **guides and previews, not pitches**
- Reduce risk with **visual mockups** before ordering
- Ask for feedback → builds trust
- Keep the CTA permission-based and respectful
- Tone: supportive, practical, humble, service-oriented (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables - keep them as-is (`{{FirstName}}`, `{{CompanyName}}`,
`{{SendingAccountFirstName}}`). Pick the angle that fits the target / stage.

### Angle 1 - Lessons-Learned Guide (Feedback First)

```
Hey / Hi / Hello {{FirstName}},

I drafted a short guide based on lessons from thousands of church merch orders.

We're asking a few church leaders to glance at it and let us know if it hits the mark.

Would you like me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 2 - Visual Mockups Before Ordering

```
Hey / Hi / Hello {{FirstName}},

If you share {{CompanyName}}'s logo, we can create a mockup on a shirt or other garment and send over sample images.

That way, you can see exactly how it will look and feel before planning your next run.

Would you like me to set this up for {{CompanyName}}?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 3 - Church Merch Best-Practices Guide

```
Hey / Hi / Hello {{FirstName}},

We've printed thousands of shirts, hoodies, and hats for churches and compiled those lessons into a simple guide.

It covers fabrics, timelines, and practical tips that help church merch turn out right the first time.

Would you like me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 4 - Buyer's Guide (Risk Reduction)

```
Hey / Hi / Hello {{FirstName}},

After printing apparel for churches nationwide, we put together a simple Buyer's Guide.

It's packed with practical tips to help make sure shirts and hoodies turn out exactly as expected - without surprises.

Would you like a copy?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

---

## Key Selling Points (use only real, approved points)

- Thousands of church merch orders completed
- Experience-backed recommendations
- Visual mockups before ordering
- Clear guidance on fabrics and timelines
- Reduces budget waste and surprises
- Designed specifically for churches

## When to Use This Playbook

**Use when:**
- Targeting churches or ministries
- Offering apparel printing or merch services
- Planning seasonal merch runs (events, conferences, youth programs)
- You want trust before transaction

**Avoid when:**
- Targeting fashion brands or retail drops
- One-off novelty merchandise

---

## Adapting for a client (checklist)

- [ ] `{{FirstName}}` / `{{CompanyName}}` / `{{SendingAccountFirstName}}` → confirm these Instantly fields exist and are mapped
- [ ] Volume/experience claims ("thousands of orders", "nationwide") are real and appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] The guide / buyer's guide / mockup capability actually exists and is ready before the hook goes out
- [ ] Keep the opt-out line
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
