# Playbook: Med Spas — Wellness & Peptide Program Expansion

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client selling wellness / peptide
program support to med spas and wellness clinics — led by **education and industry-trend awareness**, with a
strong focus on patient trust, sourcing transparency, and program design. Not a hard sell.
**Origin:** Abstracted from a med-spa wellness campaign. All brand-specific values are placeholders —
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. **This is a medical / health vertical — peptide, sourcing, and outcome claims are regulated.**
> Only make claims the client can substantiate and has approved; keep language educational and supportive,
> never prescriptive or promissory. Have the guide ready before the hook. Never carry one client's specifics
> into another.

---

## Campaign Goal

Start value-first conversations with med spas and wellness clinics by **educating** them on how wellness,
recovery, and longevity peptides are being added alongside aesthetics — anchored in patient trust, sourcing
transparency, and program design.

## Ideal Customer Profile (ICP)

**Targets:**
- Med spa owners
- Medical directors
- Clinic managers
- Wellness & longevity clinic operators
- Aesthetic practices expanding into metabolic / recovery programs

**Pain points:**
- Plateauing revenue from aesthetics alone
- Uncertainty around which peptides to introduce first
- Patient trust concerns around sourcing & quality
- Poor adoption or retention in metabolic programs
- Lack of clear patient education frameworks

## Core Messaging Strategy

- Lead with **industry-trend awareness** (other clinics expanding programs)
- Focus on **education, not selling**
- Emphasise **transparent sourcing and patient trust**
- Position peptides as **supportive, not aggressive**
- Keep CTAs permission-based and low pressure
- Tone: clinical, calm, informative, professional (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables — keep them as-is (`{{FirstName}}`, `{{CompanyName}}`, `{{City}}`,
`{{State}}`, `{{SendingAccountFirstName}}`). Pick the angle that fits the target segment / geo.

### Angle 1 — Wellness Expansion Beyond Aesthetics

```
Hey / Hi / Hello {{FirstName}},

Many med spas are adding wellness peptides to expand beyond aesthetics.

I put together a short guide showing which peptides clinics use most and how transparent sourcing helps build patient trust.

Would you like me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 2 — Local Market Context

```
Hey / Hi / Hello {{FirstName}},

I wanted to ask if {{CompanyName}} is currently considering wellness peptides this year.

I created a simple guide showing what nearby med spas in {{City}}, {{State}} are rolling out and how they introduce these programs to patients.

Would you like me to share it?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 3 — Longevity & Recovery Add-Ons

```
Hey / Hi / Hello {{FirstName}},

I put together a short guide on how med spas like {{CompanyName}} add recovery and longevity peptides alongside aesthetics — and how they communicate quality and sourcing to patients.

Would you like me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 4 — Metabolic Program Support

```
Hey / Hi / Hello {{FirstName}},

Many clinics are adding supportive peptides around their metabolic programs to help with comfort, recovery, and early-stage adherence.

I put together a short guide showing how clinics structure these add-ons and explain sourcing to patients.

Interested in taking a look?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 5 — Retention & Adherence Focus

```
Hey / Hi / Hello {{FirstName}},

Clinics in {{City}} are expanding their metabolic programs with supportive peptides to improve comfort and patient retention.

I created a short guide showing which peptides they introduce first and how they discuss sourcing with patients.

Would you like me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 6 — Patient Experience & Expectations

```
Hey / Hi / Hello {{FirstName}},

Many clinics are redesigning treatment programs to focus on comfort and early-stage adherence — not just numbers on a chart.

I created a short guide on how clinics layer in supportive peptides and set clear expectations with patients.

Would you like to see it?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

---

## Key Selling Points (use only real, approved points)

- Wellness expansion beyond aesthetics
- Supportive peptides (recovery, comfort, longevity)
- Improved patient trust through transparent sourcing
- Better adherence and retention
- Education-first patient communication
- Low-risk program layering

## When to Use This Playbook

**Use when:**
- Targeting med spas, aesthetic practices, or wellness/longevity clinics
- Selling peptide program support, sourcing, or program-design services
- You want education-led replies without booking pressure
- Outreach to owners, medical directors, or clinic managers

**Avoid when:**
- Targeting audiences outside licensed clinical settings
- Any context where the client can't substantiate sourcing/quality claims

---

## Adapting for a client (checklist)

- [ ] `{{FirstName}}` / `{{CompanyName}}` / `{{City}}` / `{{State}}` / `{{SendingAccountFirstName}}` → confirm these Instantly fields exist and are mapped
- [ ] Every peptide, sourcing, and outcome claim is substantiated and appears in `clients/{slug}/voice.md` → Approved Claims (regulated / medical territory)
- [ ] The guide actually exists and is ready to send before the hook goes out
- [ ] Language stays educational and supportive — never prescriptive or promissory
- [ ] Keep the opt-out line
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
