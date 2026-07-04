# Playbook: Franchising — Decision Clarity for Experienced Buyers

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client offering **buyer-side franchise
guidance** to experienced professionals exploring ownership — led by clarity and disciplined decision-making,
not selling franchises. Resources (guides, quizzes, frameworks) over pitches.
**Origin:** Abstracted from a franchise decision-clarity campaign. All brand-specific values are placeholders
— fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. Keep the framing buyer-side and pressure-free — this angle breaks the moment it feels like a
> single-brand franchise pitch. Have the guide / quiz / framework ready before the hook. Keep the opt-out
> line. Never carry one client's specifics into another.

---

## Campaign Goal

Start thoughtful, trust-based conversations with experienced professionals exploring franchise ownership by
helping them cut through noise, ads, and biased rankings to make clear, disciplined ownership decisions.
This is about **clarity before commitment**, not selling franchises.

## Ideal Customer Profile (ICP)

**Targets:**
- Sales leaders
- Senior professionals in `{{lcsi}}`
- Operators considering ownership
- High-earning W-2 professionals
- Professionals exploring post-corporate paths

**Pain points:**
- Overwhelmed by franchise portals and rankings
- Conflicting "top franchise" lists
- Fear of choosing the wrong model
- Lifestyle mismatch (hours, stress, travel)
- Analysis paralysis from too many options

## Core Messaging Strategy

- Acknowledge **decision complexity, not lack of ambition**
- Position resources as **buyer-side guidance, not promotions**
- Emphasise **fit over hype** (financial + lifestyle alignment)
- Use **tools** (guides, quizzes, frameworks) instead of pitches
- Keep the CTA permission-based and pressure-free
- Tone: calm, intelligent, peer-to-peer (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables — keep them as-is (`{{FirstName}}`, `{{City}}`,
`{{SendingAccountFirstName}}`, and the custom category field `{{lcsi}}`). Pick the angle that fits the target.

### Angle 1 — Avoiding Biased Franchise Lists

```
Hey / Hi / Hello {{FirstName}},

I've seen a lot of professionals in the {{lcsi}} space explore ownership but run into conflicting lists and heavily marketed franchise content.

I put together a short resource explaining how experienced buyers assess franchises without relying on ads, rankings, or portals.

Want me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 2 — Local Opportunity + Risk Awareness

```
Hey / Hi / Hello {{FirstName}},

I've been looking at franchise activity in {{City}}, and there's real opportunity opening up for experienced sales leaders.

The biggest risk I see is choosing a franchise that doesn't align with finances or lifestyle. I built a short guide that helps avoid that upfront.

Would you like me to send it your way?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 3 — Decision Quiz (Speed + Focus)

```
Hey / Hi / Hello {{FirstName}},

Sales leaders usually have options — which actually makes franchising harder, not easier.

I created a short quiz that helps narrow down which franchise types fit your goals, instead of spending months researching everything.

Want me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 4 — Disciplined Buyer Framework

```
Hey / Hi / Hello {{FirstName}},

Most sales leaders don't struggle with ambition — they struggle with decision clarity.

I created a short framework showing how disciplined buyers evaluate franchise opportunities without rushing or over-researching.

Would you like to take a look?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

---

## Key Value Points

- Buyer-side perspective (not franchise sales)
- Filters out hype and paid rankings
- Aligns franchise choice with lifestyle + finances
- Reduces analysis paralysis
- Helps experienced professionals move forward confidently

## When to Use This Playbook

**Use when:**
- Targeting high-caliber professionals
- Outreach to sales leaders or operators
- Early-stage franchise exploration
- You want engagement before introductions

**Avoid when:**
- Targeting first-time entrepreneurs with no capital
- Selling a single franchise brand directly
- Short-cycle transactional outreach

---

## Adapting for a client (checklist)

- [ ] `{{FirstName}}` / `{{City}}` / `{{lcsi}}` / `{{SendingAccountFirstName}}` → confirm these Instantly fields exist and are mapped
- [ ] The guide / quiz / framework actually exists and is ready to send before the hook goes out
- [ ] Keep the framing buyer-side and pressure-free — never let it read as a single-brand pitch
- [ ] Confirm the offer and any claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Keep the opt-out line
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
