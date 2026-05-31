---
name: test-readiness-check
description: Pre-test gate. Validates that a planned test in company/test-log.md has all Step 1 fields completed per the scientific method, plus stop conditions and a backtrack plan. Blocks test-launcher if anything is missing. Forces the discipline that makes iteration compound.
triggers:
  - "Run test-readiness check on T-{{XXX}}"
  - "Is the test ready to launch"
  - "Verify test setup"
  - "Check test {{T-XXX}}"
reads:
  - "wiki/_skill-context.md"
  - "wiki/scientific-method.md"
  - "company/test-log.md (the test in Queued status)"
  - "company/campaign-state.md (for constants verification)"
writes:
  - "company/test-log.md (marks readiness check status on the test entry)"
  - "company/decision-log.md (if blocking issue surfaces a design question)"
---

# Skill: Test Readiness Check

**Trigger:** "Run test-readiness check on T-XXX", "Is the test ready to launch", "Verify test setup", "Check test T-XXX"

**Context:** Mirror of `gtm-skills/pre-launch-check.md`, but for tests specifically. Validates that a Queued test in `company/test-log.md` has all the Step 1 fields, stop conditions, and backtrack plan defined per the scientific method. Blocks `gtm-skills/test-launcher.md` from firing if anything is missing.

**Why this exists:** without enforced discipline, tests get launched with vague hypotheses, no defined sample size, drifting constants, or no plan for what to do if they fail. The result is data you cannot reason about. This skill prevents that.

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

## SKILL-SPECIFIC READS

- `wiki/scientific-method.md` — the canonical 4-step framework
- `company/test-log.md` — the test under evaluation (in Queued status)
- `company/campaign-state.md` — to verify infrastructure constants are stable

---

## INPUTS

- **Test ID** (T-XXX) — the test in `company/test-log.md` to evaluate
- If no ID given, default to the most recently queued test in the testing roadmap

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

## CHECKS PERFORMED

### Block-level (CRITICAL — fail = stop)

**1. Step 1.1 — Genotype defined**
- 2-4 key variables explicitly listed
- Each variable has a V-number (V1, V2, etc.)
- Stimulus name and overall V-number clear

**2. Step 1.2 — KPIs defined**
- Primary metric named (typically PRR)
- Primary KPI target value set (numeric, e.g. "5%")
- Secondary metric named (typically ABR — the Polaris)
- Secondary KPI target value set

**3. Step 1.3 — Sample size set**
- Sample size per variant defined
- Sample size meets minimum (300 sends for cold email, 30 viewed for video/Loom)

**4. Step 1.4 — Latency and timeframe set**
- Latency window explicit (e.g. "7 days post-final-send")
- Total timeframe explicit

**5. Step 1.5 — Airtight check completed**
- Deliverability verified (warmup green, bounce baseline <2%)
- Tracking attribution wired
- Variants cleanly differentiated in platform
- All constants locked in writing
- Stop conditions written

**6. Step 1.6 — Variant configuration**
- ONE variable identified as needle-mover (not multiple)
- Modification level picked (Slight / Moderate / Complete)
- Modification level matches distance from KPI (per scientific-method.md 4.4)
- Control copy / configuration pasted in full
- Variant copy / configuration pasted in full
- V-numbers correctly assigned to both

**7. Step 1.7 — Constants explicit**
- Lead source named
- ICP referenced
- Sending domain / mailbox named
- Send time of day specified
- Follow-up sequence structure specified
- Daily send volume specified
- All non-needle-mover variables locked with V-numbers

**8. Stop conditions**
- Bounce threshold defined
- PRR floor defined (when to pause variant)
- Complaint threshold defined
- Constants drift detection defined

**9. Backtrack plan**
- Regression threshold defined (e.g. "if V(n+1) PRR drops more than X% below V(n)")
- Revert target named (V(n))
- Next-direction guidance present (e.g. "if reverts, modify CTA next, NOT Content again")

### Warn-level (HIGH — fail = warn, can override with reason)

**10. Sample size feasibility**
- At current send rate, sample will be hit within stated timeframe (math checks out)

