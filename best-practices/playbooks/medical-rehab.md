# Playbook: Medical / Rehab - Ministry Outreach (Addiction Recovery & Family Restoration)

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client partnering recovery / rehab
programs with churches - led by **pastoral support and equipping**, not selling treatment. Offers biblically
grounded, clinically informed ministry resources so church leaders can respond to addiction in their
congregation.
**Origin:** Abstracted from an addiction-recovery ministry campaign. All brand-specific values are
placeholders - fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. **This is a sensitive, health-adjacent vertical.** Clinical and outcome claims ("shown to improve
> outcomes") must be substantiated and approved - never imply guaranteed results. Keep the tone pastoral,
> compassionate, and non-pressuring; equip, don't pitch. Have the ministry guide ready before the hook. Keep
> the opt-out line. Never carry one client's specifics into another.

---

## Campaign Goal

Support church leaders by offering **biblically grounded, clinically informed ministry resources** that help
them respond to addiction within their congregation - without positioning the outreach as sales-driven or
institutional. This is about equipping pastors, not pitching rehab.

## Ideal Customer Profile (ICP)

**Targets:**
- Pastors
- Church elders
- Ministry leaders
- Care / counselling ministry heads
- Family ministry leaders

**Pain points:**
- Feeling unprepared to respond to addiction biblically
- Tension between faith-based care and clinical treatment
- Protecting congregant privacy
- Supporting families, not just individuals
- Lack of structured addiction-ministry pathways

## Core Messaging Strategy

- Lead with **pastoral support, not authority**
- Emphasise **integration of gospel + clinical care**
- Focus on **family restoration**, not just sobriety
- Ask for **feedback, not commitment**
- Keep tone respectful, pastoral, and humble (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables - keep them as-is (`{{FirstName}}`, `{{SendingAccountFirstName}}`).
Pick the angle that fits the leader / ministry.

### Angle 1 - Gospel + Clinical Care Integration

```
Hi / Hey / Hello {{FirstName}},

I created a short 8-Point Ministry Guide for church leaders on how to respond to a congregant struggling with addiction in a way that faithfully integrates the gospel with medical and clinical care.

It's informed by data showing many pastors feel unprepared to address addiction biblically within their congregation.

Would you like me to share it for your review?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 2 - Clear Pathway for Families

```
Hi / Hey / Hello {{FirstName}},

I created a brief ministry resource showing how churches can establish a Christ-centered pathway for families seeking help with addiction.

It outlines how church leadership can stay informed while protecting congregant privacy.

Would you be open to reviewing it and sharing feedback?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 3 - Faith + Family Outcomes

```
Hi / Hey / Hello {{FirstName}},

I put together an 8-Point Ministry Guide showing how churches help families heal together through Christ-centered addiction recovery.

This guide is based on programs where faith and family involvement have been shown to significantly improve outcomes.

Would you like to take a look and share your thoughts?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

### Angle 4 - Family Restoration Focus

```
Hi / Hey / Hello {{FirstName}},

Addiction impacts the whole family - not just the individual.

I created a short Ministry Guide on how churches make family restoration central to their addiction ministry strategy, helping strengthen both the home and the heart.

I'm asking a few church leaders to take a quick look and share feedback.

Can I send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{SendingAccountFirstName}}

If this isn't relevant, just let me know.
```

---

## Key Value Points (use only real, approved points)

- Biblically grounded addiction response
- Integrates faith with clinical best practices
- Family-centred healing model
- Protects congregant privacy
- Gives pastors confidence and structure
- Positions the church as a safe place for help

## When to Use This Playbook

**Use when:**
- Partnering rehab or recovery programs with churches
- Outreach to pastors or care ministries
- Promoting education before referrals
- You want trust before any next step

**Avoid when:**
- Pitching treatment programs directly
- Targeting secular organisations
- Outreach that requires urgency or pressure

---

## Adapting for a client (checklist)

- [ ] `{{FirstName}}` / `{{SendingAccountFirstName}}` → confirm these Instantly fields exist and are mapped
- [ ] Every clinical / outcome / data claim ("shown to improve outcomes", "data showing…") is substantiated and appears in `clients/{slug}/voice.md` → Approved Claims - never imply guaranteed results
- [ ] The ministry guide actually exists and is ready to send before the hook goes out
- [ ] Tone stays pastoral, compassionate, and non-pressuring - equip, don't pitch
- [ ] Keep the opt-out line
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
