# Playbook: Marketing / Competitor-Insights Campaign

**Type:** Shared campaign playbook (client-agnostic). Reusable across any client selling marketing services,
demand gen, or growth consulting to B2B teams — leading with **competitor intelligence** as a curiosity hook.
**Origin:** Abstracted from a competitor-insights marketing campaign. All brand-specific values are
placeholders — fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. If you promise competitor tactics, you must actually have them — never offer research you can't
> deliver. Never carry one client's specifics into another.

---

## Campaign Goal

Spark curiosity by offering **competitor intelligence and actionable tactics** B2B teams can implement
immediately. Works because it feels helpful, relevant, and personalised — not salesy.

## Ideal Customer Profile (ICP)

**Targets:**
- B2B founders
- CMOs / Heads of Marketing
- Growth leads
- Demand gen teams
- Agencies working with B2B clients

**Pain points:**
- Difficulty staying ahead of competitors
- Not knowing what's working in their niche
- Flat or declining pipeline
- Needing fast, actionable tactics
- Market shifts they're not keeping up with

## Core Messaging Strategy

- Lead with **competitive insight** — frame the sender as someone who already did the work
- Drive **curiosity** ("found tactics they're using that you're not")
- Keep it short and value-forward
- CTA is lightweight ("Should I send them your way?")
- Personalise on the prospect's industry category (`{{lcsi}}`)
- Tone: no-hype, insight-driven (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables — keep them as-is (`{{firstName}}`, `{{companyName}}`,
`{{sendingAccountFirstName}}`, and the custom industry field `{{lcsi}}`).

### Email 1 — Initial Outreach

```
Hi / Hey {{firstName}},

I analysed top B2B competitors in {{lcsi}} and found three tactics they use that {{companyName}} hasn't tapped into. Should I send them your way?

{{RANDOM|Thanks|Many thanks|Best regards}},
{{sendingAccountFirstName}}
```

---

## Key Selling Points

- Shows you've already done the research
- Extremely short + easy to reply to
- Offers immediate value (a competitor edge)
- No-hype, purely insight-driven
- Works across any B2B sector

## When to Use This Playbook

**Use when:**
- Reaching out to B2B companies
- Pitching marketing services, demand gen, or growth consulting
- Targeting founders or marketing decision-makers
- You want high quick-reply rates and curiosity-driven opens

**Avoid when:**
- Companies too small to have a marketing owner
- Consumer brands where B2B competitor analysis doesn't apply

---

## Adapting for a client (checklist)

- [ ] `{{firstName}}` / `{{companyName}}` / `{{lcsi}}` / `{{sendingAccountFirstName}}` → confirm these Instantly lead/account fields exist and are mapped
- [ ] You can actually deliver the promised competitor tactics before sending the ask — no research you can't back up
- [ ] Confirm the offer and any claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Add a follow-up step if the client wants a 2–3 email sequence (this angle ships as a single high-curiosity email)
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
