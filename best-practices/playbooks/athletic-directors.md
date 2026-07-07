# Playbook: Athletic Directors / Coaches Campaign

**Type:** Shared campaign playbook (client-agnostic). Reusable across any client selling a
leadership / culture / player-development platform into athletic directors and coaches, led by
**credibility + a scannable feature list + an ultra-low-friction demo CTA**.
**Origin:** Abstracted from a coaching-platform campaign. All brand-specific values are placeholders -
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. The feature block below is an **illustrative template** - replace the feature names and
> descriptions with the client's actual product modules. Endorsements (`{{NOTABLE_ENDORSER}}`) must be
> real and approved. Never carry one client's product names or endorsers into another's campaign.

---

## Campaign Goal

Introduce the client's platform to athletic directors and coaches by emphasising **leadership development,
team culture, and athlete well-being** - backed by credible coaching input.

## Ideal Audience

**Targets:**
- Athletic Directors (High School + College)
- Head Coaches
- Assistant Coaches
- Player Development staff
- Student-athlete support roles

**Pain points:**
- Team culture issues
- Low engagement or motivation
- Poor communication between coaches & athletes
- Lack of leadership or mindset tools
- Difficulty monitoring athlete well-being

## Core Messaging Strategy

- Lead with **credibility** (`{{NOTABLE_ENDORSER}}` + top coaches - real, approved names only)
- Highlight core features in a simple, scannable way
- Keep tone supportive, not salesy (defer to `clients/{slug}/voice.md`)
- CTA is ultra low friction: "Reply 'demo' for a short video"

---

## Sequence

Merge fields are Instantly variables - keep them as-is (`{{firstName | Coach}}` uses Instantly's fallback
syntax; `{{accountSignature}}`). `{{COMPANY}}` / `{{NOTABLE_ENDORSER}}` / the feature block = the active
client's real, approved product and endorsements.

### Email 1 - Initial Outreach

```
Hi {{firstName | Coach}},

{{COMPANY}} is a digital platform that builds leadership, mindset, and team culture - created with input from top coaches across the country, including {{NOTABLE_ENDORSER}}.

Quick look at what's inside:

{{FEATURE_1}} - {{FEATURE_1_DESC}}
{{FEATURE_2}} - {{FEATURE_2_DESC}}
{{FEATURE_3}} - {{FEATURE_3_DESC}}
{{FEATURE_4}} - {{FEATURE_4_DESC}}

Reply "demo" and I'll send a short video.

{{accountSignature}}
```

**Feature block - illustrative example (replace with the client's real modules):**

- **Word of the Week** - weekly insights from a marquee coach, built around one leadership theme.
- **Builders** - 100+ short video lessons from elite coaches and athletes; assign to a team in seconds.
- **Journal** - guided prompts that help athletes build perspective, discipline, and growth.
- **Pulse** - daily 2-minute surveys giving a snapshot of team culture and athletes' well-being.

---

## Key Selling Points (use only real, approved points)

- Endorsed by credible, named coaches
- Strengthens leadership and team culture
- Gives coaches real-time visibility into athlete well-being
- Simple to implement and assign content
- Improves communication & connection with players

## When to Use This Playbook

**Use when:**
- Contacting athletic directors or coaches
- Outreach before season start, pre-season, or mid-season resets
- Promoting culture-building or player-development tools
- Targeting schools interested in leadership & mindset programs

**Avoid when:**
- Reaching academic departments or non-athletic staff

---

## Adapting for a client (checklist)

- [ ] `{{COMPANY}}` → client brand (from `clients/{slug}/_config.md`)
- [ ] `{{NOTABLE_ENDORSER}}` → only a real, approved endorser named in `clients/{slug}/voice.md` → Approved Claims
- [ ] Feature block → the client's actual product modules + one-line descriptions (`offer.md`)
- [ ] Confirm the demo CTA reply keyword matches how the client's Instantly reply-handling is set up
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
