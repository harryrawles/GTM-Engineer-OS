---
name: client-onboarder
description: Spins up a new client inside the multi-client OS - creates the folder from the template, then runs the full 5-phase conversational intake (identity, offer, ICP, voice, infrastructure), writing answers directly to that client's files.
triggers:
  - "Onboard new client"
  - "Set up the OS for {{client}}"
  - "Let's fill in the OS"
  - "Run client onboarder"
  - "New client just signed"
  - "Onboard {{client_name}}"
reads:
  - "wiki/_skill-context.md (once the folder exists)"
  - "templates/client-template/ (source for the new folder)"
  - "clients/{slug}/*.md (own files, to detect resume state)"
  - "wiki/offer-framework.md, offer-creation-theory.md (Phase 2)"
  - "wiki/list-building.md, signal-sourcing.md, atl-btl-messaging.md (Phase 3)"
writes:
  - "clients/{slug}/_config.md, overview.md, offer.md, icp.md, voice.md, campaign-state.md"
  - "clients/{slug}/secrets/credentials.md (API key, git-ignored)"
  - "_state/active-client"
---

# Skill: Client Onboarder

**Trigger:** "Onboard new client", "Set up the OS for {{client}}", "Let's fill in the OS", "Run client onboarder", "New client just signed", "Onboard {{client_name}}"

**Context:** This skill spins up a new client inside the multi-client OS, then runs the full conversational onboarding flow. It creates the client's folder from the template, asks the GTME questions phase by phase, writes the answers directly to that client's files, and verifies the client is ready to launch.

**The conversation IS the intake.** The GTME should not fill the intake form manually. This skill replaces that workflow.

Per `sops/daily-structure.md`, onboarding is Block 1 of the working day and takes priority over everything else whenever one is pending.

This skill is the internal data-capture flow. The parallel client-facing message cadence and call checklists for the same two weeks are `sops/onboarding-documentation.md`.

---

## STANDARD CONTEXT

Read `wiki/_skill-context.md` for the standard files every skill loads. It does not apply in full before
the client folder exists (there is no `MEMORY.md` to load yet) - read it fully once STEP 0 has created the
folder, and again at the start of every resumed session.

---

## STEP 0 - Create / Resolve the Client Folder (do this FIRST)

A new client is a folder under `clients/`, created by copying the template. Before anything else:

1. **Derive the slug** from the client name: lowercase-kebab (e.g. "Acme Corp" → `acme-corp`).
2. **If `clients/{slug}/` does not exist yet**, create it from the template:
   `cp -r templates/client-template/ clients/{slug}/` (this brings the full file set, including
   `secrets/credentials.template.md`).
3. **Create the real secrets file:** rename `clients/{slug}/secrets/credentials.template.md` →
   `clients/{slug}/secrets/credentials.md` (git-ignored) - move it, don't leave a copy behind, otherwise
   every client's secrets folder permanently carries a stray placeholder file. Leave keys blank until
   Phase 5. **Never** put a real API key in the committed source template under `templates/client-template/`.
4. **Set the active client:** write the slug to `_state/active-client` and confirm: "Active client: {Name}."
5. `{slug}` in every path below now resolves to this client's folder.

If `clients/{slug}/` already exists, skip creation and treat this as a resume (see STARTUP below).

---

## STEP 0.1 - Log Invocation (mandatory)

Once the folder exists, append one row to `clients/{slug}/session-log.md` Active Log table:

```
| YYYY-MM-DD HH:MM | {{paraphrased prompt summary, ~60 chars}} | {{this skill name}} | (filled at end) |
```

Rules (per `wiki/_skill-context.md` "Session-Log Write"):
- Write at START, not end - captures the attempt even if the skill fails mid-execution
- Paraphrase the prompt - no raw prospect names, emails, or sensitive data
- Skill name only (no path)
- Outcome column filled at end of execution

Without this row, `gtm-skills/pattern-detector.md` cannot find repeating prompts and the auto-improvement loop breaks.

---

## RULES (read first)

