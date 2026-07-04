# Playbook: Retail / Shelf-Expansion Campaign

**Type:** Shared campaign playbook (client-agnostic). Reusable across any client selling **retail expansion**
to F&B / CPG brands — positioning an AI-driven platform as a faster, cheaper alternative to brokers or a
sales team, especially around seasonal buying windows.
**Origin:** Abstracted from a CPG shelf-expansion campaign. All brand-specific values are placeholders —
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. The numbers below (retailers/week, network size, client count) are illustrative — replace with the
> client's actual, approved figures. Never carry one client's specifics into another.

---

## Campaign Goal

Help F&B / CPG brands get into more retail stores by positioning the client's AI platform as a **faster,
cheaper alternative to brokers or sales teams** — leaning on **seasonal buying urgency** to drive replies.

## Ideal Customer Profile (ICP)

**Targets:**
- F&B / CPG founders
- Brand managers
- Heads of sales / retail partnerships
- Growth roles at emerging CPG brands
- Companies wanting retail expansion but lacking sales reps or broker budgets

**Pain points:**
- Slow retail expansion
- Brokers charging high fees
- Hard to identify the right stores
- Manual outreach taking too much time
- Missing seasonal buying windows

## Core Messaging Strategy

- Position the offer as **speed + cost efficiency** — retail expansion without brokers or a sales team
- Emphasise AI-driven discovery ({{RETAILERS_PER_WEEK}} ideal retailers per week)
- Stress **seasonal urgency** (e.g. holiday stocking window)
- Ask for the right contact — an easy, soft CTA
- Tone: helpful, relevant, consultative (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables — keep them as-is (`{{companyName}}`, `{{accountSignature}}`, and any
custom lead field like `{{Product Type}}`). `{{RETAILERS_PER_WEEK}}` / `{{RETAIL_NETWORK_SIZE}}` /
`{{CLIENT_COUNT}}` = the active client's real, approved figures.

### Email 1 — Initial Outreach

```
Hi / Hey there,

Came across {{companyName}} earlier and wanted to reach out while retailers are planning their holiday {{Product Type}} inventory.

Our team built a platform that helps CPG brands in the F&B space get into more stores — without using brokers or hiring a sales team. It uses AI to match you with {{RETAILERS_PER_WEEK}} ideal retailers per week (from our network of {{RETAIL_NETWORK_SIZE}} stores) and automate all outreach and follow-up messages to those stores.

Thought this could help get your products on more shelves faster and cheaper — and before this holiday restocking window closes.

If this sounds helpful, could you connect me with your founder/CEO/head of sales — or whoever handles retail partnerships?

Thanks,
{{accountSignature}}
```

### Follow Up 1

```
Hi / Hey again,

Retail buyers are making final holiday selections right now — didn't want {{companyName}} to miss this window to get your products on shelves before the holiday rush kicks off.

The brands we work with ({{CLIENT_COUNT}} currently) land new retail partnerships without expensive brokers or sales teams — just automated AI matching and store outreach running in the background.

If retail expansion fits your growth strategy, could you point me to the right person for a quick chat?

But totally understand if timing isn't right — happy to follow up closer to the holidays if that works better.

{{accountSignature}}
```

---

## Key Selling Points (adapt to the client's real, approved figures)

- Get into more stores without brokers
- AI identifies {{RETAILERS_PER_WEEK}} ideal retailers weekly
- Network of {{RETAIL_NETWORK_SIZE}} retail locations
- Fully automated outreach + follow-ups
- Timed to the seasonal restocking window
- Lower cost, faster shelf placement

## When to Use This Playbook

**Use when:**
- Targeting new or fast-growing CPG brands
- Outreach during seasonal buying cycles
- Brands lacking strong wholesale / retail sales teams
- You want discovery calls or to ask for the right internal contact

**Avoid when:**
- Targeting enterprise CPG with entrenched broker networks
- Brands outside F&B / CPG categories

---

## Adapting for a client (checklist)

- [ ] `{{companyName}}` / `{{Product Type}}` / `{{accountSignature}}` → confirm these Instantly lead/account fields exist and are mapped
- [ ] `{{RETAILERS_PER_WEEK}}` / `{{RETAIL_NETWORK_SIZE}}` / `{{CLIENT_COUNT}}` → the client's real, approved figures (`offer.md`)
- [ ] Confirm every claim (network size, match rate, client count) appears in `clients/{slug}/voice.md` → Approved Claims
- [ ] Swap the seasonal hook to the window that actually applies at send time
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