**11. Single variable confirmation**
- Re-confirm only ONE variable changes between control and variant (manual review of copy diff)

**12. Modification level appropriateness**
- Slight modification on a dead variant (PRR <0.5% vs >2% target) → warn, recommend complete
- Complete rewrite on a close-to-KPI variant (PRR 2.3% vs 3.5% target) → warn, recommend slight

**13. Constant overlap with another active test**
- No other Running test in `company/test-log.md` uses the same campaign / mailbox / lead source

**14. Polaris (secondary) currently above KPI**
- If secondary (ABR) is currently at or above KPI, warn — Step 3.2 Q2 says do NOT iterate primary while Polaris is hitting

---

## OUTPUT FORMAT

```
=== Test Readiness Check — T-XXX — date ===

TEST: T-XXX — description
Status in test-log: Queued

BLOCKING ISSUES: n
[ ] / [X] Step 1.1 Genotype defined          | detail if FAIL
[ ] / [X] Step 1.2 KPIs defined              | detail
[ ] / [X] Step 1.3 Sample size set           | detail
[ ] / [X] Step 1.4 Latency and timeframe     | detail
[ ] / [X] Step 1.5 Airtight check completed  | detail
[ ] / [X] Step 1.6 Variant config complete   | detail
[ ] / [X] Step 1.7 Constants explicit        | detail
[ ] / [X] Stop conditions defined            | detail
[ ] / [X] Backtrack plan defined             | detail

WARNINGS: n
[ ] / [!] Sample feasibility (math)           | detail
[ ] / [!] Single-variable confirmed           | detail
[ ] / [!] Modification level appropriate      | detail
[ ] / [!] No active test overlap              | detail
[ ] / [!] Polaris not currently hitting KPI   | detail

VERDICT: READY / NOT READY / READY WITH WARNINGS
```

---

## VERDICT RULES

- **READY:** zero blocking issues, zero warnings. Test-launcher can proceed.
- **READY WITH WARNINGS:** zero blocking issues, 1+ warnings. Harry must explicitly say "proceed with warnings" before test-launcher fires. The warnings get logged to `company/test-log.md` and `company/decision-log.md`.
- **NOT READY:** any blocking issue present. Test-launcher refuses. Specific gaps listed.

---

## RULES

- **Block by default.** A NOT READY verdict is the right answer when uncertain — slow tests are better than meaningless tests.
- **Be specific about failures.** Not "Sample size missing" — "Section 1.3 of T-006 in test-log.md is blank. Set sample size in writing (minimum 300 for cold email)."
- **Do not auto-fix.** Surface gaps, let Harry resolve them in test-log.md.
- **Log every check.** Even passes go to `company/decision-log.md` as a Setup verification entry — the audit trail matters for QBR and weekly review.
- **Cite scientific-method.md.** When warning on modification level mismatch (e.g. slight modification on dead variant), reference the exact rule from `wiki/scientific-method.md` Step 4.4.

---

## EXAMPLES

### Example — failed check (missing constants)

```
Harry: Run test-readiness check on T-006

Claude:
=== Test Readiness Check — T-006 — 2026-05-30 ===

TEST: T-006 — Funding Email 1 offer reframe (scale-without-headcount angle)
Status in test-log: Queued

BLOCKING ISSUES: 2
[X] Step 1.7 Constants explicit               | Missing: send time of day, follow-up sequence structure
[X] Backtrack plan defined                    | No regression threshold or revert target named

WARNINGS: 1
[!] Polaris not currently hitting KPI         | OK — ABR is at 1.1% vs 3.5% target, primary iteration is justified

VERDICT: NOT READY

Fix needed in company/test-log.md → T-006:
1. Section 1.7 — add: send time of day (current campaign sends 9am-11am EST), follow-up sequence (current 3-step sequence with D3 and D7 follow-ups)
2. Add Backtrack Plan section — define regression threshold (suggested: V(2) PRR <0.4% within first 300 sends triggers revert to V(1)), name revert target (Hiring v4 Email 1), state next-direction (modify CTA instead of Content if this regresses)

After fixes, re-run "Run test-readiness check on T-006" and I will re-evaluate.
```