1. **Run in 5 phases.** Do not jump ahead. Each phase has a clear write target.
2. **Ask one question at a time.** Wait for the answer. Do not batch unless the GTME says "batch the rest."
3. **Write files as you go.** After each phase, write to the corresponding file. Confirm the write to the GTME before moving on.
4. **Resumable.** At session start, read all `clients/{slug}/*.md` files. Identify which sections are filled and which still have `{{PLACEHOLDER}}` or blank values. Resume from the first unfilled phase. (Never edit root `CLAUDE.md` - it is the shared, client-agnostic hub.)
5. **Never invent data.** If the GTME does not know an answer, mark it `{{TO CONFIRM}}` and add to the final completeness report.
6. **Use British spelling by default**, override if client is US-based and prefers American.

---

## STARTUP - Detect Current State

Before asking the first question (after STEP 0 has created/resolved the folder):

1. Read each `clients/{slug}/*.md` file. Check which sections are filled vs still `{{PLACEHOLDER}}`/blank.
2. Output a state report:

```
Client Setup State - {{slug}} - {{date}}
- clients/{slug}/overview.md: [filled / partial / blank]
- clients/{slug}/icp.md: [filled / partial / blank]
- clients/{slug}/offer.md: [filled / partial / blank]
- clients/{slug}/voice.md: [filled / partial / blank]
- clients/{slug}/campaign-state.md: [filled / partial / blank]

Resuming from: Phase {{n}} - {{phase_name}}
```

If everything is blank → start at Phase 1.
If some phases are complete → resume at the first incomplete one and offer to skip ahead.

---

## PHASE 1 - Identity (5 minutes)

**Target files:** `clients/{slug}/overview.md` + `clients/{slug}/_config.md`

Ask in this order:

1. What is the client's company name?
2. What is their website?
3. What industry are they in?
4. Where are they HQ'd? Which markets do they sell into primarily?
5. How would you describe what they do in 2-3 sentences?
6. Who is the primary contact? Name, title, email.
7. Are there other key contacts I should know about?
8. Why did they hire Instantly.ai? What were they doing before?
9. Who is the assigned Account Manager (AM) for this client? This is who future billing/domain/refund
   escalations tag, per `sops/am-gtme-responsibility-split.md`.
10. Anything else relevant - quirks, sensitivities, preferences, things they care about beyond metrics?

**Do not chase contract terms (start date, monthly send target, reporting day, renewal date) during
onboarding.** Per standing GTME preference (confirmed 2026-07-10) these are not tracked as part of this
skill - leave the corresponding `_config.md`/`overview.md` fields out or marked not tracked rather than
asking the GTME to chase them from the AM. `service_type`/`tier` can still be
recorded if the GTME already knows it (e.g. from a pre-call brief) - just don't treat it as a required,
must-confirm field.

**After Phase 1:**
- Write `clients/{slug}/overview.md` with all answers
- Fill `clients/{slug}/_config.md` Identity block: `slug`, `client_name`, `tier` (if known), `industry`, `website`, `geography`, `primary_contact_name`, `primary_contact_email`, `assigned_am`; set `template_version` from the repo root `VERSION`
- Do **not** touch root `CLAUDE.md` or `INDEX.md` - they are shared and client-agnostic
- Confirm to the GTME: "Phase 1 complete. Identity locked in. Ready for Phase 2 - Offer?"

---

## PHASE 2 - Offer (30-40 minutes)

**Target file:** `clients/{slug}/offer.md`

**This is the most important phase.** Per `CLAUDE.md` Core Principles, the offer is the highest-leverage
lever a client has - it improves every downstream metric at once (reply rate, show-up rate, close rate)
for a one-time input of effort. Do not shortcut this into a quick one-liner. Read `wiki/offer-framework.md`
(the 9-step worksheet) before starting this phase - if any step below feels arbitrary, the reasoning is in
`wiki/offer-creation-theory.md`.

Run the 9 steps below in order. Each step ends with a **Conclusion** the GTME confirms before moving on -
write it to the matching section of `offer.md` as you go, don't wait until the end of the phase.

### Step 2.1 - Who (niche psychology)

