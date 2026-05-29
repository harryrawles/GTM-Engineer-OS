# Test: Cold Email Writer

## Scenario

Generate Email 1 for Recruitcha's hiring signal campaign targeting VP Engineering. The OS has the Recruitcha example data loaded.

## Input

```
Write a cold email for Recruitcha. Email 1 of a new sequence. Signal: company posted 3+ engineering roles in 30 days. Target: VP Engineering at Series A-C SaaS.
```

## Expected Output

Claude should:

### 1. Run Pre-Write Protocol
- Pull Instantly data (or ask Harry to paste)
- Read company/copy-library.md for prior winners on hiring signal
- Check graveyard
- Decide register: VP Engineering → ATL → max 60 words
- Decide personalisation: $25K+ ACV (recruitment fees are 20%+ of senior salary) → personalise
- State starting point

### 2. Generate Email 1
- Follow 4-part formula
- Under 60 words (ATL ceiling)
- No question marks except CTA
- Subject 2-4 words, lowercase
- Use approved claims from company/offer.md only (TurboTenant $100k, 72-hour shortlist, etc.)
- Match voice (American English, direct, data-led, no fluff)
- Do NOT mention the signal directly ("saw you posted 3 roles")

### 3. Run QA Checklist
- All 16 items confirmed
- Word count verified
- No banned words from voice.md
- Approved claims only

## Expected Output Structure (not exact text)

```
Starting point: Building from Hiring Signal v4 Email 1. Register: ATL. Personalisation: Lite hook (job posting count).

Subject: hiring speed

Part 1 (personalisation): References the implication of hiring posts, not the posts themselves
Part 2 (who am I): Uses "I" + specific number + named client
Part 3 (offer): TurboTenant case study + specific dollar figure + 72-hour shortlist
Part 4 (CTA): Binary question, 5-word reply or less

[Total: 45-55 words]

QA: PASS
```

## Pass Criteria

- Under 60 words (ATL register)
- Uses ONLY approved claims (no invented stats)
- No banned words
- Subject 2-4 words lowercase
- One CTA
- Bar test passes (read aloud sounds natural)
- Pre-write protocol explicitly stated

## Fail Criteria

- Over 60 words (wrong register)
- Invents proof points not in offer.md
- Uses "leverage", "synergy", "game-changer", etc.
- Multi-sentence question
- Generic Part 1 ("I noticed you're growing")
- Mentions the signal explicitly ("saw your job postings")