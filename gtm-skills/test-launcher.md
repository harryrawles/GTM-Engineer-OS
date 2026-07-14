---
name: test-launcher
description: Reads the testing roadmap from clients/{slug}/test-log.md, picks the next priority test, generates the variant via cold-email-writer, updates campaign-state, and outputs Instantly setup instructions. Closes the loop from "what to test next" to "test running."
triggers:
  - "Launch the next test"
  - "What should I test next"
  - "Run test-launcher"
  - "Queue next test for {{client}}"
  - "Promote the queued test to live"
reads:
  - "wiki/_skill-context.md"
  - "clients/{slug}/test-log.md"
  - "clients/{slug}/copy-library.md"
  - "clients/{slug}/campaign-state.md"
  - "wiki/scientific-method.md"
writes:
  - "clients/{slug}/test-log.md (move test from queued to running)"
  - "clients/{slug}/campaign-state.md (note active test)"
  - "clients/{slug}/decision-log.md (test launch rationale)"
---

# Skill: Test Launcher

**Trigger:** "Launch the next test", "What should I test next", "Run test-launcher", "Queue next test for [client]", "Promote the queued test to live"

**Context:** A test queued in `test-log.md` does nothing until it's launched. This skill closes the gap - picks the next test by priority, generates the variant, updates state, and instructs the GTME on the Instantly setup.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

## SKILL-SPECIFIC READS

- `wiki/scientific-method.md` - the canonical 4-step framework (READ FIRST every time)
- `gtm-skills/test-readiness-check.md` - invoked as a hard gate before launch
- `clients/{slug}/test-log.md` - testing roadmap (Queued tests at the top)
- `clients/{slug}/copy-library.md` - current control (the existing winner)
- `clients/{slug}/campaign-state.md` - which campaigns are eligible, active-test flags

---

## STEP 0 - Log Invocation (mandatory)

Before any other step, append one row to `clients/{slug}/session-log.md` Active Log table:

```
| YYYY-MM-DD HH:MM | {{paraphrased prompt summary, ~60 chars}} | test-launcher | (filled at end) |
```

Rules (per `wiki/_skill-context.md` "Session-Log Write"):
- Write at START, not end - captures the attempt even if the skill fails mid-execution
- Paraphrase the prompt - no raw prospect names, emails, or sensitive data
- Outcome column filled at end of execution

Without this row, `gtm-skills/pattern-detector.md` cannot find repeating prompts and the auto-improvement loop breaks.

## STEP 0.1 - Run Test Readiness Check (MANDATORY)

Before proceeding with any test launch, invoke `gtm-skills/test-readiness-check.md` on the candidate test in `clients/{slug}/test-log.md`.

```
Run test-readiness check on T-{{XXX}}
```

Verdict rules:
- **READY** → proceed to Step 1 below
- **READY WITH WARNINGS** → require the GTME to explicitly say "proceed with warnings"; log warnings to `clients/{slug}/decision-log.md`
- **NOT READY** → **STOP.** Output the gaps. Refuse to launch. Direct the GTME to fix `clients/{slug}/test-log.md` for that test.

**No exceptions.** The OS does not launch tests that fail this gate. Skipping it means tests get launched with vague hypotheses, drifting constants, and no backtrack plan - the result is unattributable data.

## STEP 1 - Identify Next Test

Read `clients/{slug}/test-log.md` testing roadmap. Filter to:
- Status: "Queued"
- Not blocked (no upstream dependency)
- Campaign has capacity (active and not at stop-condition risk)

If multiple tests are queued, prioritise by:
1. Variable priority (from `wiki/scientific-method.md` priority order: Offer > ICP > Hook > CTA > Subject)
2. Campaign health (higher priority = lower-performing campaigns that need lift)
3. Sample size availability (campaigns with high send rate complete tests faster)

Output the candidate test:
```
NEXT TEST CANDIDATE - T-{{ID}}

Variable being tested: {{variable}}
Campaign: {{campaign}}
Hypothesis: {{from test-log}}
Current control: {{description from copy-library}}
Proposed variant: {{description from test-log}}

Sample target: {{n}} sends per variant (300 minimum)
Estimated time to complete: {{n}} days at current send rate
Latency buffer: 7 days post-send for reply settling

Stop conditions:
- {{condition 1}}
- {{condition 2}}

Recommend proceeding? (Y/N)
```

