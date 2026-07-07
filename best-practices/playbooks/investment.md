# Playbook: Investment / Raise Campaign

**Type:** Shared campaign playbook (client-agnostic). Reusable across any client raising capital who can lead
with **credibility and social proof** (notable backers, a marquee recent investment, proprietary tech).
**Origin:** Abstracted from an early-stage fundraising campaign. All brand-specific values are placeholders -
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. Investor-facing claims (backers, investment amounts, traction) are **regulated territory** - never
> state a backer, figure, or raise detail that is not verified and approved in the client's files. Never carry
> one client's specifics into another.

---

## Campaign Goal

Attract conviction-led investors to a high-credibility raise by leading with **social proof, scarcity, and a
tight, discreet, low-friction ask** (intro / deck share / private overview).

## Ideal Investor Profile (IIP)

**Targets:**
- Angel investors
- Early-stage VCs
- Family offices
- Operators at top tech / relevant-sector companies
- Thesis-aligned investors ({{SECTOR}})

**What they care about:**
- Market credibility
- Traction signals
- Notable co-investors / backers
- Proprietary tech + defensibility
- Access to the deal before it closes

## Core Messaging Strategy

- Lead with **social proof** ({{NOTABLE_BACKERS}} - only verified, approved names)
- Position the remaining allocation as **scarce and final**
- Keep communication **tight, discreet, and investor-friendly**
- CTA stays low friction: intro, deck share, or private overview
- Tone: high-signal, minimal fluff (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly spintax - keep them as-is. `{{COMPANY}}` = the active client's brand,
`{{NOTABLE_BACKERS}}` / `{{ANCHOR_INVESTMENT}}` / `{{SECTOR}}` / `{{TECH_DESCRIPTION}}` = their verified,
approved raise details.

### Email 1 - Initial Outreach

```
Hi {{FirstName}},

We're introducing conviction-led investors to {{COMPANY}} - a {{SECTOR}} company backed by {{NOTABLE_BACKERS}}. Limited pre-seed allocation left. {{ANCHOR_INVESTMENT}}.

Interested in a quick intro or deck share?

{{RANDOM|Best|Thanks|Talk soon}},
{{SendingAccountFirstName}}
```

### Follow Up 1

```
Hi {{FirstName}},

Quick context - {{COMPANY}} is building {{TECH_DESCRIPTION}}. Backed by {{NOTABLE_BACKERS}}. {{ANCHOR_INVESTMENT}}.

Would you like a private overview?

{{RANDOM|Best|Thanks|Talk soon}},
{{SendingAccountFirstName}}
```

---

## Key Selling Points for Investors (use only verified, approved points)

- Backed by notable, named investors ({{NOTABLE_BACKERS}})
- A marquee recent investment as an anchor ({{ANCHOR_INVESTMENT}})
- Proprietary, defensible technology
- Large, credible market / TAM
- Early access before the allocation closes
- High-calibre founding team

## When to Use This Playbook

**Use when:**
- Targeting early-stage investor lists
- Sending to operators + angel networks
- You need a credibility-first hook (team + backers over hard traction)
- The goal is intros, deck opens, and warm replies

**Avoid when:**
- Approaching growth-stage funds (they lead on traction, not team/backers)
- Investors who require traction over team
- Non-tech / off-thesis sectors

---

## Adapting for a client (checklist)

- [ ] `{{COMPANY}}` → client brand (from `clients/{slug}/_config.md`)
- [ ] `{{SECTOR}}` / `{{TECH_DESCRIPTION}}` → client's real category and one-line tech description (`offer.md`)
- [ ] `{{NOTABLE_BACKERS}}` → only backers verified and approved in `clients/{slug}/voice.md` → Approved Claims
- [ ] `{{ANCHOR_INVESTMENT}}` → only a real, approved, verifiable investment/figure - no invented amounts
- [ ] Confirm every investor-facing claim (backers, figures, raise stage) is approved - this is regulated territory
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
