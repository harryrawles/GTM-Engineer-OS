---
name: chain-build-campaign
description: Intelligent campaign-build chain. Assesses current state, then invokes only the skills that are actually needed (icp-builder, list-builder, signal-sourcer, personalization-strategist, cold-email-writer, pre-launch-check, campaign-launcher) in sequence with checkpoint pauses between stages. Saves you from running each skill individually for full-cycle work.
triggers:
  - "Build a campaign"
  - "Run /build-campaign"
  - "Build the [signal] campaign for [client]"
  - "Set up a new campaign"
  - "Build [client] [signal] campaign"
reads:
  - "wiki/_skill-context.md"
  - "wiki/_subagent-patterns.md"
  - "clients/{slug}/_config.md, MEMORY.md, campaign-state.md, icp.md, offer.md, voice.md, copy-library.md, test-log.md"
invokes:
  - "gtm-skills/icp-builder.md (conditional)"
  - "gtm-skills/list-builder.md (conditional)"
  - "gtm-skills/signal-sourcer.md (conditional)"
  - "gtm-skills/personalization-strategist.md (conditional)"
  - "gtm-skills/cold-email-writer.md (always)"
  - "gtm-skills/pre-launch-check.md (always)"
  - "gtm-skills/campaign-launcher.md (always)"
writes:
  - "clients/{slug}/campaign-state.md (new campaign entry)"
  - "clients/{slug}/decision-log.md (rationale)"
  - "clients/{slug}/MEMORY.md (active focus update)"
---

# Skill: Chain — Build Campaign

**Trigger:** "Build a campaign", "Run /build-campaign", "Build the [signal] campaign for [client]", "Build [client] [signal] campaign"

**Context:** End-to-end campaign creation chain. Reads state, decides which sub-skills are actually needed (do not invoke icp-builder if ICP is already defined; do not invoke list-builder if list already exists), then runs only the required ones with operator pause-points between stages.

**Why this exists:** running each skill individually for a full-cycle campaign means 6+ explicit invocations and manual context-passing between them. This chain assesses what is missing, invokes only those skills, and threads context through automatically without sacrificing operator visibility (you can pause and edit between stages).

---

## STANDARD CONTEXT

See `wiki/_skill-context.md` and `wiki/_subagent-patterns.md`.

Before building, check `best-practices/playbooks/` for a reusable playbook matching the active client's
offer/angle (e.g. funding). If one fits, start the campaign from its structure and adapt it to the client —
fill placeholders from `clients/{slug}/` and use only Approved Claims from `voice.md`. Never drop playbook
copy in verbatim.

---

## STEP 0 — Assess State (always)

**Log this invocation first.** Append a row to `clients/{slug}/session-log.md` Active Log per `wiki/_skill-context.md` "Session-Log Write" rules. Format: `| YYYY-MM-DD HH:MM | {{paraphrased prompt}} | chain-build-campaign | (filled at end) |`. Sub-skills invoked later will write their own rows. Without this step, `gtm-skills/pattern-detector.md` cannot find repeating prompts.

Then read the following and produce an assessment:

- `clients/{slug}/_config.md` — client identity
- `clients/{slug}/MEMORY.md` — current focus, active inbound, watch-outs
- `clients/{slug}/icp.md` — does the ICP look complete and current?
- `clients/{slug}/offer.md` — does the offer look complete and current?
- `clients/{slug}/campaign-state.md` — what is active, what is paused, what has been tried
- `clients/{slug}/copy-library.md` — do we have prior winners on the proposed signal?
- `clients/{slug}/test-log.md` — any active tests on this campaign that would conflict?

Also clarify intent with Harry if not already stated:
- **Signal:** what triggers this campaign? (e.g. hiring, funding, champion job change)
- **Target ICP slice:** which subset of the client ICP?
- **Sequence length:** 2-step, 3-step, 4-step (default 3)?
- **Goal:** new campaign launch OR iterating on existing winner?

Then produce a **chain plan** as the next output. Always show the chain plan first and wait for Harry's confirmation before any sub-skill is invoked. This is the smart-routing decision moment.

---

## SKIP CONDITIONS (the intelligence)

### Skip Step 1 (icp-builder) if:
- `clients/{slug}/icp.md` has zero placeholder values
- ICP last reviewed within last 30 days
- No new evidence in `clients/{slug}/comms-log.md` suggesting ICP drift
- Harry has not explicitly requested ICP refinement

### Skip Step 2 (list-builder) if:
- Existing list for this signal type is verified within last 30 days
- Existing list size matches campaign volume requirements
- No bounce-rate flags on previous use of this list
- Harry has not explicitly requested a new list