---

## STEP 2 - Generate the Variant

If the GTME confirms:

1. **Invoke `gtm-skills/cold-email-writer.md`** to generate the variant copy.
2. Use the variable being tested as the ONE thing that changes - everything else is constant.
3. Apply the modification level from `wiki/scientific-method.md`:
   - PRR close to target → slight modification
   - PRR moderate gap → moderate modification
   - PRR way off target → complete modification

4. Show the GTME both control and variant side-by-side:

```
=== Side-by-Side ===

CONTROL (current Email 1):
Subject: {{subject}}
{{body}}

VARIANT (new test version):
Subject: {{subject}}
{{body}}

Variables tested: {{name}}
What is different: {{specific change}}
What is the same (constants): {{list}}
```

5. Run `wiki/copywriting-101.md` QA checklist on the variant.

6. Get the GTME's approval on the variant.

---

## STEP 3 - Pre-Launch Verification

Before queuing in Instantly:

- [ ] Variant approved by the GTME
- [ ] Variant passes QA checklist
- [ ] Constants verified (lead source, ICP, sending domain, time of day, follow-up sequence - all unchanged)
- [ ] Sample size and timing realistic (test will hit 300 sends within stated timeframe)
- [ ] Stop conditions defined and recorded in `clients/{slug}/campaign-state.md`
- [ ] Client approval if required (some clients want sign-off on test variants - check `clients/{slug}/overview.md` SLA section)

If anything fails → fix before proceeding.

---

## STEP 4 - Launch in Instantly

The OS calls the Instantly API v2 directly via `.claude/bin/instantly.sh` (see `sops/instantly-api.md`) - it is
not limited to manual instructions. Reads and campaign creation are the skill's to execute; anything that
mutates a live, already-sending campaign (activating, adding leads, pausing) is a gated write per `CLAUDE.md`
Safety Guard and needs the GTME's explicit go-ahead before the call is made, stated plainly (the action, the
workspace, the campaign name) immediately beforehand.

For a **new variant inside an existing running campaign**:
1. `GET /campaigns/{id}` to pull the current `sequences[0].steps` array.
2. Add the new variant to the relevant step's `variants` array (or add a new step), preserving every
   existing variant untouched - `PATCH /campaigns/{id}` replaces the whole `sequences` field, so the full
   array must be resent, not just the delta.
3. State the diff explicitly to the GTME before calling PATCH: what's new, what's unchanged.
4. `PATCH /campaigns/{id}` with the updated `sequences`. This is a gated write - confirm with the GTME first.
5. Verify by re-fetching the campaign and confirming variant count / subjects match what was intended.

For a **full-rewrite test replacing a dead campaign** (Complete modification level, see
`wiki/scientific-method.md` 4.4): build the sequence as a new campaign via `POST /campaigns` (get `name`,
`campaign_schedule`, `sequences`, `email_list`, and pacing/tracking fields from the schema in
`wiki/instantly-api-reference.md` Section 2), created as Draft (do not set `status` to Active). Loading
leads and activating are separate gated actions from creating the Draft - do not bundle them into the same
approval unless the GTME explicitly asked for all three.

**Naming convention - every new campaign name starts with `Instantly | `.** e.g. `Instantly | {{Client}}
| Checkout Sequence V2`. This applies to every client, not just one - confirmed 2026-07-13 after a
client's GTME renamed a campaign that had been created without the prefix. Get the prefix right the first
time rather than relying on the GTME to rename after the fact.

QA before any write, same as before:
- Subject and body match the approved variant exactly
- No HTML formatting added accidentally
- Liquid syntax / spintax preserved (format per `gtm-skills/spintax-ninja.md`) - the `{{RANDOM|...}}` syntax
  passes straight into the JSON body as literal text; Instantly parses it at send time
- Word counts / question-mark rule / register match the version the GTME approved

---

## STEP 5 - Update State

After the GTME confirms the test is live in Instantly:

1. **Update `clients/{slug}/test-log.md`:**
   - Move T-{{ID}} from Queued to Running
   - Preserve the FULL Step 1 block (genotype, KPIs, sample, latency, airtight check, variant config, constants, stop conditions, backtrack plan)
   - Record launch date
   - Initialise the "Running data" table for daily logging
   - Note expected completion date

