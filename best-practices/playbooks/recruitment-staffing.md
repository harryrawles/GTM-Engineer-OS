# Playbook: Recruitment / Staffing - MPC (Most Placeable Candidate) Outreach

**Type:** Shared campaign playbook (client-agnostic). Reusable for any recruitment / staffing client
generating job orders proactively - led by an **exclusive, specific candidate offer** (a heads-up, not a
pitch) built on real quantified results and genuine scarcity.
**Origin:** Abstracted from an MPC candidate-marketing campaign. All brand-specific values are placeholders -
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. The credibility of this whole campaign rests on **discipline**: only market a candidate who
> genuinely passes the MPC filter, only claim exclusivity you actually have, and only use scarcity lines when
> factually true. Never carry one client's specifics (or a real candidate's details) into another client's
> campaign. Never expose an identifiable candidate's private data - keep the profile anonymised until the
> hiring manager opts in.

---

## Campaign Goal

Start conversations with hiring managers by offering **exclusive early access to a specific, high-performing
candidate** already in the market - a heads-up, not a pitch. Trigger curiosity and urgency around a real,
scarce opportunity. This does not sell a recruitment service; it markets one candidate.

## Ideal Customer Profile (ICP)

**Targets:**
- Hiring managers, department heads, founders/CEOs at companies with active or likely hiring needs
- Companies in the same industry/location as the candidate being marketed
- Businesses growing fast enough that talent gaps are a live problem

**Behaviour signals:**
- Recent headcount growth, funding, or expansion news
- Active job ads or recent LinkedIn hiring posts
- Repeat use of contingency/retained recruiters
- Industry with known scarcity for the candidate's specialism

**Pain points:**
- Can't find talent fast enough through job boards alone
- No visibility into who's quietly on the market before competitors see them
- Wasted time screening unqualified inbound applicants
- Fear of losing a strong hire to a competitor who moved first

## Core Messaging Strategy

- Lead with the **exclusive candidate offer, not the agency**
- Position the candidate as a **scarce, quantified asset** - not a generic profile
- Focus on **speed and exclusivity** (they're off-market soon)
- Keep the message extremely short and non-salesy
- Use a **binary relevance question** (yes/no)
- Tone: direct, low-friction, urgent but not pushy (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields and spintax are Instantly syntax - keep them as-is (`{{firstName}}`, `{{congrats}}`,
`{{roleTitle}}`, `{{resultMetric}}`, `{{yearsExperience}}`, `{{specialism}}`, `{{industry}}`, `{{location}}`,
`{{accountSignature}}`, `{{random|...}}`).

### Email 1 - Variant 1

```
Subject: Can I send it {{firstName}}?

Hi {{firstName}},

{{congrats}}

{{random|I'm exclusively representing|I'm currently working with|I have}} a {{roleTitle}} {{random|consistently hitting|averaging|delivering}} {{resultMetric}}, with {{yearsExperience}}+ years of {{specialism}} experience.

{{random|They're looking for|Currently exploring}} a new role in the {{industry}} industry in {{location}}.

{{random|Can I send over their full profile?|Would it be worth seeing their CV?|Worth a look?}}

{{random|All the best|Best|Thanks}},
{{accountSignature}}
```

### Email 1 - Variant 2

```
Subject: {{firstName}} - this will take 10 seconds

{{random|Hi|Hey|Hello}} {{firstName}},

{{random|Quick one|Short note|Straight to it}} - {{random|I'm exclusively representing|I'm working with}} a {{roleTitle}} {{random|hitting|averaging|delivering}} {{resultMetric}} across {{specialism}}.

{{random|They're open to conversations this week only|Two other firms are already reviewing their profile|Notice period is short, so timing matters}}.

{{random|Worth seeing their profile?|Should I send it over?}}

{{random|Best|Regards|Thanks}},
{{accountSignature}}
```

**Suggested 4-touch structure when scaling:** intro → update → yes/no → contact-check. Rotate the sequence
structure across MPCs rather than reusing the same candidate story repeatedly.

---

## Key Value Points (use only real, approved points)

- Exclusive-candidate framing removes the "just another recruiter email" resistance
- A real, quantified result is instantly credible and tangible to a hiring manager
- Short email structure increases reply probability
- Binary relevance question reduces friction and forces a decision
- Real (not fabricated) scarcity is the single biggest driver of reply speed
- Industry/location specificity beats generic outreach

## When to Use This Playbook

**Use when:**
- You have a candidate who passes the MPC filter: quantifiable results, real urgency, genuine scarcity, reference-able
- Targeting companies with visible growth or hiring signals
- You want fast qualification replies, not long nurture
- You're generating job orders proactively, before a role is advertised

**Avoid when:**
- The candidate is generic or unremarkable - no real MPC exists to market
- The "urgency" would have to be invented rather than genuine
- Targeting companies with no plausible need for that specialism
- Generic industry targeting without a real reason the candidate fits

## Why This Works

- **Exclusive-access framing** lowers the guard - it's a heads-up, not a sales pitch
- **A specific number** is instantly more credible than a job description
- **Real scarcity** ("two other firms reviewing") triggers loss aversion, not skepticism
- **Minimal cognitive load** - one candidate, one ask, one decision
- **Binary relevance question** forces engagement instead of a "later" default
- **Ultra-short format** stands out against long, templated recruiter spam

## Execution Tips (important)

- Keep "exclusive representation" genuine - never claim exclusivity you don't have
- Only use scarcity lines ("other firms reviewing") when factually true
- Run every candidate through the MPC filter before writing copy - discipline keeps the campaign credible
- "Industry/location" targeting should be real segmentation, not filler
- First-reply goal is simply "yes, send it" - don't over-explain or oversell the candidate upfront
- If scaling across multiple MPCs, rotate the 4-touch structure rather than reusing one story

---

## Adapting for a client (checklist)

- [ ] The candidate genuinely passes the MPC filter (quantified results, real urgency, genuine scarcity, reference-able)
- [ ] `{{roleTitle}}` / `{{resultMetric}}` / `{{yearsExperience}}` / `{{specialism}}` / `{{industry}}` / `{{location}}` → real, verified candidate data; candidate stays anonymised until the hiring manager opts in
- [ ] `{{firstName}}` / `{{congrats}}` / `{{accountSignature}}` → confirm these Instantly fields exist and are mapped
- [ ] Exclusivity and scarcity claims are factually true
- [ ] Industry/location segmentation is real, not filler
- [ ] Confirm claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
