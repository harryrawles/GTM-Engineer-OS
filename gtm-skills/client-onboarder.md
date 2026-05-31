# Skill: Client Onboarder

**Trigger:** "Onboard new client", "Set up the OS for {{client}}", "Let's fill in the OS", "Run client onboarder", "New client just signed", "Onboard {{client_name}}"

**Context:** This skill runs the full conversational onboarding flow for a freshly cloned client OS. It asks Harry questions phase by phase, writes the answers directly to the right files, and verifies the OS is ready to launch.

**The conversation IS the intake.** Harry should not fill the intake form manually. This skill replaces that workflow.

---

## STEP 0 — Log Invocation (mandatory)

Before any other step, append one row to `company/session-log.md` Active Log table:

```
| YYYY-MM-DD HH:MM | {{paraphrased prompt summary, ~60 chars}} | {{this skill name}} | (filled at end) |
```

Rules (per `wiki/_skill-context.md` "Session-Log Write"):
- Write at START, not end — captures the attempt even if the skill fails mid-execution
- Paraphrase the prompt — no raw prospect names, emails, or sensitive data
- Skill name only (no path)
- Outcome column filled at end of execution

Without this row, `gtm-skills/pattern-detector.md` cannot find repeating prompts and the auto-improvement loop breaks.

---

## RULES (read first)

1. **Run in 5 phases.** Do not jump ahead. Each phase has a clear write target.
2. **Ask one question at a time.** Wait for the answer. Do not batch unless Harry says "batch the rest."
3. **Write files as you go.** After each phase, write to the corresponding file. Confirm the write to Harry before moving on.
4. **Resumable.** At session start, read all `company/*.md` and `CLAUDE.md` files. Identify which sections are filled and which still have `{{PLACEHOLDER}}` or blank values. Resume from the first unfilled phase.
5. **Never invent data.** If Harry does not know an answer, mark it `{{TO CONFIRM}}` and add to the final completeness report.
6. **Use British spelling by default**, override if client is US-based and prefers American.

---

## STARTUP — Detect Current State

Before asking the first question:

1. Read `CLAUDE.md`. Check how many `{{PLACEHOLDER}}` values remain.
2. Read each `company/*.md` file. Check which sections are filled.
3. Output a state report:

```
OS State Report — {{date}}
- CLAUDE.md: {{n}} placeholders remaining
- company/overview.md: [filled / partial / blank]
- company/icp.md: [filled / partial / blank]
- company/offer.md: [filled / partial / blank]
- company/voice.md: [filled / partial / blank]
- company/campaign-state.md: [filled / partial / blank]

Resuming from: Phase {{n}} — {{phase_name}}
```

If everything is blank → start at Phase 1.
If some phases are complete → resume at the first incomplete one and offer to skip ahead.

---

## PHASE 1 — Identity (5 minutes)

**Target files:** `CLAUDE.md` (placeholder replacement) + `company/overview.md`

Ask in this order:

1. What is the client's company name?
2. What is their website?
3. What industry are they in?
4. Where are they HQ'd? Which markets do they sell into primarily?
5. How would you describe what they do in 2-3 sentences?
6. Who is the primary contact? Name, title, email.
7. Are there other key contacts I should know about?
8. Why did they hire Instantly.ai? What were they doing before?
9. What service are they on (DFY / DWY / Instantly-managed retainer / other)? Start date? Monthly send target? Which day of the week is the report due?
10. Anything else relevant — quirks, sensitivities, preferences, things they care about beyond metrics?

**After Phase 1:**
- Write `company/overview.md` with all answers
- Update `CLAUDE.md` placeholders: `{{CLIENT_NAME}}`, `{{INDUSTRY}}`, `{{ONE_LINE_DESCRIPTION}}`, `{{GEOGRAPHY}}`, `{{REASON_FOR_HIRING}}`, contact rows
- Update `INDEX.md`: replace `{{CLIENT_NAME}}` in headers
- Confirm to Harry: "Phase 1 complete. Identity locked in. Ready for Phase 2 — Offer?"

---

## PHASE 2 — Offer (15 minutes)

**Target file:** `company/offer.md`

Ask in this order:

1. **One-line offer:** Can you write the offer as a single sentence — [outcome] for [ICP] in [timeframe] — [risk reversal / guarantee]?
2. **What they sell:** product/service name, category, delivery model, pricing range
3. **Big claim:** what specific, measurable outcome do they deliver?
4. **Timeframe:** how long does it take to get the result?
5. **Guarantee / risk reversal:** what happens if it does not work?
6. **Case studies:** name 3 real case studies — client name, specific result, timeframe. Push back if vague.
7. **Aggregate stats:** are there portfolio-wide numbers we can use? ("92% of clients see X within Y days")
8. **Approved client logos:** which named logos are approved for use in copy?
9. **Differentiators:** what makes this offer different from every other option the prospect has? Give me 3.
10. **3 value props:** for each — make money, save time, save money — what is this client's specific angle?
11. **CTA options:** give me 3 CTA variations across the sequence (soft / medium / hail-mary).
12. **Positioning:** how are they positioned against alternatives? Who are they NOT for?

**Push back if answers are vague.** Specifics beat clichés. "Significant cost savings" is not approved — "40-70% cost saving vs local US hires" is.

**After Phase 2:**
- Write `company/offer.md`
- Confirm: "Phase 2 complete. Offer captured. Ready for Phase 3 — ICP?"

---

## PHASE 3 — ICP (15 minutes)

**Target file:** `company/icp.md`

Read `wiki/list-building.md` before starting — apply the 3-layer framework.

Ask in this order:

