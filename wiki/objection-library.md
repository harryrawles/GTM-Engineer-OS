# Objection Library

The 15 most common objections in B2B cold email, with pattern recognition, response templates, and escalation triggers.

**Used by:** `gtm-skills/reply-handler.md` when a reply contains an objection.

**Why this exists:** the same objections come up across every campaign. Without a library, Harry improvises each time. With one, responses are consistent, tested, and patterns are visible across the portfolio.

---

> **Bias annotations added in v1.2.0.** Each response template below now shows which biases from `wiki/psychological-principles.md` it leverages. Use this to understand WHY each response works - and to compose your own when an objection does not match the pre-built patterns.

## How to Use

1. **Identify the objection type** - match the reply to one of the 15 patterns below
2. **Customise the response template** - pull proof points from `clients/{slug}/offer.md`, voice from `clients/{slug}/voice.md`
3. **Send the response** - always show Harry the draft first
4. **Log** to `clients/{slug}/comms-log.md` and (if patterned) to `clients/{slug}/decision-log.md`
5. **Escalate** per the rules below

---

## 1. "No budget" / "We're not spending right now"

**Pattern:** financial pushback. Could be true (budget frozen) or excuse (low priority).

**Response template:**
```
{{firstName}},

Makes sense.

Two thoughts:
- Budget cycles usually open back up Q[next quarter] for {{ICP_segment}}.
- In the meantime, [free resource / 1-pager] in case it's useful for planning.

Should I check back when budgets reopen?

Harry
```

**When to use:** prospect names budget as the blocker.

**Biases leveraged:** Disarming honesty (acknowledging the truth), Graduality tendency (future budget cycle), Reciprocation (free resource), Availability mis-weighing (staying available for the next cycle).

**Escalation:** if 4+ "no budget" replies on same campaign → ICP may be wrong (targeting unfunded). Flag in weekly-reviewer.

---

## 2. "We're happy with [competitor]" / "We already use X"

**Pattern:** loyalty signal. Cannot displace head-on. Aim for "second-place vendor."

**Response template:**
```
{{firstName}},

Good - [competitor] is solid.

Most teams using [competitor] tell me they hit a ceiling around [specific pain point]. If that ever surfaces, worth knowing we approach it differently via [single specific differentiator].

I'll close the loop unless that resonates.

Harry
```

**When to use:** prospect names a competitor.

**Biases leveraged:** Disarming honesty ('[competitor] is solid'), Frame-based misreaction (do not enter their loyalty frame), Curiosity tendency (the ceiling hook), Differentiation (one specific wedge).

**Escalation:** if specific competitor named 3+ times → log to `clients/{slug}/competitive-intel.md` and build a battle card.

---

## 3. "Send me a deck" / "Send me a one-pager"

**Pattern:** stall - they want to defer commitment. Sending a deck rarely converts.

**Response template:**
```
{{firstName}},

Decks tend to be 30 pages of stuff you'll skim.

Faster: I can record a 2-minute Loom on how we'd approach this for {{company}} specifically.

Want me to send it?

Harry
```

**When to use:** prospect asks for materials before committing.

**Biases leveraged:** Pattern break (decks are expected - Loom is not), Disarming honesty (decks are pages of skim), Curiosity tendency (2-min Loom), Effort perception bias (Loom feels custom).

**Escalation:** if Loom is the recurring ask → consider productising a templated Loom in `assets/`.

---

## 4. "Circle back next quarter" / "Email me in Q3"

**Pattern:** soft no with optionality. Real ones convert later. Most are deflection.

**Response template:**
```
{{firstName}},

Will do - diaried for [specific date in Q3].

Quick check before then: is there anything specific that would need to be true for this to be a priority?

Harry
```

**When to use:** prospect names a future date.

**Biases leveraged:** Inconsistency avoidance (committing to a date), Reason-respecting (asking what would need to be true), Subjective validation (acknowledging their timeline is real).

**Action:**
- Schedule follow-up reminder for the date
- Set sequence to pause until then
- Send a brief check-in 2 weeks before the named date

**Escalation:** if "circle back" turns into ghost 3+ times → drop the prospect from active sequence.

---

## 5. "Not the right person" / "Try X instead"

**Pattern:** routing - they're either redirecting accurately or deflecting.

**Response template:**
```
{{firstName}},

Appreciate the redirect.

Mind if I mention you pointed me their way?

Harry
```

**When to use:** prospect names someone else.

**Biases leveraged:** Politeness bias (appreciation), Reciprocation (giving them credit for the redirect), Ben Franklin effect (the small favour of an intro).

**Action:**
- Source the named contact's email
- Add to Instantly with "warm intro from [originalName]" angle
- Start a new sequence with referral angle

