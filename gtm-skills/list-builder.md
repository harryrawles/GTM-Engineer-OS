---
name: list-builder
description: Handles ICP scoring, account qualification, ABM tier assignment, contact mapping, list validation/hygiene, and re-auditing an active list against the current ICP when list quality is suspected as an underperformance root cause.
triggers:
  - "Build a lead list"
  - "qualify these accounts"
  - "score this list"
  - "build an ABM target list"
  - "clean the list"
  - "verify emails"
  - "look-alike list"
  - "find more accounts like X"
reads:
  - "wiki/_skill-context.md"
  - "wiki/list-building.md, signal-sourcing.md"
  - "clients/{slug}/icp.md, offer.md"
writes:
  - "clients/{slug}/icp.md (Step 1 output, if adopted)"
---

# Skill: List Builder

**Trigger:** "Build a lead list", "qualify these accounts", "score this list", "build an ABM target list", "clean the list", "verify emails", "look-alike list", "find more accounts like X"

**Context:** Lead quality is upstream of every metric. A bad list means even perfect copy fails. This skill handles ICP definition, account qualification, ABM tier assignment, contact mapping, and list hygiene.

---

## STANDARD CONTEXT

Read `wiki/_skill-context.md` for the standard files every skill loads. Then add the skill-specific reads below.

## SKILL-SPECIFIC READS

**MUST READ (every time):**
- `wiki/list-building.md` - full methodology: ICP framework, scoring, ABM tiers, contact mapping, hygiene
- `wiki/signal-sourcing.md` - for intent data layering during qualification
- `clients/{slug}/icp.md` - current client ICP
- `clients/{slug}/offer.md` - to ensure ICP matches what is being sold

---

## ROUTING TABLE

| Request | Route to |
|---------|----------|
| "Define ICP for a new client" | Step 1 - ICP Framework |
| "Score 500 accounts" | Step 2 - Account qualification |
| "Build an ABM list for Tier 1" | Step 3 - ABM tier assignment |
| "Map contacts at these accounts" | Step 4 - Contact mapping |
| "Build a lookalike list from best customers" | Lookalike building section in `wiki/list-building.md` |
| "Verify these emails / clean the list" | Step 5 - Validation |
| "Audit this list against ICP" / invoked by `gtm-skills/chain-diagnose-campaign.md` when list quality is the suspected root cause | Step 6 - Audit Mode |

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

## STEP 1 - Define the ICP

Use the 3-layer framework from `wiki/list-building.md`:

1. **Firmographic** - industry, size, revenue, geography, growth rate, funding stage
2. **Technographic** - tech stack, CRM, marketing automation, competitive tools
3. **Behavioural / intent** - job postings, funding events, leadership changes, content engagement, website visits

Output: structured ICP that can populate `clients/{slug}/icp.md`.

---

## STEP 2 - Score Accounts (100-point system)

Apply the scoring matrix from `wiki/list-building.md`:

| Criterion | Weight |
|-----------|--------|
| Industry match | 20 |
| Company size | 15 |
| Revenue range | 15 |
| Geography | 10 |
| Technology fit | 15 |
| Growth signals | 10 |
| Intent signals | 15 |

Output: a sortable list with score per account. Sort by score, then assign tier.

---

## STEP 3 - Assign ABM Tier

| Score | ICP Tier | ABM Tier | Approach |
|-------|---------|----------|----------|
| 90-100 | A | Tier 1 (1:1) | Fully custom, multi-threaded. 10-50 accounts. |
| 70-89 | B | Tier 2 (1:Few) | Segment-based personalisation. 50-200 accounts. |
| 50-69 | C | Tier 3 (1:Many) | Programmatic, automated. 200-1,000 accounts. |
| Under 50 | D | Exclude | Inbound-only. |

**Layer intent data** to adjust scores dynamically. Strong 1st-party intent = +10-20 points. 2nd / 3rd party = +5-10.

---

