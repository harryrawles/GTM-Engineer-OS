# Playbook: Booking SaaS - Pre-Created Access + Discount Hook

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client with an **experiential /
booking product** (travel, hospitality, lifestyle) that can offer a real incentive - led by friction removal
(ready-to-use access) + a discount hook + a curiosity CTA. Example built around a stays-booking platform.
**Origin:** Abstracted from a travel-booking campaign. All brand-specific values are placeholders -
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **⚠️ Compliance guardrail - read first.** This playbook's original hook pre-creates an account and emails
> login credentials to a cold prospect. That is **high-risk**: it can breach privacy/anti-spam law, damage
> deliverability, erode trust, and create security liability. Do **not** run the credential-sharing variant
> unless the client has legal sign-off and a genuinely compliant, consented flow. Prefer the **safe variant
> below** (offer to set up access / send a one-click invite) as the default. Per the OS Safety Guard, treat
> credential-sharing outreach as blocked pending explicit client approval.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. Incentives (`{{DISCOUNT}}`) must be real. Never carry one client's specifics into another.

---

## Campaign Goal

Start conversations by giving prospects **immediate, ready-to-use access** to the product paired with a
tangible incentive, then naturally move them into exploring listings. High friction-removal + curiosity-driven.

## Ideal Customer Profile (ICP)

**Targets:**
- Frequent travellers (leisure + business)
- High-income professionals
- Founders, executives, remote workers
- People already using Airbnb or boutique hotels

**Behaviour signals:**
- Travel at least a few times per year
- Comfortable booking premium stays
- Values convenience and quality over price
- Used to digital booking platforms

**Pain points:**
- Too many options when booking stays
- Inconsistent Airbnb quality
- Hotels feel generic or restrictive
- Time wasted comparing listings

## Core Messaging Strategy

- Lead with a **strong binary framing** (hotel vs Airbnb)
- Introduce the product as a **third option combining both**
- Create **instant ownership** (access ready for them)
- Add a **financial incentive** (`{{DISCOUNT}}`) to trigger curiosity
- End with a **low-effort engagement question**
- Tone: direct, slightly bold, concierge-style, not overly salesy (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables - keep them as-is (`{{firstName | there}}`, `{{email}}`,
`{{sendingAccountName}}`). `{{COMPANY}}` = the active client's brand; `{{DISCOUNT}}` = the real incentive.

### Email 1 - Safe Variant (default, recommended)

```
Hi {{firstName | there}}, if you had the choice: 5-star hotel or Airbnb - would you pick both? That's exactly what {{COMPANY}} homes were built for.

I can set you up with instant access and a {{DISCOUNT}} credit for your first stay - one click, no signup hassle.

Want me to send a few hand-picked homes that would be perfect for your next trip?

{{RANDOM|Thanks|Thank you|Best}},
{{sendingAccountName}}

If you don't want to hear from me anymore, just let me know.
```

### Email 1 - Pre-Created Access Variant (⚠️ only with legal sign-off + compliant, consented flow)

```
Hi {{firstName | there}}, if you had the choice: 5-star hotel or Airbnb - would you pick both? That's exactly what {{COMPANY}} homes were built for.

I took the liberty of creating a {{COMPANY}} account for you and set up a {{DISCOUNT}} discount for your first stay:

Login: {{email}}
Password: [system-generated, change anytime]
Discount code: FirstStay{{firstName}}

Want me to send a few hand-picked homes that would be perfect for your next trip?

{{RANDOM|Thanks|Thank you|Best}},
{{sendingAccountName}}

If you don't want to hear from me anymore, just let me know.
```

---

## Key Value Points (use only real, approved points)

- Binary hook (hotel vs Airbnb) → fast attention grab
- "Both in one" positioning → simple product understanding
- Ready access → removes signup friction
- Real discount → strong activation incentive
- Curated follow-up offer → opens an engagement loop
- Soft opt-out line → reduces resistance and spam perception

## When to Use This Playbook

**Use when:**
- The product is experiential (travel, hospitality, lifestyle)
- You can offer real incentives (discounts, credits, trials)
- Targeting high-intent or high-income prospects
- You want fast replies rather than long nurture

**Avoid when:**
- You can't provision access safely and compliantly
- Low-trust / cold mass outreach without relevance
- The product isn't immediately experience-driven
- Any legal/compliance risk around credential sharing (default to the safe variant)

## Why This Works

- **Ownership effect:** people respond more when something feels set up for them
- **Framing contrast:** hotel vs Airbnb primes decision-making instantly
- **Loss aversion:** the discount increases urgency to explore
- **Friction removal:** no signup step → immediate access
- **Curiosity trigger:** "hand-picked homes" invites response
- **Conversational CTA:** a low-pressure question instead of a hard sell

## Execution Tips (important)

- Ensure any access provisioning is legit, consented, and compliant (no misleading access)
- If credentials are ever shared, use system-generated passwords - never a predictable format
- Make "hand-picked homes" genuinely curated if you send them
- Don't over-explain the product in the first message - let curiosity work
- Avoid over-sending discount-heavy variations (erodes credibility)

---

## Adapting for a client (checklist)

- [ ] **Compliance check first** - confirm the access flow is legal, consented, and client-approved; default to the safe variant unless legal sign-off exists for pre-created accounts
- [ ] `{{COMPANY}}` → client brand (from `clients/{slug}/_config.md`)
- [ ] `{{DISCOUNT}}` → the client's real, approved incentive (`offer.md`)
- [ ] `{{firstName | there}}` / `{{email}}` / `{{sendingAccountName}}` → confirm these Instantly fields exist and are mapped
- [ ] Confirm the offer and any claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Keep the opt-out line
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