Not firmographics (that's Phase 3 / `icp.md`) - the psychology driving this specific prospect.

1. Which niche are you in, and what specific problem does this client solve for them?
2. What are the goals of someone facing this problem? What are the consequences of not solving it?
3. What have they tried before to solve it? Why did that fall short?
4. What is their current situation? What is their desired situation? (This gap is what the offer bridges.)
5. What do they truly want, in their heart of hearts? What do they believe or think?
6. What do you know to be true about their day-to-day that we can use in messaging?

**Conclusion:** one-paragraph summary of who this is for and what's driving them → `Who This Is For`.

### Step 2.2 - Outcome

7. **Big claim:** what specific, measurable outcome do they deliver? What's the bold claim?
8. How is this made tangible with numbers? Where will the prospect be, and how will they feel, once solved?
9. Why does this outcome matter to them? What does it unlock?

**Conclusion:** the outcome in one sentence, with a specific number attached → `The Outcome Promise`.

### Step 2.3 - Timeframe

10. What's a realistic timeframe to achieve the outcome? Why does it take this long?
11. Could it be shorter - honestly?

**Conclusion:** state the timeframe → `Timeframe`.

### Step 2.4 - Methodology

12. What are the core components of the product? List every step needed to achieve the outcome, in order.
13. Which steps are most important? Which are least important - can those be cut and still deliver the outcome?
14. Rewrite the trimmed list so each step is 6-9 words max. Could a 10-year-old follow it?

**Conclusion:** the trimmed, simplified step list → `Methodology`.

### Step 2.5 - Factors of Value

For each methodology step: what objection, obstacle, or doubt would a sceptical prospect raise? Invert
each one into a proof point (a factor of value) stated simply.

15. Walk through each methodology step and surface the objection, then the inversion.

**Conclusion:** objection → factor-of-value table → `Factors of Value`.

### Step 2.6 - Risk Reversal / Guarantee

16. Do you guarantee the outcome if the methodology is followed? If not, why not - that usually means a
    factor of value is still missing from Step 2.5.
17. If yes: refund? Work for free if it fails? Performance-basis pay? An apology offer? How are incentives
    aligned so you're motivated to make it actually work?
18. State the guarantee boldly, then give it a name (e.g. "No Win No Fee Guarantee").

**Conclusion:** the guarantee, stated and named → `Risk Reversal & Guarantee`.

### Step 2.7 - Polarise

19. Who can't this client help? Who is the outcome not for? What mindset disqualifies someone?

**Conclusion:** the exclusion list → `Polarisation`.

### Step 2.8 - Ultimatum

20. Best case if a prospect takes the offer? Worst case - and why even the worst case isn't that bad?

**Conclusion:** best case / worst case → `Ultimatum`.

### Step 2.9 - Supporting proof and copy assets

21. **Case studies:** name 3 real case studies - client name, specific result, timeframe. Push back if vague.
22. **Aggregate stats:** portfolio-wide numbers? ("92% of clients see X within Y days")
23. **Approved client logos:** which named logos are approved for use in copy?
24. **Differentiators:** what makes this offer different from every other option the prospect has? Give 3.
25. **3 value props:** for each - make money, save time, save money - what is this client's specific angle?
26. **CTA options:** 3 CTA variations across the sequence (soft / medium / hail-mary).

**Conclusion:** → `Proof Points`, `Key Differentiators`, `The 3 Value Props`, `CTA Options`.

### Step 2.10 - Packaging (Step 9 of the worksheet)

27. Stripped to bare bones, what is actually being sold? (This answer usually sounds like every competitor.)
28. How do you make that sound aligned with what the prospect truly wants, in as few words as possible?
29. How are they positioned against the market - what category do they own?

**Conclusion:** the packaged positioning → `Packaging & Positioning`.

### Step 2.11 - Synthesise the one-liner

30. Combine the above into the offer's one-line summary: [outcome] for [ICP] in [timeframe] - [risk
    reversal / guarantee] → `The Offer in One Line`.
31. **What they sell:** product/service name, category, delivery model, pricing range → `What They Sell`.

**Push back if answers are vague at any step.** Specifics beat clichés. "Significant cost savings" is not
approved - "40-70% cost saving vs local US hires" is.

**After Phase 2:**
- Write `clients/{slug}/offer.md` in full (all sections above should already be filled step by step)
- Confirm: "Phase 2 complete. Offer built through the full 9-step worksheet. Ready for Phase 3 - ICP?"

---

## PHASE 3 - ICP (15 minutes)

**Target file:** `clients/{slug}/icp.md`

Read `wiki/list-building.md` before starting - apply the 3-layer framework.

Ask in this order:

### Firmographic
1. Company type - what kind of companies (SaaS, services, ecommerce, B2B, B2C)?
2. Company size - sweet spot for employees AND revenue?
3. Industries - specific verticals (not "all of tech")?
4. Geography - countries and cities?
5. Funding stage if relevant (seed, Series A-C, PE, public)?

