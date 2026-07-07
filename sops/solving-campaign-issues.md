# SOP: Solving Campaign Issues

When: diagnosing and fixing an underperforming campaign. A tactical reference, not a diagnostic
procedure, run `gtm-skills/campaign-optimiser.md` first to find the root cause, then work through the
relevant section below for the fix. If you have applied these plays and are still stuck, follow
`sops/gtme-unlock-ladder.md`.

Campaigns don't perform for a multitude of reasons:
- Irrelevant messaging to the ICP.
- Tough niches, offers, or industries.
- Deliverability (the main cause, most of the time).
- Wrong timing.
- Many other reasons beyond this list.

---

## Positive Reply Rates

Make the call to action extremely low-risk initially. Don't think "how do I get a meeting", think "how do
I make this email unreasonable for the prospect to ignore."

Approaches:
- Remove call/meeting/chat CTAs from the initial copy.
- Lead with an offer a prospect would typically pay for.
- Personalise the email with AI, reference the prospect's sub-industry, ICP, or competitors, then ask if
  the email is relevant to them.

A slightly exaggerated example:

"Hi {John}, my team just analysed {local competitor 1/2/3}'s SEO approach to engaging {ICP}.

We found 3 specific content-led approaches they are using that most {sub-industry} organisations are not.
We broke this down into a video.

Would this video be relevant to {company name}?"

The same idea for a SaaS martech client:

"Hi {John}, how do you go about scaling your outbound without having to hire more SDRs?

My founder is looking to run free pilots of our AI outbound engine, specifically programmed to
{sub-industry} organisations engaging {ICP}.

Would {company name} be the right organisation to contact about this?"

Both examples are the same low-resistance CTA already required by `wiki/copywriting-101.md` ("Is this
relevant to {{company}}?"), applied to a specific offer-led opener.

Client psychology: if a client can already see positive replies, they get a bit excited. In the
long-term they want meetings, and most likely around 20% of these leads become positive replies, but the
early positive replies buy in to what you are doing and keep the client away from writing their own copy
or demanding more split-testing. Once the client says "these replies are great, but we can't get
meetings", increase the resistance to reply and make the ask slightly more meeting-led, you either get
meetings or fewer leads with no meetings either way. It makes more sense to work backwards from lots of
positive replies as the client sees progress and trusts you more, than to work forwards from a
high-resistance ask the client has no evidence will work yet.

---

## Deliverability

Deliverability is a minefield. The main ESPs you send to behave differently:
- **Gmail** - easiest to inbox with.
- **Outlook** - had a major outage from September 2024, back to normal now.
- **Proofpoint / Barracuda / Mimecast** - leading email security providers, each offering distinct
  filtering against unsolicited and AI-personalised email specifically.

These tools spend heavily to stop unsolicited email. What they look out for:

Obvious signs:
- The same email repeated again and again.
- Spam words in the copy.
- Open/link tracking, the tracking code is a breadcrumb in the email.
- Links or images in the email.
- Poor-reputation domains (.co has been a recent casualty, .com is best).

Less obvious signs (Proofpoint / Barracuda / Mimecast specifically):
- The same email structure and sentiment, even once every line is personalised and spintaxed.

You can measure deliverability via reply rate. The floor you want is 2.8%+, if reply rate is below that
and falling, mailboxes are beginning to decay or fall into spam (this refines the "Under 3%: Danger zone"
line already in `wiki/email-benchmarks.md` and `wiki/deliverability.md`, treat 2.8% as the precise cutoff
going forward).

Why this happens:
- Mailboxes reaching the end of their lifecycle.
- Copy fatigue, the same email sent over and over.
- Open/link tracking or non-plain-text sending still switched on.

What can we do about it (some of this may not be possible at our client volume):
- Ask the client to fund more mailboxes.
- Provision more mailboxes than needed and keep some in reserve.
- Tap into the pre-warm pile, if the client is happy with that.
- For Fortune 500 targets specifically, A/B variants can carry the same offer said in different ways
  rather than different offers, security filtering reacts to structure more than message.
- Try a slightly smaller ICP with less security investment, only if the client is comfortable with that
  trade-off.

Mailbox and pre-warm provisioning itself is AM-owned execution (`sops/am-gtme-responsibility-split.md`),
once the client agrees to fund more capacity, hand the provisioning to the AM rather than doing it
yourself.

Client psychology: because we have automated signals for poor deliverability, we notice this weeks
before the client does. Being proactive about it, even though the detection itself is mostly automated,
makes the client more likely to invest further, trust the relationship more, and stay longer. Greater
lifetime value and more MRR for the account overall.

---

## ICP Miss

ICP messaging mismatches mostly happen with clients who:
- Have a brand new offer and aren't fully certain of their ideal audience yet.
- Are new to outbound and don't yet know what offers work in this channel.

What to do:

Refer back to Cowork data and onboarding data first. Did you miss something in discovery or onboarding?
If you're still not sure, message another operator, or Aaron, and ask for help, they might have an angle
you haven't explored. This is the same "ask before you sit on it" pattern as
`sops/gtme-unlock-ladder.md`.

Lookalike play: one useful way to use Instantly's lookalike features is to ask the client, in an ideal
world, what big company would this product or service solve the biggest problem for. Build a lookalike
scrape of similar companies and build a lead-magnet campaign or offer focused toward them. This is the
same lookalike-building process already in `wiki/list-building.md`'s "Lookalike Building" section, applied
specifically to recover from an ICP miss rather than to build a new list from scratch.

---

## Where this fits in the OS

- **This is the fix playbook, `gtm-skills/campaign-optimiser.md` is the diagnosis.** Run the optimiser's
  funnel to find the root cause (deliverability, list/ICP, offer, copy), then use the matching section
  above for the actual fix. This SOP is listed in the optimiser's extended reads.
- **The Positive Reply Rate examples are illustrations of an existing rule, not a new one.**
  `wiki/copywriting-101.md`'s "never lead with a meeting ask on Email 1" and its low-resistance CTA list
  already require exactly this. Nothing new was added to the wiki, these are worked examples of the same
  rule.
- **The Deliverability section is the copy-side detail underneath `wiki/deliverability.md`'s intro line**
  ("the copy-side factors that affect deliverability"). That file stays the terse diagnostic reference,
  this SOP is the fuller tactical explanation of why those factors matter and what to do about them.
  Mailbox/domain/DNS execution is still AM's either way.
- **"Cowork" is the same AI assistant named in `sops/gtme-unlock-ladder.md`** (Step 1 there). Standardised
  on that name here rather than "co-pilot."
- **Aaron** is the same person named across `sops/gtme-escalation-to-am.md`, `sops/client-handover.md`, and
  `sops/client-communication-principles.md`, here as an ICP/angle resource on top of his other roles.
