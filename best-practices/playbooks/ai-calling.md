# Playbook: AI — Pro-Bono AI Calling Agent (Dealership Outreach)

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client offering an **AI voice / phone
automation** product to high-call-volume businesses — led by a free/pilot offer framed around lead capture,
responsiveness, and after-hours coverage. Example built around car dealerships.
**Origin:** Abstracted from an AI-calling dealer campaign. All brand-specific values are placeholders —
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **⚠️ Two guardrails — read first.**
> 1. **Keep "pro-bono" genuine.** If "free" is really bait for a later upsell, prospects lose trust the
>    moment the "free" turns into a sales conversation. Only use the pro-bono framing when there's real
>    capacity to deliver something actually free. The source's own tips warn about this.
> 2. **AI calling carries real regulatory exposure.** Outbound AI calling — and even inbound AI voice agents —
>    can trigger **TCPA** (U.S.) and equivalent telemarketing/robocall rules depending on how the deployed
>    product places or handles calls. Liability can land on the dealership as much as the client. Have
>    whoever owns compliance review the actual product behaviour before promising a working AI calling agent,
>    and keep capability claims technically accurate. Per the OS Safety Guard, treat this as blocked pending
>    explicit client approval + compliance comfort.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. Never carry one client's specifics into another.

---

## Campaign Goal

Start conversations with dealerships by offering a **free (pro-bono) AI voice agent / phone bot**, positioned
to improve lead capture, responsiveness, and after-hours coverage. Trigger curiosity with a low-risk,
high-relevance automation offer — not an immediate sell.

## Ideal Customer Profile (ICP)

**Targets:**
- Car dealerships (new & used)
- Sales managers, general managers, owners
- Dealerships with active lead flow (ads, website forms, calls)

**Behaviour signals:**
- High inbound lead volume (calls, form fills)
- Missed calls / slow response issues
- Heavy reliance on phone-based sales
- Already using a CRM or basic automation

**Pain points:**
- Missed calls = lost deals
- Slow response time to leads
- Staff overload during peak hours
- No 24/7 lead-handling system

## Core Messaging Strategy

- Lead with the **pro-bono / free** offer angle (genuine only)
- Position AI as a **practical phone-automation assistant**
- Focus on **lead capture + availability** (24/7 coverage)
- Keep the message extremely short and non-salesy
- Use a **binary relevance question** (yes/no)
- Tone: simple, direct, operational, low-friction (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields and spintax are Instantly syntax — keep them as-is (`{{random|...}}`, `{{city}}`,
`{{companyName}}`, `{{sendingAccountName}}`).

### Email 1 — Variant 1 (ultra-short)

```
Hi — {{random|My company|My AI company|my tech agency}} is looking to set up pro-bono {{random|AI calling agent|AI voice assistant|AI phone bot}} for {{city}}-based dealerships.

{{random|Is this relevant to|Useful for|Relevant to}} {{companyName}}?

{{random|Regards|Thanks|Thank you}},
{{sendingAccountName}}
```

### Email 1 — Variant 2 (shortest-email frame)

```
{{random|Hi|Hello|Hey}} there, this will be the {{random|shortest|briefest|quickest}} email you receive {{random|this month|this week|this quarter}}.

{{random|My company|My AI firm|My tech agency}} is looking to provide a {{random|no-cost|free|complimentary}} {{random|AI calling solution|AI phone bot|voice automation system}} for dealerships that {{random|want 24/7 coverage|need faster lead capture|are still using voicemail}}.

{{random|Is this relevant to|Would this be useful for|Do you see this as relevant to}} {{companyName}}?

{{random|Regards|Thanks|Thank you}},
{{sendingAccountName}}
```

---

## Key Value Points (use only real, approved points)

- Pro-bono framing removes immediate sales resistance (keep it genuine)
- AI phone automation is a highly tangible use case for dealerships
- Short email structure increases reply probability
- Binary relevance question reduces friction
- Operational pain points (missed calls, voicemail, speed) are instantly relatable
- Local framing (city-based dealerships) increases perceived specificity

## When to Use This Playbook

**Use when:**
- Targeting dealerships or high-call-volume businesses
- You can actually deliver real AI calling capability
- Offering a genuine pilot / free implementation makes sense
- You want fast qualification replies (not long nurture)

**Avoid when:**
- No real AI calling product exists or can be deployed
- Compliance constraints on automated-calling claims aren't cleared
- Low-call-volume businesses (no pain trigger)
- Generic targeting without dealership context

## Why This Works

- **"Free pro-bono"** lowers the guard immediately (when genuine)
- **AI + phone** = instantly understandable value
- **Dealership pain is obvious** (missed calls = lost revenue)
- **Minimal cognitive load** email structure
- **Relevance question** forces an engagement decision
- **Ultra-short format** stands out in inbox noise

## Execution Tips (important)

- Keep "pro-bono" genuine — don't overuse if there's no real capacity to deliver free
- Ensure AI calling claims are technically accurate and compliant (TCPA/robocall rules)
- Avoid sounding like spam automation at scale
- "City-based dealerships" should be real segmentation, not filler
- First-reply goal is simply interest confirmation — don't overcomplicate follow-up
- If scaling, rotate variants but keep the structure extremely simple

## Strategic Insight

This campaign works because it doesn't sell software — it sells *"we can help your dealership not miss calls
and capture more leads automatically."* The power is in the pain of missed opportunities, not the AI itself.
Done right, the prospect doesn't think "is this interesting?" — they think "how many leads am I already
losing?"

---

## Adapting for a client (checklist)

- [ ] **Pro-bono check** — the free offer is real and deliverable, not bait for an upsell
- [ ] **Compliance check** — AI calling behaviour reviewed against TCPA / local robocall rules; capability claims are accurate; client + compliance sign-off obtained
- [ ] `{{city}}` / `{{companyName}}` / `{{sendingAccountName}}` → confirm these Instantly fields exist and are mapped
- [ ] "City-based" segmentation is real, not filler
- [ ] Confirm the offer and any claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
