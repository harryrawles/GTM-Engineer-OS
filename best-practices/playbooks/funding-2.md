# Playbook: Funding 2 — Personalized Growth Ideas → Funding

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client selling funding / capital /
growth enablement — led by **AI-personalised growth ideas first**, then a soft transition into funding as
the way to execute them. Value-first, not a capital pitch.
**Origin:** Abstracted from a funding-outreach campaign. All brand-specific values are placeholders —
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. The entire angle depends on the AI-generated ideas being **real, specific, and non-fluffy** — if
> personalisation is weak, don't run this (use the direct funding angle in `funding.md`). Keep the opt-out
> line. Never carry one client's specifics into another. Distinct from `funding.md` (speed / fast-capital).

---

## Campaign Goal

Start conversations with business owners by offering **personalised growth ideas first**, then naturally
introducing funding as the way to execute them.

## Ideal Customer Profile (ICP)

**Targets:**
- Founders
- CEOs
- Owners
- Growth / Ops leaders

**Company type:**
- SMBs and mid-market companies
- Businesses actively trying to grow or scale
- Companies where capital can unlock growth (marketing, hiring, expansion)

**Pain points:**
- Limited cash flow slowing down growth
- Missed opportunities due to lack of capital
- Unsure which growth levers to prioritise
- Generic outreach fatigue

## Core Messaging Strategy

- Lead with **personalised value** (AI-generated ideas)
- Make it about **their business, not your service**
- **Soft transition** into funding (not pushy)
- Keep it relevant and conversational
- Use dynamic scheduling to reduce friction
- Tone: helpful, personalised, low-pressure (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables — keep them as-is (`{{firstName}}`, `{{companyName}}`,
`{{sendingAccountName}}`, the AI field `{{AiIdeasNew1}}`, and enrichment inputs `{{property_1}}` /
`{{property_2}}`). `{{COMPANY}}` = the active client's brand. `[dynamic days]` = a dynamic scheduling
insert.

### Email 1 — Primary Outreach

```
Hi {{firstName}} -

I took a look at {{companyName}} and came up with a few ideas that could fuel your growth:

{{AiIdeasNew1}}

If you're already exploring funding options (or considering it), we help businesses like yours make those ideas happen.

Do you have time for a quick chat on [dynamic days] so I can share what we're seeing work?

{{sendingAccountName}}
{{COMPANY}}

If you don't want to hear from me, just let me know.
```

---

## Idea-Generation Prompt (for `{{AiIdeasNew1}}`)

Adapt the offer line to the client, but keep the constraints (word cap, 7th-grade language, location use,
no spam words, no bold, dash-prefixed rows):

```
We are offering funding for businesses. We specialize in helping businesses and established companies secure the capital they need to thrive and expand.

Create three concise funding ideas (60 words max total output) tailored to the provided company description. Use direct, simple, 7th-grade level language. In one of the ideas, use the location of the business. Identify a key purpose for the capital they can get through us or what they can use the capital for, highlight unique benefits, and craft actionable strategies but do not get into specifics. Ensure the tone is professional, conversational, aligned with the company's mission and offerings. Do not use any bolded letters. Start each idea with a new row with "-" at the start. Do not use any spam words.

The input of the company website description is: {{property_1}}
The input of the company location is: {{property_2}}
```

---

## Key Value Points

- Personalised insights → shows effort, not spam
- Immediate value before asking for anything
- Connects ideas → execution → funding
- Low-friction CTA with suggested days
- Soft opt-out builds trust

## When to Use This Playbook

**Use when:**
- You can generate relevant, specific ideas per prospect
- Targeting business owners or operators
- Selling funding, capital, or growth enablement
- The prospect may not be actively looking for funding yet

**Avoid when:**
- You don't have real personalisation (ideas feel generic)
- Highly technical / niche audiences expecting deep expertise
- Prospects already deep in funding conversations (use the direct pitch in `funding.md`)

## Why This Works

- **Pattern interrupt:** most funding emails go straight to "we offer capital" — this doesn't
- **Ego relevance:** people pay attention when it's about their business
- **Value-first:** reduces resistance and builds goodwill
- **Bridges problem → solution naturally:** "here are growth ideas" → "you may need capital to execute"
- **Dynamic CTA increases replies:** suggesting days removes thinking effort
- **Soft positioning:** doesn't assume they need funding, just opens the door

## Execution Tips (important)

- Your `{{AiIdeasNew1}}` must feel real — specific, actionable, not fluffy
- Keep ideas to 1–3 bullets max
- Tie ideas loosely to growth levers that funding can unlock
- Don't oversell funding — keep it secondary
- Test with and without the funding line for comparison

---

## Adapting for a client (checklist)

- [ ] `{{COMPANY}}` → client brand (from `clients/{slug}/_config.md`)
- [ ] `{{firstName}}` / `{{companyName}}` / `{{sendingAccountName}}` / `{{AiIdeasNew1}}` / `{{property_1}}` / `{{property_2}}` → confirm these Instantly/enrichment fields exist and are mapped
- [ ] The AI idea-generation is set up and producing real, specific output before launch — if it's generic, don't run this playbook
- [ ] `[dynamic days]` dynamic scheduling insert is configured
- [ ] Confirm the offer and any claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Keep the opt-out line
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
