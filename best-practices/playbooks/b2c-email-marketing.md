# Playbook: B2C Email Marketing — Free Flow Rebuild (Shopify / eComm Retention)

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client selling email/SMS retention
services to eCommerce brands — led by a **free, concrete deliverable** (rebuilding the highest-leverage
flows) to prove value before pitching. Example built around Shopify Welcome + Abandoned Checkout flows.
**Origin:** Abstracted from a Shopify retention campaign. All brand-specific values are placeholders —
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. The whole angle rests on **actually delivering flows that are better than theirs** — only run this
> if the client can produce strong, customised examples. Never carry one client's specifics into another.

---

## Campaign Goal

Start conversations by offering to **rebuild high-impact flows for free**, proving value upfront before
pitching.

## Ideal Customer Profile (ICP)

**Targets:**
- eCommerce Managers
- Retention / CRM Managers
- Founders (Shopify brands)

**Company type:**
- Shopify stores
- Brands with existing email flows set up
- Consistent traffic but under-optimised retention

**Pain points:**
- Low conversion from Welcome / Abandoned flows
- Leaving revenue on the table from existing traffic
- Flows set up once, never optimised
- Generic templates not performing

## Core Messaging Strategy

- Lead with a **tangible deliverable** (rebuilt flows)
- Focus on **specific assets, not vague improvements**
- Keep it **risk-free and low commitment**
- Highlight Shopify / platform specialisation
- No hard sell — let curiosity do the work
- Tone: confident, practical, low-friction (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables — keep them as-is (`{{firstName}}`, `{{sendingAccountName}}`).
`{{COMPANY}}` = the active client's brand.

### Email 1 — Free Flow Rebuild Offer

```
Hi {{firstName}},

If I rebuilt two of your core Shopify flows (Welcome + Abandoned Checkout) using the same frameworks we use for high-performing Shopify brands — and sent them over — would that be worth a look?

No commitment required. Just want to show you how {{COMPANY}} lifts revenue from your existing traffic.

{{sendingAccountName}}
```

---

## Key Value Points (use only real, approved points)

- Immediate value (they get actual flows, not a pitch)
- Focuses on revenue-driving touchpoints
- Uses proven frameworks (social proof without naming)
- Zero risk → removes hesitation
- Speaks directly to Shopify users

## When to Use This Playbook

**Use when:**
- Targeting Shopify brands specifically
- Selling email/SMS retention services
- You can actually deliver high-quality flow examples
- The prospect likely already has flows (but weak ones)

**Avoid when:**
- Brand has no email setup at all
- You can't produce strong, customised examples
- Targeting non-Shopify eCommerce

## Why This Works

- **Concrete > abstract:** "rebuild 2 flows" is clear and valuable
- **High-leverage assets:** Welcome + Abandoned = biggest revenue drivers
- **Curiosity gap:** "what would they change in my flows?"
- **Effort asymmetry:** you do the work → they just review
- **No-pressure CTA:** "worth a look?" is easy to say yes to

## Execution Tips

- Personalise lightly (mention store/product if possible)
- Make sure your flows are actually better than theirs
- Don't over-explain — keep it tight
- Follow up with preview snippets or a Loom

---

## Adapting for a client (checklist)

- [ ] `{{COMPANY}}` → client brand (from `clients/{slug}/_config.md`)
- [ ] `{{firstName}}` / `{{sendingAccountName}}` → confirm these Instantly fields exist and are mapped
- [ ] The client can actually rebuild strong, customised flows before the offer goes out — the angle collapses otherwise
- [ ] Swap the platform/flows if the client isn't Shopify Welcome + Abandoned Checkout
- [ ] Confirm the offer and any claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