2. **Update `clients/{slug}/campaign-state.md`:**
   - Add note to the campaign: **"TEST ACTIVE - T-{{ID}} testing {{variable}}. Constants LOCKED."**
   - This flag is the trigger for strict-block guards in cold-email-writer, client-request-handler, and campaign-optimiser.
   - Any skill attempting to modify constants of this campaign during the test will refuse without explicit override.

3. **Write to `clients/{slug}/decision-log.md`:**
```
### {{date}} - Launched test T-{{ID}}: {{variable}}

**Context:**
- Campaign: {{name}}
- Current control PRR: {{X}}%
- Hypothesis: {{from test-log}}

**Decision:**
Launched A/B split between current control and variant.

**Why this variable, this hypothesis:**
{{reasoning}}

**Why now:**
{{e.g. PRR has plateaued / Campaign volume supports sample / etc.}}

**Expected outcome:**
- If variant wins → {{specific lift expected and what we do next}}
- If control wins → {{what we test next}}
- If inconclusive → {{re-test or move on}}

**Outcome (to update):**
{{Filled in after test completes}}
```

---

## STEP 6 - Schedule Review

The next weekly review will check whether the test has hit sample size + latency. The reviewer will surface it for confirmation and update.

If test completes mid-week (rare for high-volume clients) → the GTME can manually trigger:
```
Run weekly review for {{client}} - focus on tests
```

---

## RULES

- **One variable per test.** Always. No exceptions. If multiple variables need testing, queue separate tests sequentially.
- **300 sends per variant minimum.** Do not call results before sample. Early reads are noise.
- **Latency:** 7 days post-final-send before judging results.
- **Constants are sacred.** Do not change anything else during a test. If something changes (new domain, new lead source) → restart the test.
- **Do not auto-launch.** Show the GTME the variant, the side-by-side, the QA checklist. The GTME approves, the GTME pastes into Instantly.
- **Log everything.** test-log update, campaign-state note, decision-log entry. Three writes per launch.
- **If a test would push the campaign past stop conditions** (e.g. testing a more aggressive subject line that risks bounce spike), warn the GTME explicitly before proceeding.

---

## EXAMPLES

### Example - launching next queued test

```
GTME: Launch the next test for {{CLIENT_NAME}}

Claude:
=== Next Test Candidate - T-006 ===

Variable being tested: Email 1 offer framing for Funding campaign
Campaign: Series A-C Funding v2
Hypothesis: Current offer leads with "hiring strategy for post-raise." Hypothesis: leading with "scale without headcount" angle resonates more with post-raise context. Expected PRR lift: 0.6% → 1.2%.

Current control PRR: 0.6% (declining 4 weeks straight - root cause likely offer framing)

Sample target: 300 sends per variant (1,500 sends total before significance)
Estimated time to complete: 6 days at current 240/day rate, plus 7 days latency = 13 days to results
Modification level: Moderate (close to "complete" given 4-week decline)

Stop conditions:
- Bounce >5% on either variant
- Variant complaints >0.3%
- PRR on variant <0.3% after 300 sends

Recommend proceeding? (Y/N)

[GTME: Yes]

Generating variant via cold-email-writer...

=== Side-by-Side ===

CONTROL (current Email 1):
Subject: runway math
Saw you raised your Series B in March. Most VPs of Eng I talk to at this stage are mapping out a 30-50% headcount increase over 12 months - but the math gets ugly fast. We helped {{NAMED_PROOF_COMPANY_2}} close 4 senior eng roles in 14 days, saved $80k vs in-house. Worth a quick chat on the hiring strategy?

VARIANT (T-006):
Subject: scale without headcount
Saw the Series B. Most teams post-raise default to "hire faster" - but at $5M-15M ARR, most engineering bottlenecks are about throughput per engineer, not headcount. We work with VC-backed product teams to scale eng velocity without the linear hire spend. Worth a quick chat?

Variables tested: Offer framing (Part 3 of formula)
What is different: Reframed from "hiring strategy" to "scale without headcount"
What is the same: ICP, sending domain, signal, sequence position, subject style, length

QA checklist on variant: PASS

Approve variant? (Y/N)
```