**Escalation:** if same DM name passes back to same other person 3+ times → that other person is the real ICP DM. Update `clients/{slug}/icp.md`.

---

## 6. "Not interested" (terse, no detail)

**Pattern:** polite no without explanation.

**Response template:**
```
{{firstName}},

Understood - appreciate the reply.

If timing changes, you can find us anytime.

Harry
```

**When to use:** prospect says no without naming a reason.

**Biases leveraged:** Disarming honesty (taking the no at face value), Availability mis-weighing (staying available), Familiarity bias (planting the seed for later).

**Action:** suppress in Instantly.

**Escalation:** if Email 1 generates >20% "not interested" replies → copy is off. Audit Part 1 / offer framing.

---

## 7. "How did you get my email?" / "How did you find me?"

**Pattern:** privacy concern. Sometimes hostile. Always respond honestly.

**Response template:**
```
{{firstName}},

Fair question - found you via [LinkedIn / company website / public source].

Reaching out because [specific reason tied to ICP / signal]. If it's not relevant, happy to drop.

Harry
```

**When to use:** prospect asks about data source.

**Biases leveraged:** Disarming honesty (lead with the truth - never lie about data source), Justification bias (clear reason for the outreach), Politeness.

**Rules:**
- Never lie about data source
- Never name third-party tools (RB2B, Trigify, etc.) - sounds invasive
- Reference public source even if data came from enrichment ("found via LinkedIn" is true if the chain started there)

**Escalation:** if reply is hostile / mentions GDPR → check `wiki/deliverability.md` compliance, escalate to Harry, do not auto-respond beyond the first reply.

---

## 8. "Take me off your list" / "Unsubscribe"

**Pattern:** opt-out request. Must be honoured.

**Response:** none - do not reply.

**Action:**
- Add to Instantly suppression list IMMEDIATELY
- Add to global suppression in `clients/{slug}/_config.md` if hostile
- Mark contact as opted-out in any CRM

**Biases (anti-pattern check):** if you are getting unsubscribes >0.5%, you have likely triggered Click-whirr conditioning (the pattern of a typical cold email is loud), or Disliking / hating tendency (something in the copy felt slimy).

**Escalation:** if >0.5% of campaign generates unsubscribe → copy is wrong audience or too aggressive. Pause and audit.

---

## 9. "What's the price?" / "How much does it cost?"

**Pattern:** real buying signal but they want to qualify on price before commitment.

**Response template:**
```
{{firstName}},

Pricing depends on [scope variable - volume, complexity, etc.].

Quickest path is a 15-min call to scope, then I can quote precisely.

Or if you want a ballpark first: we typically work in the [range] for {{ICP_segment}}.

Worth the call?

Harry
```

**When to use:** prospect asks price directly.

**Biases leveraged:** Anchoring (range before specific number), Permission-based mis-influence ('quickest path is...'), Cognitive closure (offering a path that resolves their uncertainty), Justification (price depends on X).

**Rules:**
- Never quote a precise number in email
- Always offer a range OR a call
- Match the price anchor to client's pricing in `clients/{slug}/offer.md`

**Escalation:** if price question is followed by silence → they price-shopped against a competitor. Follow up in 3 days with a different angle.

---

## 10. "Send me a case study"

**Pattern:** evaluation signal. Wants social proof.

**Response template:**
```
{{firstName}},

Closest fit: [client name from clients/{slug}/offer.md case studies] - [specific result + timeframe].

Two-page write-up here: [link]

If the parallel lands, happy to walk through the specifics for {{company}}.

Harry
```

**When to use:** prospect asks for case study.

**Biases leveraged:** Social proof (the named case), Quantitative specificity bias (the specific result), Subjective validation (matched to their parallel situation), Reciprocation (free content).

**Action:**
- Match case study by industry, size, or use case
- Use the specific named case from `clients/{slug}/offer.md`
- Set 7-day follow-up reminder

**Escalation:** if case study sent generates no response in 7 days → ghost likely. Move to nurture or drop.

---

## 11. "We tried this before, didn't work"

**Pattern:** scepticism rooted in past failure.

**Response template:**
```
{{firstName}},

Hear that often. Usually fails because of [specific common reason - e.g. wrong ICP, wrong signal, weak follow-up].

What part broke last time?

Harry
```

**When to use:** prospect references prior failed attempt.

**Biases leveraged:** Disarming honesty (acknowledging the prior failure), Understanding bias (showing you know why most fail), Excessive self-regard handled gently (not blaming them), Curiosity tendency (the question reframes them as expert).

**Action:**
- Get them talking about the specific failure point
- Position your approach as different on that specific axis
- Use case study to prove the differentiated approach worked

**Escalation:** if "tried before" is common in segment → consider repositioning offer around "why this time is different."

