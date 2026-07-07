# Playbook: SaaS 3 - Dev-Tools Curiosity Hook (QA Accuracy & Regression Risk)

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client selling a testing / reliability
tool to **QA and test engineers** - led by a specific, curiosity-driven insight ("the 3 test paths where
accuracy drops fastest") and a near-zero-friction CTA. Knowledge first, no selling.
**Origin:** Abstracted from a QA-accuracy campaign. All brand-specific values are placeholders -
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. If you promise a list of high-risk test paths, actually have it - QA buyers value signal and will
> spot a hollow hook instantly. Keep the opt-out line. Never carry one client's specifics into another.

---

## Campaign Goal

Engage QA and testing teams by highlighting **where test accuracy breaks first** when the UI changes,
positioning the client's tool as a way to catch regressions early without expanding manual effort.

## Ideal Customer Profile (ICP)

**Targets:**
- QA Engineers
- Test Leads
- Automation Engineers
- QA Managers

**Company type:**
- SaaS products with frequent UI changes
- Teams maintaining large regression suites
- QA teams under pressure to keep up with releases

**Pain points:**
- Tests silently failing after UI updates
- False confidence from outdated test paths
- High maintenance cost of regression suites
- Missing coverage during rapid iteration

## Core Messaging Strategy

- Lead with a **specific insight** (3 test paths)
- Create **curiosity, not explanation**
- Keep the message extremely short
- Avoid selling - offer knowledge first
- Reinforce relevance with opt-out respect
- Tone: precise, QA-native, efficient (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables - keep them as-is (`{{firstName}}`, `{{SendingAccountFirstName}}`).

### Email 1 - Primary Outreach

```
Hi {{firstName}},

We've put together a short list of the three test paths where accuracy drops fastest when UI changes.

Want it?

{{RANDOM|Thanks|Thank you|Best regards}},
{{SendingAccountFirstName}}

Not relevant? Just let me know.
```

---

## Key Value Points (use only real, approved points)

- Identifies high-risk regression paths
- Focused on real-world UI-change impact
- Saves time maintaining brittle tests
- Helps QA teams prioritise coverage

## When to Use This Playbook

**Use when:**
- Targeting QA or test engineers directly
- Selling testing accuracy or reliability
- Opening conversations without demos

**Avoid when:**
- Targeting product leadership only
- Selling non-testing SaaS tools

## Why This Works

- QA professionals value signal over hype
- Specificity builds credibility
- Low-effort CTA increases replies
- Positions you as helpful before selling

---

## Adapting for a client (checklist)

- [ ] `{{firstName}}` / `{{SendingAccountFirstName}}` → confirm these Instantly fields exist and are mapped
- [ ] The "3 test paths" list (or equivalent insight) actually exists and is ready to send before the hook goes out
- [ ] Confirm the offer and any claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Add follow-up steps if the client wants a sequence (this angle ships as a single high-curiosity email)
- [ ] Keep the opt-out line
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
