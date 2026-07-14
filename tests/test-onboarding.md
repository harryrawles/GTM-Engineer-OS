# Test: Onboarding Flow

## Scenario

A fresh clone of the template. The GTME runs the onboarder for a fictitious client "Acme Health" (HR tech for healthcare).

## Input

```
Run client onboarder for Acme Health
```

## Expected Output

Claude should:

### 1. Detect state
- Read CLAUDE.md and detect ~8 placeholders remaining
- Read clients/{slug}/*.md and detect all blank/template
- Output a state report

### 2. Start Phase 1 - Identity
- Ask about client name (Acme Health)
- Ask about website
- Ask about industry (HR tech for healthcare)
- Continue 10 questions in Phase 1
- After all answered, write to:
  - CLAUDE.md (placeholder replacement)
  - clients/{slug}/overview.md
  - clients/{slug}/_config.md
- Confirm Phase 1 complete

### 3. Continue Phase 2 - Offer (30-40 min)
- Run the full 9-step worksheet (`wiki/offer-framework.md`) - who, outcome, timeframe, methodology,
  factors of value, risk reversal/guarantee (with a name), polarisation, ultimatum, packaging - plus
  proof points, differentiators, value props, and CTA options
- Push back if answers are vague ("better hiring" → "by how much, by what date?")
- Write to clients/{slug}/offer.md, one section per step as it's confirmed

### 4. Continue Phase 3 - ICP (15 min)
- Ask 13 ICP questions
- Cross-reference with wiki/signal-sourcing.md to propose 2-3 signals
- Write to clients/{slug}/icp.md

### 5. Continue Phase 4 - Voice (10 min)
- Ask 11 voice questions including spelling default
- For Acme Health (US-based healthcare client) → set American English
- Write to clients/{slug}/voice.md

### 6. Continue Phase 5 - Infrastructure (5 min)
- Ask 8 infrastructure questions
- Note tools used per client
- Write infrastructure section to clients/{slug}/campaign-state.md

### 7. Completeness Report
- Run pre-launch-check
- Output:
  - All files written
  - Any {{TO CONFIRM}} entries listed
  - Verdict READY / NOT READY
- Suggest next step ("Build the first lead list for Acme Health")

## Pass Criteria

- All 5 phases run in order
- Files written in correct locations (clients/{slug}/ not wiki/)
- Placeholders replaced in CLAUDE.md
- _config.md populated with at least client_name, industry, primary_contact
- Pushback occurs on vague answers
- Resumable on interruption (verify by stopping mid-Phase-3, restarting, confirm it picks up at Phase 3 next question)

## Fail Criteria

- Onboarder skips a phase
- Files written to wrong location (e.g. clients/{slug}/copy-library to wiki/)
- Placeholders left unresolved without flagging
- Onboarder writes vague content without pushback
- Resume fails - restarts from Phase 1 after interruption