### Behavioural / signals
6. What changes in the prospect's world right before they buy? (This is the signal.)
7. Cross-reference with `wiki/signal-sourcing.md` - propose 2-3 ranked signals.
8. For each proposed signal: does it apply? Push back if the GTME picks signals that do not match the offer.

### Decision makers
9. Which titles do we target? Rank them.
10. For each priority title, what are they measured on? What is their pain? (Apply ATL/BTL register from `wiki/atl-btl-messaging.md`.)

### Avoid list
11. Which companies, sectors, or titles should we exclude?
12. Are there any specific bad-fit signals (e.g. "if they have a Head of Outbound already, exclude")?

### Filters
13. Output a ready-to-use lead filter spec (size, industry, title include/exclude, geography, funding, tech).

**After Phase 3:**
- Write `clients/{slug}/icp.md`
- Confirm: "Phase 3 complete. ICP defined and signals ranked. Ready for Phase 4 - Voice?"

---

## PHASE 4 - Voice (10 minutes)

**Target file:** `clients/{slug}/voice.md`

Ask in this order:

1. **Tone:** in 3 words, how would the client describe their brand voice?
2. **Personality:** how should they come across in cold outreach - direct, warm, technical, casual, expert?
3. **Avoid:** what tone does NOT fit? (Corporate? Aggressive? Salesy?)
4. **Spelling default:** British or American? (Default British unless client is US-based.)
5. **Words to use:** any specific words, phrases, or terms the client likes?
6. **Words to avoid:** which words or phrases are banned? (Their brand guidelines may have a list.)
7. **Approved claims:** which specific claims has the client approved for use in copy? List them - only these can be used without checking.
8. **Good example:** paste an email, headline, or piece of copy the client likes that represents the voice.
9. **Bad example:** paste something that does NOT fit - and explain why.
10. **Industry vernacular:** any sector-specific language we should use or avoid? (FinTech says "rails", HR says "people ops", etc.)
11. **Anything else** about the voice - founder preferences, emoji rules, signature conventions.

**After Phase 4:**
- Write `clients/{slug}/voice.md`
- Confirm: "Phase 4 complete. Voice locked in. Ready for Phase 5 - Infrastructure?"

---

## PHASE 5 - Infrastructure (5 minutes)

**Target file:** `clients/{slug}/campaign-state.md`

The AM provisions mailboxes, domains, and warmup on a separate parallel track
(`sops/am-gtme-responsibility-split.md`, `sops/daily-structure.md`). This phase records the resulting state
for campaign-building purposes, it isn't GTME setting infrastructure up.

Ask in this order:

1. **Instantly workspace:** URL or name of the workspace. Do you have this client's API key ready? (Stored in `secrets/credentials.md`; the OS calls the API directly - see `sops/instantly-api.md`.)
2. **Sending domains:** how many, what are they, are they warmed?
3. **Mailboxes:** how many per domain? Already provisioned?
4. **Warmup status:** all warmed / some warming / not started?
5. **Daily send capacity:** total cold sends per day across all mailboxes once at steady state?
6. **LinkedIn:** any LinkedIn accounts to be used? (Note - current OS has limited LinkedIn skill depth. Flag if multichannel.)
7. **Tracking:** custom tracking domain configured per sending domain?
8. **First campaign:** what is the first signal / sequence to be launched?