---

## 12. "We do this in-house"

**Pattern:** ownership signal - they have internal capability.

**Response template:**
```
{{firstName}},

Good - in-house gives you control.

Where most {{ICP_function}} teams land is they hit a ceiling at [specific scale or specific blocker]. If that point arrives, worth knowing we offload the [specific task] piece without disrupting the in-house workflow.

I'll close the loop unless that hits.

Harry
```

**When to use:** prospect names internal capability.

**Biases leveraged:** Status quo bias respected (you are not asking them to replace), Disarming honesty (in-house IS good), Curiosity tendency (the ceiling hook), Availability mis-weighing (staying top of mind for when ceiling hits).

**Action:** position as "augmentation, not replacement." Stay top-of-mind for when they hit the ceiling.

**Escalation:** if 4+ "in-house" replies on same campaign → ICP may be too senior (large teams = in-house). Move down market.

---

## 13. "Email me Q[X] when we plan budgets"

**Pattern:** soft yes with timing constraint.

**Response template:**
```
{{firstName}},

Diaried for Q[X].

Quick: what changes in Q[X] vs now? Just want to send the right thing at the right time.

Harry
```

**When to use:** prospect names a budget planning window.

**Biases leveraged:** Inconsistency avoidance (committed to a date), Curiosity tendency (the change question), Subjective validation (treating their timing as real).

**Action:**
- Schedule precise follow-up date
- Set sequence to pause
- 2 weeks before the date, send a check-in tailored to whatever changed

**Escalation:** real signal - convert this into a known opportunity. Add to pipeline tracker.

---

## 14. "Can we connect on LinkedIn instead?"

**Pattern:** soft positive - they want lower-pressure relationship.

**Response template:**
```
{{firstName}},

Sure - just sent the request.

Quick note attached so it makes sense out of context.

Harry
```

**When to use:** prospect suggests LinkedIn.

**Biases leveraged:** Reciprocation (responding to their preference), Familiarity bias (LinkedIn = lower-pressure ongoing exposure), Effort perception (custom note).

**Action:**
- Send LinkedIn connection request from Harry's account
- Brief context note
- Continue email sequence in parallel but lower frequency
- Use LinkedIn for value-add posts and engagement

**Escalation:** if multi-touch (email + LinkedIn) converts well → log pattern to `clients/{slug}/decision-log.md` and consider as default for similar prospects.

---

## 15. "We're a [size/stage] - not big enough" or "Too small for us"

**Pattern:** ICP mismatch from their side. Either they're disqualifying themselves correctly or wrongly.

**Response template:**
```
{{firstName}},

Hear that often.

Specifically: at [their stage / size], the issue is usually [specific stage-appropriate problem]. We work with [smaller similar company from offer.md] and [bigger similar company] - both end up needing the same thing.

Quick call to scope fit before assuming?

Harry
```

**When to use:** prospect says they're too small/big.

**Biases leveraged:** Disqualified identity bias (acknowledging the disqualification but reframing), Anchoring (smaller AND bigger examples to bracket their position), Reason-respecting (specific stage-appropriate problem).

**Action:**
- If self-disqualifying wrongly → push back with case study
- If correctly disqualifying → respect it, suppress, move on

**Escalation:** if size-based no is recurring → ICP filter in `clients/{slug}/icp.md` is too broad. Tighten size criteria.

---

## Cross-Cutting Rules

### Always
- Match voice in `clients/{slug}/voice.md`
- Use proof points from `clients/{slug}/offer.md` only - never invent
- Keep response under 75 words (default), 60 for ATL
- One CTA per response
- Log to `clients/{slug}/comms-log.md`

### Never
- Argue with the prospect
- Repeat the original pitch verbatim
- Send the same response to 2 different objections
- Auto-respond to hostile / GDPR-flagged messages without Harry's approval

### Escalation triggers (auto-flag to Harry)
- Any response involving GDPR, CAN-SPAM, or legal language
- Any 2nd objection from same prospect (don't enter circular argument)
- Any "we know your CEO" or "talked to your team" hints (relationship signal worth manual review)
- Any request for refund, complaint, or formal action

---

## Pattern Tracking

When the same objection appears 3+ times on the same campaign, log to `clients/{slug}/decision-log.md`:

```
### {{date}} - Pattern: {{objection type}} recurring on {{campaign}}

**Frequency:** {{n}} times in {{period}}
**Context:** {{what the campaign was}}
**Hypothesis on root cause:** {{guess at what's wrong with offer/ICP/copy}}
**Recommended fix:** {{specific change}}
**Decision:** {{adjust offer / refine ICP / change copy / accept as cost of doing business}}
```

This is how the OS learns from objection patterns over time.