# Active-Test Rules

Canonical rules for handling changes to a campaign that has an **active test** running. Referenced (not duplicated) by every skill that could modify a campaign mid-test.

**Used by:** `gtm-skills/cold-email-writer.md`, `gtm-skills/client-request-handler.md`, `gtm-skills/campaign-optimiser.md`. Any future skill that could modify a running campaign should reference this file.

**Why this exists:** the scientific method only works if Ceteris Paribus is enforced - all other things equal during the test. The OS is the enforcer. Without this gate, mid-test changes silently invalidate data and the iteration loop stops compounding.

---

## When to check this file

Before making any change to a campaign or its sequence, **read `clients/{slug}/campaign-state.md`** and check whether the campaign has a `TEST ACTIVE` flag.

If `TEST ACTIVE - T-{{ID}} testing {{variable}}. Constants LOCKED.` is present, apply the rules below.

If no `TEST ACTIVE` flag is present, proceed normally - these rules do not apply.

---

## The Rules

1. **Read `clients/{slug}/test-log.md` → T-{{ID}} → Section 1.7 Constants list.**

2. **Compare the requested change to the locked constants:**
   - If the change touches a **constant** (lead source, ICP, sending domain, mailbox, send time, follow-up sequence, daily volume, any non-needle-mover variable with locked V-number) → **REFUSE**.
   - If the change touches the **needle-mover variable being tested** → **REFUSE** (modifying it mid-test invalidates the test).
   - If the change is **genuinely orthogonal** (a different campaign, a different stimulus type entirely) → proceed normally.

3. **Refusal output format:**

```
⚠️ STRICT BLOCK - Active test T-{{ID}} on this campaign

The requested change touches: {{constant_name OR variable_under_test}}
Locked since: {{launch_date}}
Reason: modifying this would invalidate test T-{{ID}}.

Options:
(A) Wait for test completion ({{estimated_date}})
(B) Pause and invalidate the test deliberately (requires explicit override)

To override and proceed anyway, respond: "Override active test T-{{ID}}"
This will:
- Mark T-{{ID}} as INVALID in test-log.md
- Log the override + reasoning to decision-log.md
- Surface a warning in the next weekly review
- Allow the requested change to proceed
```

4. **If the GTME overrides:**
   - Move the test from Running to Reverted in `clients/{slug}/test-log.md` with reason "manually invalidated mid-test by override"
   - Log the override to `clients/{slug}/decision-log.md` with context (why the change could not wait)
   - Remove the `TEST ACTIVE` flag from `clients/{slug}/campaign-state.md`
   - Then proceed with the requested change

---

## Source

Extracted to a single canonical file in v1.4.0 (was previously duplicated character-identical across `cold-email-writer.md`, `client-request-handler.md`, `campaign-optimiser.md`). Skills now reference this file rather than restating the rules.
