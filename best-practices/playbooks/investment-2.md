# Playbook: Investment 2 — VC-Education / Credibility-Gap Campaign

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client selling a VC / PE education or
training program to professionals who want to break into investing — led by the **credibility-gap** problem
and outcome proof, offering guides / white papers instead of pitching enrolment.
**Origin:** Abstracted from a VC-education campaign. All brand-specific values are placeholders —
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. Alumni-outcome and deal-participation claims (`{{NOTABLE_DEALS}}`) are **credibility claims that
> must be verified and approved** — never name a company or outcome the client can't substantiate. Have the
> guide / white paper ready before the hook. Never carry one client's specifics into another.

---

## Campaign Goal

Engage professionals interested in venture capital by addressing the **credibility gap** and positioning the
client's program as a path to real-world experience, deal exposure, and outcomes — not just theory.

## Ideal Customer Profile (ICP)

**Targets:**
- Professionals in `{{lcsi}}` (tech, finance, consulting, ops, etc.)
- Aspiring VC / PE investors
- Operators looking to transition into investing
- Angel-curious professionals
- Career switchers interested in venture

**Pain points:**
- Lack of a VC track record
- Studying VC theory without real outcomes
- Difficulty breaking into venture without direct experience
- No access to real deals or top-tier networks
- Need flexibility (can't quit a job to "learn VC")

## Core Messaging Strategy

- Lead with the **credibility problem** (hard to stand out without a track record)
- Emphasise **hands-on experience vs. theory**
- Anchor credibility with **real, approved outcomes** (`{{NOTABLE_DEALS}}`)
- Offer guides / white papers instead of selling the course directly
- Keep CTAs permission-based and low pressure
- Tone: professional, aspirational, outcome-focused (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables — keep them as-is (`{{FirstName}}`, `{{SendingAccountFirstName}}`, and
the custom category field `{{lcsi}}`). `{{COMPANY}}` = the active client's brand; `{{NOTABLE_DEALS}}` =
verified, approved companies/outcomes.

### Email 1 — Credibility Gap Angle

```
Hey / Hi / Hello {{FirstName}},

Many professionals in {{lcsi}} who are interested in venture capital struggle to stand out because they don't yet have a proven track record.

We put together a short guide showing how {{COMPANY}}'s program helps professionals build credibility through hands-on experience.

Would you like me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

P.S. Recent alumni have participated in deals with companies like {{NOTABLE_DEALS}}.

If this isn't relevant, just let me know.
```

### Follow Up 1 — Transition Into VC Angle

```
Hey / Hi / Hello {{FirstName}},

Many professionals in {{lcsi}} want to break into venture capital but often hit credibility barriers without direct experience.

We put together a short guide showing how {{COMPANY}} alumni navigated that transition successfully.

Should I share it with you?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Follow Up 2 — Theory vs. Outcomes Angle

```
Hey / Hi / Hello {{FirstName}},

A lot of people interested in venture capital study the theory but never see real outcomes.

At {{COMPANY}}, alumni gained hands-on experience and participated in deals with companies like {{NOTABLE_DEALS}}. We put together a short white paper explaining how the program drives results like these.

Would you like me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Follow Up 3 — Results & Career Outcomes Angle

```
Hey / Hi / Hello {{FirstName}},

It's one thing to study venture capital theory and another to see it applied in practice.

At {{COMPANY}}, alumni gained real-world experience, joined top firms, and participated in deals with companies like {{NOTABLE_DEALS}}. We prepared a white paper summarizing these outcomes.

Would you like a copy?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Follow Up 4 — Flexibility & Access Angle

```
Hey / Hi / Hello {{FirstName}},

Breaking into venture capital often feels out of reach without flexibility.

{{COMPANY}}'s on-demand program gives professionals a way to access real-world VC and PE training on their own schedule. Alumni have built track records, joined top firms, and participated in deals with companies like {{NOTABLE_DEALS}}.

We summarized these outcomes in a short paper. Would you like me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

---

## Optional Variants (other channels)

**Ultra-short:**
```
Hey {{FirstName}}, we put together a short guide on how professionals build VC credibility without prior deal experience. Want it?
```

**LinkedIn DM:**
```
Hi {{FirstName}}, I shared a short paper on how {{COMPANY}} alumni built real VC track records and joined top firms. Happy to send.
```

**SMS:**
```
{{FirstName}}, quick one — we put together a VC credibility guide based on {{COMPANY}} alumni outcomes. Want a copy?
```

---

## Key Selling Points (use only real, approved points)

- Hands-on VC & PE experience
- Real deal participation (`{{NOTABLE_DEALS}}`)
- Track-record building
- Alumni career outcomes at top firms
- Flexible, on-demand structure
- Built for professionals, not students

## When to Use This Playbook

**Use when:**
- Targeting aspiring investors
- Outreach to operators or professionals exploring VC
- Promoting education programs with strong outcomes
- You want inbound interest before pitching enrolment

**Avoid when:**
- Targeting institutional funds directly
- Pitching traditional finance certifications
- Selling passive investing products

## Why This Works

- Addresses a real psychological barrier (credibility)
- Focuses on outcomes, not education fluff
- Uses proof instead of promises
- Low-pressure CTAs drive replies
- Positions the course as access, not theory

---

## Adapting for a client (checklist)

- [ ] `{{COMPANY}}` → client brand (from `clients/{slug}/_config.md`)
- [ ] `{{NOTABLE_DEALS}}` → only verified, approved companies/outcomes named in `clients/{slug}/voice.md` → Approved Claims
- [ ] `{{FirstName}}` / `{{lcsi}}` / `{{SendingAccountFirstName}}` → confirm these Instantly fields exist and are mapped
- [ ] The guide / white paper actually exists and is ready to send before the hook goes out
- [ ] Every alumni-outcome / deal claim is substantiated — this is credibility territory, no invented names
- [ ] Keep the opt-out line
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
