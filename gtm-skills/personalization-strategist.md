# Skill: Personalization Strategist

**Trigger:** "Personalise at scale", "write personalisation prompts", "build a Clay prompt", "what should we personalise on", "personalisation hooks", "this email feels too generic", "research the prospect"

**Context:** Personalisation is the difference between finishing near the bottom and near the top of the PRR
scale in `sops/campaign-performance-standards.md`. Over-personalisation kills scale. This skill picks the
right tier of personalisation, sources the right data bucket, and writes the prompts.

---

## STANDARD CONTEXT

Read `wiki/_skill-context.md` for the standard files every skill loads. Then add the skill-specific reads below.

## SKILL-SPECIFIC READS

**MUST READ (every time):**
- `wiki/personalization-at-scale.md` - 6 buckets, hook types, playbooks by category, 6 AI prompts
- `clients/{slug}/icp.md` - to know who is being personalised to
- `clients/{slug}/offer.md` - to know what the personalisation should connect to

**READ IF CONDITION:**
- `wiki/atl-btl-messaging.md` - if register-appropriate personalisation needs deciding

---

## ROUTING TABLE

| Request | Route to |
|---------|----------|
| "Should I personalise this campaign?" | Decision matrix (Step 1) |
| "What data should I pull?" | Bucket selection (Step 2) |
| "Write me a Clay prompt for X" | AI prompt library in `wiki/personalization-at-scale.md` |
| "This first line feels generic" | Hook upgrade (Strong vs Lite) |
| "Build an automated personalisation play" | Advanced plays section |

---

## STEP 0 - Log Invocation (mandatory)

Before any other step, append one row to `clients/{slug}/session-log.md` Active Log table:

```
| YYYY-MM-DD HH:MM | {{paraphrased prompt summary, ~60 chars}} | {{this skill name}} | (filled at end) |
```

Rules (per `wiki/_skill-context.md` "Session-Log Write"):
- Write at START, not end - captures the attempt even if the skill fails mid-execution
- Paraphrase the prompt - no raw prospect names, emails, or sensitive data
- Skill name only (no path)
- Outcome column filled at end of execution (e.g. "Drafted Email 1 + 2 follow-ups", "Diagnosed: deliverability issue", "Pattern detected: diagnose-campaign-performance")

Without this row, `gtm-skills/pattern-detector.md` cannot find repeating prompts and the auto-improvement loop breaks.

---

## STEP 1 - Should We Personalise?

Decision matrix from `wiki/personalization-at-scale.md`:

| Factor | Personalise | Skip |
|--------|-------------|------|
| Deal size | Over $25K ACV | Under $25K ACV |
| Volume | Under 50/day | Over 100/day |
| ICP fit | Tier 1 | Tier 2-3 |
| Signal strength | Weak signals | Strong signals (signal does the work) |
| Competitive | High competition | Low competition |

If skipping personalisation: use **No Personalisation Playbook** in `wiki/personalization-at-scale.md`.

---

## STEP 2 - Pick the Bucket

Read the 6 buckets in `wiki/personalization-at-scale.md`. Choose by:

1. **What data is reliably available?** (Bucket 6 - company level - scales infinitely)
2. **What is most valuable for this persona?** (Bucket 1 - self-authored content - for thought-leader prospects)
3. **What will not feel creepy?** (Avoid Bucket 4 - junk drawer - unless rapport is the entire goal)

Default order to try: **Bucket 6 → Bucket 3 → Bucket 1 → Bucket 2 → Bucket 5 → Bucket 4**.

---

## STEP 3 - Strong Hook or Lite Hook?

| Situation | Hook | Effort |
|-----------|------|--------|
| Enterprise $100K+ deal | Strong | High |
| Mid-market $25-100K | Either | Medium |
| SMB / volume | Lite | Low |
| Champion already exists | Lite | Low |
| Competitive displacement | Strong | High |

---

## STEP 4 - Write the Prompt

Use the 6 ready-to-deploy AI prompts in `wiki/personalization-at-scale.md`:

1. ICP identification
2. Short company description
3. Similar product / service
4. Top 3 problems
5. Subject line (2 words)
6. Strong hook from LinkedIn post

For custom prompts, follow the structure:
- One specific output, never a whole email
- Clear formatting rules
- Output must fit grammatically in the surrounding sentence
- Source attribution where possible ("According to SimilarWeb...")

---

## RULES

- **Use AI for ONE part of the email, not the whole thing.** Control the structure with static text. Inject AI output into specific slots.
- **Never use generic AI compliments** ("Love your work!", "Impressive growth!"). They are obvious and lose trust.
- **Cite sources** when using data ("According to SimilarWeb, you get 50K visitors a month"). If the data is wrong, the source takes the blame.
- **Do not reference the signal directly.** "I saw you raised your Series A" reads like every other email. Reference the implication.
- **Test personalisation vs no personalisation as A/B** before assuming personalisation wins. At high volume, no-personalisation often wins on ROI.

---

## QA CHECKLIST

Before handing off the prompt or hook:

- [ ] Uses AI for exactly one component, not the whole email?
- [ ] No generic AI compliments ("Love your work!", "Impressive growth!")?
- [ ] Does not reference the signal directly (implication only)?
- [ ] Sourced where it cites data ("According to SimilarWeb...")?
- [ ] Bucket 4 (junk drawer) used only if rapport-building is the explicit goal?
- [ ] Hook tier (Strong/Lite) matches the deal-size table in Step 3?