# Deliverability

Deliverability is upstream of every metric. If sends aren't landing, nothing else matters, but that
diagnosis is different from the fix. Domain, mailbox, DNS, and workspace-level setup and recovery are the
AM's job (`sops/am-gtme-responsibility-split.md`). This file is what a GTME needs: healthy benchmarks to
diagnose against, symptom recognition, and a clear line on what to flag versus what to fix directly.

**GTME still owns directly:** list verification and hygiene (lead list building is explicitly GTME's), the
copy-side factors that affect deliverability (plain text, no links/images/tracking pixels, compliant
footers), and recognising a problem early enough to flag it.

**The AM owns:** domain/mailbox setup and warmup, DNS authentication (SPF/DKIM/DMARC), blacklist removal,
workspace-level throttling.

---

## Healthy Benchmarks (diagnose against these)

- Bounce rate under 2%
- Raw reply rate above 5% to sustain sending (see "Raw reply rate" note below - this is the one place in
  the OS that tracks raw reply rate rather than PRR)
- 100% email verification before every campaign
- Plain text only, no HTML, no images

### Bounce rate

The authoritative standard: regardless of industry, keep bounce rate at 2% or less. 2-5% is still
acceptable but may signal list hygiene issues worth checking. Anything over 5% is detrimental to sending
reputation long-term - ESPs may start treating the domain as untrustworthy.

| Type | Definition | What it usually means |
|------|-----------|----------------------|
| Hard (5xx) | Permanent, address invalid | List quality (GTME's to fix, re-verify/remove) |
| Soft (4xx) | Temporary, server issue | Usually self-resolves, retries 2-3 times |

| Rate | Status | Likely cause |
|------|--------|--------------|
| Under 2% | Healthy | - |
| 2-3% | Acceptable, monitor | Usually list quality, re-verify |
| 3-5% | Acceptable but investigate | Could be list quality or infrastructure, diagnose which before assuming either |
| Over 5% | Critical | Pause immediately, flag the AM in case it's infrastructure-side |

Bounce rate is one signal. Raw reply rate is the other, see the note below.

### Raw reply rate (the one deliberate exception to PRR)

Every other benchmark in this OS is PRR (`sops/campaign-performance-standards.md`). This table is the one
exception: it diagnoses inbox placement (is the mailbox landing at all), a different question to PRR (is
the copy working). PRR near-zero doesn't distinguish "bad copy" from "mailbox in spam" - total reply rate
does, so it stays tracked here specifically for that purpose. Do not read this table against the PRR scale.

| Raw reply rate | Status |
|-----------|--------|
| Over 15% | Excellent |
| Over 10% | Good |
| Over 5% | Minimum for sustained sending |
| Under 2.8% | Danger zone, mailboxes are decaying or falling into spam, see `sops/solving-campaign-issues.md` |

---

## Symptom, Likely Cause, Who Owns It

| Symptom | Likely cause | Owner |
|---------|-------------|-------|
| Bounce rate climbing, no DNS change | List quality, stale or bad data | GTME - re-verify, remove role-based/catch-all |
| Domain blacklisted | Infrastructure/reputation issue | AM - flag immediately, see `gtm-skills/incident-responder.md` Protocol A |
| Warmup disabled ("red flame" in Instantly) | Usually a DNS problem | AM |
| SPF/DKIM/DMARC failing | DNS misconfiguration | AM |
| Open rate dropped sharply, subject lines unchanged | Sender reputation or infrastructure | AM to check reputation tools; GTME can still check for spam-trigger words creeping into copy |
| Reply rate dropped, deliverability metrics otherwise healthy | Copy/offer/targeting | GTME - run `gtm-skills/campaign-optimiser.md` |

When in doubt, run `gtm-skills/deliverability-doctor.md`'s triage first, it separates infrastructure causes
from list/copy causes before you flag anyone.

---

## List Verification (GTME-owned)

Verify 100% of emails before every campaign. Non-negotiable.

| Tool | Cost | Accuracy |
|------|------|----------|
| ZeroBounce | $0.008/email | 98%+ |
| NeverBounce | $0.008/email | 97%+ |
| Findymail | ~$0.01/email | 99%+ B2B |
| MillionVerifier | $0.0005/email | 95%+ |
| Bouncer | $0.008/email | 97%+ (EU/GDPR) |

- Re-verify lists older than 30 days.
- Remove "unknown" and "catch-all" results, or treat with caution.
- Remove role-based emails (info@, admin@, sales@).
- Remove free email providers for B2B.

---

## Compliance Basics (affects copy, so this is GTME's to know)

### CAN-SPAM (US)

Accurate From/Reply-To headers, non-deceptive subject lines, a valid physical postal address in the footer,
a clear opt-out, and opt-outs honoured within 10 business days. B2B cold email is compliant with unsubscribe
+ physical address, no prior consent required.

### GDPR (EU/UK)

Legitimate Interest is the usual legal basis for B2B cold email (must be relevant to the recipient's
professional role). Germany generally requires consent instead. Compliant footer:

```
You are receiving this because of your role as {{Role}} at {{Company}}.
To opt out, reply "unsubscribe" or click here: [link]
Privacy policy: [link]
```

GDPR-flagged replies (legal language, data requests) escalate to Aaron (the GTME's manager/team lead,
`sops/am-gtme-responsibility-split.md`), not a solo call, see `gtm-skills/reply-handler.md` and
`gtm-skills/incident-responder.md`.

---

## When to Flag the AM

- Domain blacklisted, or any blacklist-monitoring alert
- Warmup disabled / red flame in Instantly
- SPF, DKIM, or DMARC failing
- Workspace-level sending throttled
- Mailbox or domain provisioning for a new client or new capacity

Activating an existing pre-warm pile for a client (`sops/onboarding-24-hour.md`,
`sops/solving-campaign-issues.md`) is a GTME software action within the sending tool, not new
provisioning, it's not on this list.

See `sops/am-gtme-responsibility-split.md` for the full ownership split.

---

## Source Material
Synthesised from ColdIQ GTM Skills cold-email master skill - deliverability-guide, email-infra-guide, and email-infra-troubleshooting resources. Trimmed to GTME scope; the AM's execution detail (DNS setup, blacklist removal, warmup scheduling) lives outside this repo.