## STEP 4 - Contact Mapping

For Tier 1: map all 6 roles per account.
For Tier 2: 3-4 roles.
For Tier 3: decision-maker only.

| Role | Typical titles | Purpose |
|------|---------------|---------|
| Economic buyer | CEO, CFO, VP | Final budget approval |
| Champion | Director, Head of | Internal advocate |
| Technical evaluator | Manager, Architect | Technical fit |
| End user | Analyst, Specialist | Daily product user |
| Blocker | Legal, Compliance | Can slow or stop deal |
| Coach | Any level | Insider information |

---

## STEP 5 - Validate Before Sending

Run before every campaign. Non-negotiable.

1. **Email verification** on 100% of list (ZeroBounce, NeverBounce, Findymail, MillionVerifier)
2. **Remove** invalid, unknown, disposable, role-based, toxic
3. **Sub-verify** catch-all with ListKit / Listman.io
4. **Re-verify** anything older than 30 days
5. **Target:** bounce rate under 2% (the healthy target, `wiki/deliverability.md`)

---

## STEP 6 - Audit Mode (Re-Verify an Active List Against ICP)

Different from Step 5 (email validity/hygiene). This re-scores an *already-sending* list against the
*current* ICP, to answer "has this list drifted, or has the ICP moved since the list was built." Triggered
directly, or by `gtm-skills/chain-diagnose-campaign.md` when campaign-optimiser's diagnosis points to list
quality as the underperformance root cause.

1. Pull the active lead list for the campaign in question.
2. Re-score every lead against the current `clients/{slug}/icp.md` using the Step 2 scoring matrix.
3. Calculate:
   - **% still in-ICP** - leads still scoring Tier A/B (70+) under the current ICP
   - **False positives** - count and % of leads that scored well when the list was built but no longer
     match (ICP refined since, firmographic drift, stale data)
   - **Driving criteria** - which specific scoring factors (industry, size, geography, etc.) account for
     most of the mismatch
4. Recommend one of:
   - **Refresh** - rebuild the list if in-ICP match has dropped below 50%
   - **Tighten ICP** - if the list matches an ICP that has since become too broad, fix `clients/{slug}/icp.md`
     rather than just refreshing the list
   - **Both** - if the list is stale and the ICP has also drifted

Output:
```
=== List Audit - {{campaign_name}} ===

Leads audited: {{n}}
Still in-ICP: {{n}} ({{%}})
False positives: {{n}} ({{%}}) - driven by: {{criteria}}

Recommendation: Refresh / Tighten ICP / Both
{{one-line reasoning}}
```

---

## QA CHECKLIST

Before handing off the list:

- [ ] Every account/lead scored against the current `clients/{slug}/icp.md`, not a stale or assumed ICP?
- [ ] ABM tier and contact-mapping depth match the Step 3 score bands (6 roles Tier 1, 3-4 Tier 2, decision-maker only Tier 3)?
- [ ] Step 5 validation actually run: 100% verified, invalid/disposable/role-based/toxic removed, bounce rate under 2%?
- [ ] Catch-all addresses sub-verified, and anything older than 30 days re-verified?
- [ ] Accounts scoring under 50 (Tier D) excluded, not carried forward "just in case"?
- [ ] For Audit Mode: % still in-ICP and false-positive % calculated and reported, not eyeballed?
- [ ] Source, scoring logic, and any exclusions applied are documented for `clients/{slug}/test-log.md`, not left implicit?

---

## RULES

- **Specificity beats breadth.** A narrow ICP with high signal beats a broad ICP with low signal every time.
- **Reverse-engineer the ICP** from existing closed-won customers. Pull top 10-20, find patterns.
- **Re-score quarterly.** ICP fit drifts as the client's offer evolves.
- **Never skip verification.** Verification costs ($0.005-0.01/email) are trivial vs damaged sender reputation.
- **List hygiene schedule** lives in `wiki/list-building.md`. Stick to it.