### Skip Step 3 (signal-sourcer) if:
- Signal strategy for this campaign is already defined in `clients/{slug}/icp.md` signal priority table
- Signal is in active rotation per `clients/{slug}/campaign-state.md`
- Harry has not requested a signal pivot

### Skip Step 4 (personalization-strategist) if:
- Personalisation tier obvious from volume + deal size (see `wiki/personalization-at-scale.md` decision matrix)
- High volume (>100/day) + strong signal → skip personalisation, the matrix decides
- Low volume (<50/day) + $25K+ ACV → personalise, matrix decides
- Harry has not asked for a custom personalisation approach

### NEVER skip:
- Step 5 (cold-email-writer) — the core artefact
- Step 6 (pre-launch-check) — the placeholder gate
- Step 7 (campaign-launcher) — the launch gate

---

## STEP 1 — ICP Refinement (conditional)

If required: invoke `gtm-skills/icp-builder.md`.

**Pause-point:** show Harry the refined ICP. Get confirmation before proceeding.

**Output to checkpoint:** updates `clients/{slug}/icp.md`. Note the change in `clients/{slug}/decision-log.md` if non-trivial.

---

## STEP 2 — Lead List (conditional)

If required: invoke `gtm-skills/list-builder.md` with the ICP from Step 1 (or current `clients/{slug}/icp.md` if Step 1 skipped).

**Pause-point:** show Harry the list count, tier distribution (A/B/C), and 5 sampled leads for spot-check.

**Output to checkpoint:** list saved to client's preferred lead storage (Instantly directly, or staged in Notion/Sheets per `clients/{slug}/campaign-state.md` Tools section).

---

## STEP 3 — Signal Strategy (conditional)

If required: invoke `gtm-skills/signal-sourcer.md`.

**Pause-point:** show Harry the proposed signal(s), scoring framework, recommended SLA per tier.

**Output to checkpoint:** updates `clients/{slug}/icp.md` signal priority table if changed.

---

## STEP 4 — Personalisation Tier (conditional)

If required: invoke `gtm-skills/personalization-strategist.md`.

**Pause-point:** show Harry the proposed personalisation tier (strong hook / lite hook / none), which bucket to use, and AI prompt if Clay-based.

**Output to checkpoint:** decision noted in `clients/{slug}/decision-log.md`. AI prompts saved for Instantly / Clay setup.

---

## STEP 5 — Write Copy (always)

Invoke `gtm-skills/cold-email-writer.md` with all gathered context:
- Signal from Step 3 (or current state)
- Target persona from Step 1 (or current icp.md)
- Personalisation tier from Step 4 (or matrix default)
- Sequence length from Step 0 intent
- Pull from `clients/{slug}/copy-library.md` winners as starting point

**Pass 2 fresh-eyes review:** automatically invoke `gtm-skills/fresh-eyes-reviewer.md` on the generated copy if this is a Tier 1 campaign OR a new variant being tested. Skip Pass 2 for routine follow-ups.

**Pause-point:** show Harry the full sequence (Email 1, 2, 3) with QA checklist results.

---

## STEP 6 — Pre-Launch Check (always)

Invoke `gtm-skills/pre-launch-check.md`. This is the placeholder gate.

- If READY: proceed to Step 7.
- If NOT READY: stop, output gaps, return to relevant prior step.

This step does not pause for Harry's approval — it auto-proceeds on READY and auto-blocks on NOT READY.

---

## STEP 7 — Launch (always)

Invoke `gtm-skills/campaign-launcher.md`. Full 10-category pre-flight checklist.

**Pause-point:** Harry confirms the launch checklist results before clicking launch in Instantly.

**On launch:** update `clients/{slug}/campaign-state.md` with new campaign entry, status Active. Update `clients/{slug}/decision-log.md` with launch rationale.

---

## RULES

- **Always show the chain plan first.** Never silently invoke 6 sub-skills. Harry needs to see what was assessed.
- **Skip aggressively but transparently.** If a step is skipped, the assessment block must state why. Vague skips erode trust.
- **Pause at every meaningful checkpoint.** Operator visibility > automation speed.
- **Sub-skill calls must inherit context.** When invoking cold-email-writer, pass the signal/persona/personalisation tier explicitly. Do not assume it will re-derive them.
- **Block on pre-launch-check NOT READY.** No exceptions. Return to the relevant prior step.
- **One chain run = one decision-log entry.** Captures the run as a unit: which steps were needed, what was decided.