**After Phase 5:**
- Seed `clients/{slug}/campaign-state.md` with infrastructure detail
- Write the Instantly workspace URL/ID and `instantly_api_configured` into `clients/{slug}/_config.md`
- Write the Instantly **API key** into `clients/{slug}/secrets/credentials.md` only (git-ignored) - never into `_config.md` or any committed file. Never print the full key in chat.
- **Once the key is in place, check for a pre-existing workspace before assuming this is a blank slate.**
  `GET /campaigns` (read, runs automatically). If any campaigns already exist - this is a handover or an
  already-live account, not a true net-new signing - pull `GET /campaigns/analytics`, `GET /accounts`
  (mailboxes/warmup), and `GET /campaigns/analytics/steps` for each, and seed `campaign-state.md` with the
  *real* current state (sends, replies, bounce rate, health) instead of leaving it blank. Read the actual
  live sequence copy too (it's needed context for any future diagnosis or rewrite). Note in
  `overview.md` Context Notes and `decision-log.md` that this is an existing account, not a fresh start -
  a GTME handover (`sops/client-handover.md`) may also be in play and worth surfacing to the GTME to confirm.
  (Added 2026-07-13 after an onboarding revealed a live campaign only once the API key was loaded -
  Phase 5's original "leave metrics blank" instruction assumed net-new every time.)
- If no campaigns exist yet, leave campaign performance metrics blank - populate after first campaign runs
- Confirm: "Phase 5 complete. Infrastructure captured."

---

## COMPLETENESS REPORT

After all phases, run a final check:

1. Verify NO `{{PLACEHOLDER}}` values remain in the 6 files this skill actually writes -
   `_config.md`, `overview.md`, `offer.md`, `icp.md`, `voice.md`, `campaign-state.md`. Every other file
   under `clients/{slug}/` (`decision-log.md`, `copy-library.md`, `test-log.md`, `MEMORY.md`,
   `comms-log.md`, `competitive-intel.md`, `session-log.md`) intentionally keeps its placeholder rows
   until real entries accrue over time - do not flag those.
2. Verify no `{{TO CONFIRM}}` entries remain in those same 6 files - or list them as outstanding
3. Verify those same 6 files have non-empty content in every section
4. Verify `_state/active-client` points to this slug, and `clients/{slug}/secrets/credentials.md` exists (git-ignored, renamed from `credentials.template.md` per STEP 0.3 - confirm the template file no longer exists alongside it)

Output:

```
=== Onboarding Complete: {{client_name}} ({{slug}}) ===

Files created / updated:
- clients/{slug}/_config.md (identity + Instantly filled)
- clients/{slug}/secrets/credentials.md (API key - local only, git-ignored)
- clients/{slug}/overview.md (filled)
- clients/{slug}/icp.md (filled)
- clients/{slug}/offer.md (filled)
- clients/{slug}/voice.md (filled)
- clients/{slug}/campaign-state.md (infrastructure seeded)

Outstanding items to resolve before first campaign:
- [list any {{TO CONFIRM}} entries]
- [list any "TBD" or partial answers]

Ready to:
- Source leads (run list-builder skill)
- Design signal strategy (run signal-sourcer skill)
- Write first sequence (run cold-email-writer skill)

Suggested next step: "Build the first lead list for {{client_name}}"
```

---

## CONVERSATIONAL RULES

- **One question at a time.** Default mode.
- **If the GTME says "batch the rest"** - ask all remaining questions in the current phase together.
- **If the GTME says "I don't know yet"** - mark as `{{TO CONFIRM}}` and move on. Do not stall.
- **If the GTME pastes a brief or call notes** - extract answers from it, then ask only what is missing.
- **Push back on vague answers.** Specificity is the whole point. "Faster hiring" is not an outcome. "92% of roles filled in 21 days" is.
- **No corporate filler in your questions.** Direct, concise, no fluff.
- **At the end of each phase** - write the file, confirm, and ask permission to proceed.

---

## EXAMPLES

### Example startup
```
GTME: Run client onboarder for {{CLIENT_NAME}}

Claude:
Created clients/{slug}/ from templates/client-template/. Active client: {{CLIENT_NAME}}.

Client Setup State - {{slug}} - 2026-05-29
- clients/{slug}/overview.md: blank
- clients/{slug}/icp.md: blank
- clients/{slug}/offer.md: blank
- clients/{slug}/voice.md: blank
- clients/{slug}/campaign-state.md: blank

Starting Phase 1 - Identity.

Question 1 of 10: What is the client's company name?
```

### Example pushback
```
GTME: They help startups hire engineers faster.

Claude:
"Faster" needs a number to land in cold copy. Two options:
- Specific timeframe: "within 21 days" / "within 72 hours"
- Comparative: "3x faster than in-house" / "50% faster than agencies"

Which one fits {{CLIENT_NAME}}? Or do you have a specific stat?
```

### Example resume
```
GTME: Continue onboarding {{CLIENT_NAME}}.

Claude:
OS State Report - 2026-06-02
- Phase 1 (Identity): complete
- Phase 2 (Offer): complete
- Phase 3 (ICP): partial - firmographics done, signals not yet defined
- Phase 4 (Voice): blank
- Phase 5 (Infrastructure): blank

Resuming Phase 3 from signal definition.

Question 6 of 13: What changes in the prospect's world right before they buy?
```