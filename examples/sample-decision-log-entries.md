# Sample Decision Log Entries

Example entries showing what good decision log entries look like. Reference these when running weekly reviews to match the quality bar.

---

## Sample Winner Entry

### 2026-05-29 - Logged Hiring v4 Email 1 as canonical winner

**Context:**
- Campaign: Hiring Signal v4
- Signal: 3+ engineering job postings in last 30 days
- Target: VP/Head of Engineering at Series A-C SaaS
- Metrics: 5,859 lifetime sends, 2.3% PRR, 12 meetings booked

**Decision:**
Promoted Email 1 of Hiring v4 to canonical Email 1 pattern. Will adopt the structure as default for similar hiring-signal campaigns going forward.

**Why:**
- "Saw the senior eng hires coming in" feels personalised without naming specific roles (lighter touch, less creepy)
- Part 2 leads with daily pain ("10-15 hrs/week interviewing low-signal candidates") - recognised immediately by VP Eng audience
- Part 3 names {{NAMED_PROOF_COMPANY}} + $100k saved + 4 hires in 14 days - specific, verifiable, comparable
- CTA "Want a sample shortlist?" - zero commitment, lower friction than "15-min call?"

**Most stealable element:**
The "sample shortlist" CTA pattern (or its equivalent - sample audit, sample analysis, sample list). Beats time-asks for first-touch outbound where prospect has no relationship yet.

**Do NOT carry over to other clients:**
- The $100k {{NAMED_PROOF_COMPANY}} figure is {{CLIENT_NAME}}-specific
- The "10-15 hrs/week" number is engineering-recruiting-specific

**Linked entries:**
- `clients/{slug}/copy-library.md` → Hiring Signal v4 Email 1 (PRR 2.4%)
- `clients/{slug}/test-log.md` → T-002 confirmed this was variant winner

**Outcome (to update):**
*Will update at next QBR with adoption rate on other campaigns.*

---

## Sample Loser / Graveyard Entry

### 2026-05-29 - Funding v2 Email 1 to graveyard

**Context:**
- Campaign: Series A-C Funding v2
- Signal: Funded 30-90 days ago
- Target: VP/Head of Engineering at funded SaaS
- Metrics: 3,890 sends, 0.5% PRR (declining 4 weeks straight from 1.8% peak), 2 meetings

**Decision:**
Pausing Funding v2 Email 1. Replacing via test T-006 with reframed offer.

**Why it failed:**
- "Saw you raised your Series B" is the exact opening every recruiter uses post-funding - pattern-matched as cold outbound immediately
- "Hiring strategy" offer is too generic - sounds like every other agency pitch
- Part 2 with "30-50% headcount increase" prediction landed as a guess, not insight
- Long sentence structure (Part 2 had 25+ words) lost reader before getting to value

**What NOT to repeat:**
- Don't reference the funding event directly in Part 1 (mention the implication: scaling pressure, hiring velocity, etc.)
- Don't lead with "hiring strategy" - too generic
- Sentences over 18 words lose attention in cold

**Linked entries:**
- `clients/{slug}/copy-library.md` → Graveyard: Funding v2 Email 1
- `clients/{slug}/test-log.md` → T-006 (queued - reframe to "scale without headcount" angle)

---

## Sample Strategic Decision Entry

### 2026-04-12 - Tightened ICP size from 1-500 to 1-200

**Context:**
- Q1 review showed 60% of negative replies were from 200+ employee companies
- Common objection: "We use Greenhouse, fully covered"
- Time spent qualifying out 200+ orgs was 30% of our sourcing effort

**Decision:**
Updated `clients/{slug}/icp.md` lead filter: maxHeadcount changed from 500 to 200.

**Why:**
- {{CLIENT_NAME}}'s wedge (sourcing from VC-backed product companies) matters more to smaller, faster-moving teams
- 200+ companies typically have established internal recruiting + ATS (Greenhouse, Lever) and use {{CLIENT_NAME}} only for specific senior roles - too narrow to scale
- Sourcing cost-per-meeting on 200+ was 3.2x higher than 1-200 segment

**Alternatives considered:**
- Keep filter open but adjust copy for 200+ → rejected (different value prop, different sales cycle)
- Tighten to 1-100 → rejected (under 50 employees rarely have senior eng hiring pressure)
- Industry-specific tightening only → considered but headcount was the cleaner cut

**Trade-offs:**
- We exclude ~30% of previous TAM
- We may miss large-company wins (acceptable - they're not our wedge)
- Sales cycle should compress (faster decisions at smaller orgs)

**Outcome (updated 2026-05-15):**
After 30 days post-change: PRR up 0.6% across portfolio. Meetings up 28%. Decision confirmed correct.

---

## Sample Client Request Decision

### 2026-05-12 - Client requested change to Email 2 copy ({{CLIENT_NAME}})

**Context:**
- {{PRIMARY_CONTACT}} ({{CLIENT_NAME}}) Slacked: "Email 2 isn't landing for me. Wants something more about the candidate quality story, not the timeline."
- Email 2 at the time was leading with "21-day close rate" timeline angle
- Email 2 PRR: 0.4% (Email 1 was 2.4%)

**Decision:**
Reframed Email 2 to lead with candidate provenance ("only VC-backed product companies, no outsourcing firms"). {{PRIMARY_CONTACT}} approved within 4 hours. Replaced in Instantly same day.

**Why:**
- {{PRIMARY_CONTACT}}'s instinct aligned with the data - Email 2 was the weak link in sequence
- Candidate quality is the most differentiated thing about {{CLIENT_NAME}} vs other agencies (sourcing pool)
- Email 1 already covers timeline ("72-hour shortlist") so Email 2 doesn't need to repeat

**Outcome (updated 2026-05-26):**
Email 2 PRR went from 0.4% to 0.9% (2 weeks data). Still below Email 1 but materially better. {{PRIMARY_CONTACT}} confirmed he likes the new version. Pattern: client instinct on "what's not working" is often correct - act fast.

---

## Notes on Quality

Good decision log entries:
- **Have specific numbers** - not "PRR was bad" but "PRR was 0.5%"
- **Capture the alternative considered** - what we did NOT choose, and why
- **State trade-offs explicitly** - every decision has a cost
- **Update outcomes** - the entry isn't done at decision time
- **Link to related artifacts** - copy-library entries, test results, comms-log

Bad entries:
- Vague summaries without numbers
- Missing the "why" - just the "what"
- No alternatives considered
- Never updated with outcomes