### Firmographic
1. Company type — what kind of companies (SaaS, services, ecommerce, B2B, B2C)?
2. Company size — sweet spot for employees AND revenue?
3. Industries — specific verticals (not "all of tech")?
4. Geography — countries and cities?
5. Funding stage if relevant (seed, Series A-C, PE, public)?

### Behavioural / signals
6. What changes in the prospect's world right before they buy? (This is the signal.)
7. Cross-reference with `wiki/signal-sourcing.md` — propose 2-3 ranked signals.
8. For each proposed signal: does it apply? Push back if Harry picks signals that do not match the offer.

### Decision makers
9. Which titles do we target? Rank them.
10. For each priority title, what are they measured on? What is their pain? (Apply ATL/BTL register from `wiki/atl-btl-messaging.md`.)

### Avoid list
11. Which companies, sectors, or titles should we exclude?
12. Are there any specific bad-fit signals (e.g. "if they have a Head of Outbound already, exclude")?

### Filters
13. Output a ready-to-use lead filter spec (size, industry, title include/exclude, geography, funding, tech).

**After Phase 3:**
- Write `company/icp.md`
- Confirm: "Phase 3 complete. ICP defined and signals ranked. Ready for Phase 4 — Voice?"

---

## PHASE 4 — Voice (10 minutes)

**Target file:** `company/voice.md`

Ask in this order:

1. **Tone:** in 3 words, how would the client describe their brand voice?
2. **Personality:** how should they come across in cold outreach — direct, warm, technical, casual, expert?
3. **Avoid:** what tone does NOT fit? (Corporate? Aggressive? Salesy?)
4. **Spelling default:** British or American? (Default British unless client is US-based.)
5. **Words to use:** any specific words, phrases, or terms the client likes?
6. **Words to avoid:** which words or phrases are banned? (Their brand guidelines may have a list.)
7. **Approved claims:** which specific claims has the client approved for use in copy? List them — only these can be used without checking.
8. **Good example:** paste an email, headline, or piece of copy the client likes that represents the voice.
9. **Bad example:** paste something that does NOT fit — and explain why.
10. **Industry vernacular:** any sector-specific language we should use or avoid? (FinTech says "rails", HR says "people ops", etc.)
11. **Anything else** about the voice — founder preferences, emoji rules, signature conventions.

**After Phase 4:**
- Write `company/voice.md`
- Confirm: "Phase 4 complete. Voice locked in. Ready for Phase 5 — Infrastructure?"

---

## PHASE 5 — Infrastructure (5 minutes)

**Target file:** `company/campaign-state.md`

Ask in this order:

1. **Instantly workspace:** URL or name of the workspace. Are you connected via MCP?
2. **Sending domains:** how many, what are they, are they warmed?
3. **Mailboxes:** how many per domain? Already provisioned?
4. **Warmup status:** all warmed / some warming / not started?
5. **Daily send capacity:** total cold sends per day across all mailboxes once at steady state?
6. **LinkedIn:** any LinkedIn accounts to be used? (Note — current OS has limited LinkedIn skill depth. Flag if multichannel.)
7. **Tracking:** custom tracking domain configured per sending domain?
8. **First campaign:** what is the first signal / sequence to be launched?

**After Phase 5:**
- Seed `company/campaign-state.md` with infrastructure detail
- Leave campaign performance metrics blank — populate after first campaign runs
- Confirm: "Phase 5 complete. Infrastructure captured."

---

## COMPLETENESS REPORT

After all phases, run a final check:

1. Verify NO `{{PLACEHOLDER}}` values remain in CLAUDE.md or any company/*.md file
2. Verify no `{{TO CONFIRM}}` entries remain — or list them as outstanding
3. Verify all 5 company/*.md files have non-empty content in every section

Output:

```
=== Onboarding Complete: {{client_name}} ===

Files updated:
- CLAUDE.md (placeholders replaced)
- INDEX.md (client name set)
- company/overview.md (filled)
- company/icp.md (filled)
- company/offer.md (filled)
- company/voice.md (filled)
- company/campaign-state.md (infrastructure seeded)

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
- **If Harry says "batch the rest"** — ask all remaining questions in the current phase together.
- **If Harry says "I don't know yet"** — mark as `{{TO CONFIRM}}` and move on. Do not stall.
- **If Harry pastes a brief or call notes** — extract answers from it, then ask only what is missing.
- **Push back on vague answers.** Specificity is the whole point. "Faster hiring" is not an outcome. "92% of roles filled in 21 days" is.
- **No corporate filler in your questions.** Direct, concise, no fluff.
- **At the end of each phase** — write the file, confirm, and ask permission to proceed.

---

## EXAMPLES

### Example startup
```
Harry: Run client onboarder for {{CLIENT_NAME}}

Claude:
OS State Report — 2026-05-29
- CLAUDE.md: 8 placeholders remaining
- company/overview.md: blank
- company/icp.md: blank
- company/offer.md: blank
- company/voice.md: blank
- company/campaign-state.md: blank

Starting Phase 1 — Identity.

Question 1 of 10: What is the client's company name?
```

### Example pushback
```
Harry: They help startups hire engineers faster.

Claude:
"Faster" needs a number to land in cold copy. Two options:
- Specific timeframe: "within 21 days" / "within 72 hours"
- Comparative: "3x faster than in-house" / "50% faster than agencies"

Which one fits {{CLIENT_NAME}}? Or do you have a specific stat?
```

### Example resume
```
Harry: Continue onboarding {{CLIENT_NAME}}.

Claude:
OS State Report — 2026-06-02
- Phase 1 (Identity): complete
- Phase 2 (Offer): complete
- Phase 3 (ICP): partial — firmographics done, signals not yet defined
- Phase 4 (Voice): blank
- Phase 5 (Infrastructure): blank

Resuming Phase 3 from signal definition.

Question 6 of 13: What changes in the prospect's world right before they buy?
```