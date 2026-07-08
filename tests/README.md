# Tests

Scenario-based tests for OS regression. Each file describes a scenario, an input, and the expected output. The GTME can run any test manually after OS changes to verify nothing broke.

**These are not automated tests.** They are documented scenarios that exercise the OS. Pass/fail is judged by reading Claude's output against the expected output.

---

## How to Run a Test

1. Open the test file (e.g. `test-onboarding.md`)
2. Read the scenario and input
3. Trigger the skill via Claude Code using the provided prompt
4. Compare Claude's output to the expected output
5. PASS = matches the spirit of expected output (not exact text)
6. FAIL = drifts significantly from expected (skip a phase, miss a rule, output wrong file)

If a test fails after an OS change:
- Identify what changed
- Either fix the OS to restore behaviour
- Or update the expected output if the change was intentional
- Log to `CHANGELOG.md`

---

## Test Catalog

| File | What it tests |
|------|--------------|
| `test-onboarding.md` | Client onboarder Phase 1-5 flow with sample inputs |
| `test-cold-email-writer.md` | Cold email generation with quality bar |
| `test-weekly-reviewer.md` | Weekly review with sample campaign data |
| `test-reply-handler.md` | Reply classification and response for 5 reply types |
| `test-incident-responder.md` | Incident classification and protocol triggering |
| `test-pre-launch-check.md` | Placeholder validation gate |

---

## When to Run Tests

- **After every CHANGELOG.md bump** - run the full suite before tagging the version
- **After any skill file is edited** - run the corresponding test
- **Before onboarding a new client** - run test-onboarding.md to verify the flow is intact
- **Monthly** - run the full suite as a sanity check

---

## Test Format

Each test file follows this structure:

```
# Test: [Name]

## Scenario
[What's being tested]

## Input
[Exact prompt to send to Claude]

## Expected Output
[Bullet points / structure Claude should produce]

## Pass criteria
[What constitutes a pass]

## Fail criteria
[What constitutes a fail]
```