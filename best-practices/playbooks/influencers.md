# Playbook: Influencer-Marketing / Curated-Creator-List Campaign

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client selling influencer-marketing
tools or services to SaaS / SI founders and marketing leaders — led by a **hand-curated creator list**
offered as value-first, with no upfront pitch.
**Origin:** Abstracted from an influencer-partnerships campaign. All brand-specific values are placeholders —
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. If you promise a hand-curated list, actually build it — the whole angle rests on real, personal
> effort. Keep the opt-out line. Never carry one client's specifics into another.

---

## Campaign Goal

Start conversations with SaaS / SI founders and marketing leaders by offering **hand-curated influencer
partner lists** aligned to their brand, audience, and growth goals — without pitching upfront.

## Ideal Customer Profile (ICP)

**Targets:**
- SaaS founders
- SI (Systems Integrator) founders
- Heads of Marketing / Growth
- Brand managers
- Early to mid-stage SaaS companies

**Needs / pain points:**
- Don't know which creators actually convert
- Wasting time on irrelevant influencer outreach
- Poor audience alignment with creators
- No internal process for sourcing influencers
- Want partnerships without heavy tooling or agencies

## Core Messaging Strategy

- Lead with **personal effort** (reviewed the site, handpicked creators)
- Offer **value first** (a free curated list)
- Keep the CTA extremely low-friction ("Can I send the list?")
- Use respectful opt-out language to build trust
- Tone: helpful, personalised, non-salesy (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables — keep them as-is (`{{FirstName}}`, `{{CompanyName}}`,
`{{SendingAccountFirstName}}`, and the custom category field `{{SI}}`).

### Email 1 — Curated List Hook

```
Hey / Hi / Hello {{FirstName}},

I've been helping founders in the {{SI}} space find relevant influencer partnerships. I spent some time on your website and handpicked a list of creators I think would be a great match for your brand vision.

Would you like me to send the list over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this list isn't relevant, just let me know.
```

### Follow Up 1 — Alignment & Relevance

```
Hey / Hi / Hello {{FirstName}},

I just curated a list of creators that align closely with {{CompanyName}}'s brand and audience. They're a strong fit for partnerships based on content style and audience overlap.

Would a list like this be relevant for {{CompanyName}}?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

Not the right fit? Just reply "no thanks" and I'll make sure you're not contacted again.
```

### Follow Up 2 — Founder-Focused

```
Hey / Hi / Hello {{FirstName}},

I've been helping founders at {{SI}} brands find relevant influencer partnerships. I spent some time on your site and handpicked a list of creators I think would be a great match for your brand.

Can I send the list over for your thoughts?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

Not the right fit? Just reply "no thanks" and I'll make sure you're not contacted again.
```

### Follow Up 3 — List + Education Angle

```
Hey / Hi / Hello {{FirstName}},

I just curated a list of creators that align closely with {{CompanyName}}'s brand and audience. They're a strong match for partnerships based on content and audience alignment.

Would it be helpful if I also shared a short video showing how you can pull a creator list like this in under 5 minutes?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

Not the right fit? Just reply "no thanks" and I'll make sure you're not contacted again.
```

---

## Optional Variants (other channels)

**Ultra-short:**
```
Hey {{FirstName}}, I reviewed your site and handpicked a few creators that align with {{CompanyName}}. Want the list?
```

**LinkedIn DM:**
```
Hi {{FirstName}}, quick one — I curated a list of creators that match {{CompanyName}}'s brand and audience. Happy to send if helpful.
```

**SMS:**
```
{{FirstName}}, I handpicked creators that align with {{CompanyName}}. Want the list?
```

---

## Key Selling Points

- Hand-curated creator lists (not scraped)
- Brand + audience alignment first
- Saves founders time
- No upfront pitch
- Works for SaaS and SI brands
- Easy opt-in / opt-out

## When to Use This Playbook

**Use when:**
- Targeting SaaS or SI companies
- Reaching founders or marketing leaders
- Offering influencer-marketing tools or services
- You want high reply rates without selling immediately

**Avoid when:**
- Targeting enterprise brands with influencer agencies
- Selling performance ads or non-creator services

## Why This Works

- Feels personal and effort-driven
- Value comes before any pitch
- Respects founders' time
- Clear permission-based CTA
- Builds trust immediately

---

## Adapting for a client (checklist)

- [ ] `{{FirstName}}` / `{{CompanyName}}` / `{{SI}}` / `{{SendingAccountFirstName}}` → confirm these Instantly lead/account fields exist and are mapped
- [ ] You can actually deliver a real, hand-curated list before sending the hook — the angle collapses if the list is scraped or fake
- [ ] Confirm the offer and any claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Keep the opt-out line — it's core to the trust-first tone
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
