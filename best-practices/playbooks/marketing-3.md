# Playbook: Marketing 3 - Google Review Removal / Reputation Outreach

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client offering **review management /
reputation services** to local businesses - led by observational personalisation (referencing real reviews)
and a direct problem → solution frame.
**Origin:** Abstracted from a review-removal campaign. All brand-specific values are placeholders -
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **⚠️ Compliance guardrail - read first.** Claiming to *delete* or *guarantee removal* of genuine Google
> reviews conflicts with **Google's policies** and can breach consumer-protection / advertising law. Do
> **not** promise guaranteed deletion. Only run this when the client has a **legitimate, lawful** review-
> management capability (e.g. flagging policy-violating reviews for Google's review, responding, or
> suppression via more positive volume) and soften the copy accordingly. Per the OS Safety Guard, treat
> guaranteed-removal claims as blocked pending explicit client approval and legal comfort.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. Only reference reviews you've actually looked at. Never carry one client's specifics into another.

---

## Campaign Goal

Initiate conversations with business owners by **referencing their Google reviews** and offering a
review-management service - a direct problem → solution frame that triggers curiosity and replies.

## Ideal Customer Profile (ICP)

**Targets:**
- Local business owners
- Service-based businesses (clinics, agencies, contractors, etc.)
- Businesses with visible Google reviews
- Companies where reputation impacts lead flow

**Behaviour signals:**
- Active Google Business Profile
- At least a few negative or mixed reviews
- Reliance on Google for inbound customers
- Sensitivity to online reputation

## Core Messaging Strategy

- Start with light **observational personalisation**
- Create implied credibility ("we specialise")
- Highlight **problem visibility** (negative reviews exist)
- Offer a direct fix (review management) - **without guaranteeing deletion**
- End with a low-friction question CTA
- Tone: neutral, helpful, slightly investigative (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields and spintax are Instantly syntax - keep them as-is (`{{firstName}}`,
`{{sendingAccountFirstName}}`, `{{RANDOM|...}}`). The template below is the exact spintax variant; soften any
"have it deleted" phrasing to compliant language ("help you address / flag / respond to") before sending.

### Email 1 - Review Reference (exact spintax template)

```
{{RANDOM|Hi |Hello | |Hey}} {{firstName}},

I was {{RANDOM|checking out|looking through|reviewing|browsing|going over}} some of your Google reviews, and a few {{RANDOM|grabbed my attention|caught my eye|stood out to me|got my attention|seemed notable}}. If you're interested, I can {{RANDOM|have it deleted for you|help you get it removed|assist in removing it|get it taken down|take care of it for you}}.

We {{RANDOM|specialize in deleting negative reviews|focus on removing unfavorable reviews|help businesses clean up bad reviews|are experts in eliminating unwanted reviews|specialize in handling review removal}}, and I {{RANDOM|noticed|saw|came across|observed|realized}} you have {{RANDOM|some bad reviews|a few negative reviews|unfavorable reviews|problematic reviews|a couple of critical reviews}} we could {{RANDOM|help remove|assist in deleting|take care of|eliminate for you|get rid of}}.

{{RANDOM|Would you want me to have these kinds of reviews deleted from Google?|Are you interested in having these negative reviews removed from Google?|Would you like me to help get these reviews taken down?|Do you think it's worth removing these from Google?|Would you prefer to have these reviews removed from your profile?}}

{{RANDOM|I'd love to hear your thoughts|Would love to get your feedback|Looking forward to your thoughts|Excited to hear what you think|Let me know your thoughts|I'm eager to hear what you think|Would appreciate your feedback|Let me know your take|Interested in your perspective|Curious about your thoughts}}

{{RANDOM|Thanks|Thank you|Have a good day|All the best|All my best|Best regards|Best|Sincerely|Take care|Warm regards|Yours truly|Cheers|Kind regards|Wishing you the best|With gratitude|Until next time|Take it easy|Stay well|Best wishes|Have a great week|Warmest regards|Stay awesome}},
{{sendingAccountFirstName}}

If you don't want to hear from me anymore, just let me know.
```

> **Compliance note on the template:** the "delete / remove / eliminate" spintax options above imply
> guaranteed removal of genuine reviews. Before sending, replace them with lawful phrasing that matches what
> the client can actually do (e.g. "help you flag reviews that break Google's rules", "help you respond and
> rebuild your rating"). Keep this only if the client has legal sign-off.

---

## Key Value Points (use only real, approved points)

- Heavy personalisation via review reference
- Randomised opening lines reduce template fatigue
- Direct problem framing (negative reviews = attention hook)
- Clear service offer (compliant review management)
- Multiple CTA variations for engagement testing
- Soft opt-out improves deliverability perception

## When to Use This Playbook

**Use when:**
- You can reliably reference real Google reviews
- Targeting local service businesses
- Reputation directly impacts revenue
- You have a legitimate, lawful review-management capability

**Avoid when:**
- No real review analysis is performed (feels spammy fast)
- Businesses have no visible negative reviews
- You'd need to claim "removal guarantees" (compliance risk)
- Highly regulated industries with strict advertising rules

## Why This Works

- **Context anchoring:** "I looked at your reviews" feels specific and real
- **Attention bias:** negative reviews trigger emotional relevance
- **Authority shortcut:** "we specialise" reduces skepticism
- **Problem visibility:** owners already care about reviews
- **Low-friction CTA:** a simple yes/no reduces cognitive load
- **Randomised phrasing:** reduces template fatigue

## Execution Tips (important)

- Only use when you can actually point to real reviews
- Avoid guaranteed-deletion language - it raises trust and legal issues if misused
- Keep variation balanced - too much randomness reduces clarity
- Stronger when you reference specific review themes (if allowed)
- Always ensure compliance with Google's policies and local laws
- Monitor replies for skepticism around "removal claims"

---

## Adapting for a client (checklist)

- [ ] **Compliance check first** - confirm the client's review capability is legitimate and lawful; strip guaranteed-removal language; get legal sign-off before any "delete/remove" claim
- [ ] `{{firstName}}` / `{{sendingAccountFirstName}}` → confirm these Instantly fields exist and are mapped
- [ ] You've actually reviewed the target's Google profile before referencing it
- [ ] Confirm the offer and any claims appear in `clients/{slug}/voice.md` → Approved Claims
- [ ] Keep the opt-out line
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
