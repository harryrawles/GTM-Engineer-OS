# Playbook: Gaming — Gamified Classroom / Teacher Outreach

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client offering a gamified /
engagement product to teachers — led by a **low-friction free pilot** and role relevance, kept simple and
non-technical. Example built around a classroom behaviour/engagement tool.
**Origin:** Abstracted from a teacher-outreach campaign. All brand-specific values are placeholders —
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. The email below is an **illustrative starter draft** built from the strategy (the source provided
> no copy) — rewrite it in the client's voice. Keep it simple; teachers skim. Never carry one client's
> specifics into another.

---

## Campaign Goal

Get teachers to try a **low-friction pilot** by positioning the product as a simple way to improve student
engagement and behaviour.

## Ideal Customer Profile (ICP)

**Targets:**
- Elementary school teachers
- Classroom teachers (K–5 focus)
- Special education teachers
- Teaching assistants (secondary)

**Environment:**
- Public or private schools
- Teachers managing full classrooms daily
- Limited time, high workload

**Pain points:**
- Keeping students engaged consistently
- Managing behaviour without constant intervention
- Motivating participation without extra workload
- Burnout from repetitive classroom management

## Core Messaging Strategy

- Lead with **relevance** ("I saw you teach…")
- Keep language **simple and non-technical**
- Position as a **helpful classroom tool, not software**
- Emphasise **free / pilot / early access**
- Keep the ask very low commitment
- Tone: friendly, respectful of time, practical (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables — keep them as-is (`{{firstName}}`, `{{sendingAccountName}}`).
`{{COMPANY}}` = the active client's brand; `{{GradeOrSubject}}` = a personalisation field if available.

### Email 1 — Free Pilot Offer (illustrative starter draft — rewrite in client voice)

```
Hi {{firstName}},

Saw you teach {{GradeOrSubject}} — I built a simple tool that turns everyday behaviour and progress into little rewards kids actually get excited about, without adding to your plate.

It's free to try while we're in early access.

Open to taking a look?

{{sendingAccountName}}
```

---

## Key Value Points (use only real, approved points)

- Turns behaviour + progress into motivating rewards
- Helps with classroom management without extra effort
- Students stay more engaged and focused
- Easy to try (beta / pilot, no cost)
- Designed specifically for younger learners

## When to Use This Playbook

**Use when:**
- Targeting teachers directly (not administrators)
- Offering an early-stage product or pilot
- The product is simple and easy to explain
- You need early adopters / feedback

**Avoid when:**
- Selling to school leadership (needs a different angle)
- The product requires onboarding/training upfront
- Messaging becomes too "edtech-heavy"

## Why This Works

- **Immediate relevance:** calls out their role directly
- **Low resistance:** free pilot removes risk
- **Clear benefit:** better behaviour + engagement
- **Short + digestible:** fits into a teacher's busy day
- **Soft CTA:** "open to taking a look?" feels easy

## Execution Tips

- Keep everything extremely simple (teachers skim fast)
- Avoid buzzwords like "AI", "platform", "solution"
- If possible, mention grade level or subject
- Follow up with a quick demo or visual example
- Don't over-randomise — keep it natural

---

## Adapting for a client (checklist)

- [ ] `{{COMPANY}}` → client brand (from `clients/{slug}/_config.md`)
- [ ] `{{firstName}}` / `{{sendingAccountName}}` / `{{GradeOrSubject}}` → confirm these Instantly fields exist and are mapped
- [ ] Rewrite the illustrative email in the client's real voice — the source provided no copy
- [ ] Strip edtech buzzwords; keep it plain and teacher-friendly
- [ ] Confirm the offer and any claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
