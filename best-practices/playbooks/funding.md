# Playbook: Funding / Fast-Capital Campaign

**Type:** Shared campaign playbook (client-agnostic). Reusable across any client whose offer is fast,
low-friction access to capital.
**Origin:** Abstracted from a Tiger Capital funding campaign. All brand-specific values are placeholders -
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. The example terms below (24-hour funding, no collateral, approvals in hours) are illustrative -
> replace with the client's actual, approved terms. Never carry one client's specifics into another.

---

## Campaign Goal

Convert SMB owners who need fast access to capital by highlighting **speed, simplicity, and low-friction
approvals**.

## Ideal Customer Profile (ICP)

**Targets:**
- Small & medium business owners
- Founders, CEOs, finance managers
- Companies needing capital for payroll, inventory, expansion
- Businesses frustrated with slow approvals or heavy paperwork

**Pain points:**
- Slow bank approvals
- Too much documentation
- Cash flow gaps
- Uncertain or stressful funding processes
- Needing a fast yes or no

## Core Messaging Strategy

- Lead with **speed** (e.g. approvals in hours, funding in {{FUNDING_SPEED}})
- Remove friction ({{RISK_REVERSAL}} - e.g. no collateral, no hoops)
- Keep tone friendly and conversational (defer to `clients/{slug}/voice.md`)
- CTA stays simple: "Can I send you more details?"
- Use a time-based greeting for a natural opening

---

## Sequence

Merge fields are Instantly spintax - keep them as-is. `{{COMPANY}}` = the active client's brand,
`{{FUNDING_SPEED}}` / `{{RISK_REVERSAL}}` = their approved offer terms.

### Email 1 - Initial Outreach

```
Good Morning / Good Afternoon / Good Evening {{FirstName}} - is it ever a headache getting approved for business funding?

Asking because {{COMPANY}} helps businesses secure capital within {{FUNDING_SPEED}}, {{RISK_REVERSAL}}.

Can I send you more details?

{{RANDOM|Thanks|Thank you|All the best|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}
```

### Follow Up 1

```
Hi / Hey / Hello {{FirstName}},

Most of the clients we work with just want one thing - a fast yes or no, without jumping through hoops.

If you're looking at funding options, we can give you an answer in a few hours and deliver the funds the next day.

Can I send you more details?

{{RANDOM|Thanks|Thank you|All the best|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}
```

### Follow Up 2

```
Good Morning / Good Afternoon / Good Evening {{FirstName}},

{{COMPANY}} was built for speed and flexibility. If your company needs capital for payroll, inventory, or expansion, we can help make that happen by tomorrow.

No collateral. No delay.

Interested in more details?

{{RANDOM|Thanks|Thank you|All the best|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}
```

---

## Key Selling Points (adapt to the client's real terms)

- Funding delivered fast (example: 24 hours)
- Approvals in a few hours
- No collateral required
- Minimal documentation
- Ideal for cash flow gaps
- Great for rapid growth, emergencies, or expansion

## When to Use This Playbook

**Use when:**
- Broad SMB outreach
- Lists with general business owners
- Leads with any hint of a funding need
- You want quick responses and fast funnel movement

**Avoid when:**
- Enterprise-level targets
- High-documentation financial products
- Leads expecting bank-style underwriting

---

## Adapting for a client (checklist)

- [ ] `{{COMPANY}}` → client brand (from `clients/{slug}/_config.md`)
- [ ] `{{FUNDING_SPEED}}` / `{{RISK_REVERSAL}}` → client's real, approved offer terms (`offer.md`)
- [ ] Confirm every claim appears in `clients/{slug}/voice.md` → Approved Claims
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
