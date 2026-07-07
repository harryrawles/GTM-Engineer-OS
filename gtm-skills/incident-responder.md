---
name: incident-responder
description: Incident protocols for deliverability blacklist, bounce spike, bad reply going public, Instantly outage, client data exposure. Triages severity, runs the right protocol, escalates to Harry, manages client communication, logs post-mortem.
triggers:
  - "Incident: {{description}}"
  - "Domain blacklisted"
  - "Bounce spike"
  - "Bad reply going public"
  - "Instantly is down"
  - "Client data exposure"
  - "Run incident responder"
reads:
  - "wiki/_skill-context.md"
  - "wiki/deliverability.md"
  - "clients/{slug}/campaign-state.md"
  - "clients/{slug}/overview.md"
writes:
  - "clients/{slug}/decision-log.md (incident entry)"
  - "clients/{slug}/comms-log.md (client communication)"
  - "clients/{slug}/campaign-state.md (campaign status updates)"
---

# Skill: Incident Responder

**Trigger:** "Incident: {{description}}", "Domain blacklisted", "Bounce spike", "Bad reply going public", "Instantly is down", "Client data exposure", "Run incident responder"

**Context:** When something breaks badly. This skill runs the right protocol, escalates appropriately, manages client communication, and logs the post-mortem so it never happens the same way again.

**The incident responder's job is calm, structured action - not heroics.**

---

## STANDARD CONTEXT

See `wiki/_skill-context.md`.

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

## STEP 1 - Classify the Incident

Identify the type:

| Type | Symptoms | Protocol |
|------|---------|---------|
| **A: Domain blacklisted** | MXToolbox shows listing, sending drops, bounces spike | Protocol A |
| **B: Bounce rate spike** | Bounce >4% suddenly, no DNS change explanation | Protocol B |
| **C: Bad reply going public** | Prospect threatens legal, screenshots on social, GDPR complaint | Protocol C |
| **D: Sender platform outage** | Instantly / Smartlead / HeyReach down | Protocol D |
| **E: Client data exposure** | Lead list leaked, unauthorised access, GDPR breach | Protocol E |
| **F: Other** | Anything else affecting client or campaigns | Protocol F |

If multiple types active → handle the most severe first.

---

## STEP 2 - Assess Severity

| Severity | Definition | Notification | Time horizon |
|----------|-----------|--------------|--------------|
| **Critical** | Campaigns must stop now. Client risk imminent. | Harry + client (immediately) | Resolve within 4 hours |
| **High** | Active impact but contained. | Harry (immediately), client (within 24h) | Resolve within 24 hours |
| **Medium** | Limited impact, investigating. | Harry (within 1 hour) | Resolve within 72 hours |
| **Low** | Watch only, no action yet | Harry (next morning) | Monitor |

Default to higher severity if unsure. Easier to step down than escalate late.

---

## PROTOCOL A - Domain Blacklisted

### Immediate (first 30 minutes)

1. **Pause all campaigns** from affected sending domains
2. **Check which blacklists** (run MXToolbox: mxtoolbox.com/blacklists.aspx)
3. **Identify scope:**
   - Which domain(s)?
   - Which IPs?
   - Which clients affected (if domains shared across clients - they shouldn't be, but check)?
4. **Notify Harry** with: domain, blacklist name, scope, time first detected

### Within 2 hours

5. **Submit removal requests** per blacklist:
   - Spamhaus: spamhaus.org/lookup → request removal
   - Barracuda: barracudacentral.org → self-service
   - SpamCop: auto-expires 24-48h, no action needed
   - SORBS: sorbs.net → self-service
6. **Diagnose root cause** (see decision tree below)
7. **Notify affected client(s)** with the standard template:

```
Subject: [Important] Brief deliverability pause - {{CLIENT_NAME}} campaigns

{{firstName}},

Quick heads-up: one of our sending domains hit {{blacklist}} earlier today. I've paused all sequences as a precaution and submitted removal requests.

Expected resolution: 24-48 hours.
What this means: sends are paused, no further bounces. Replies still come through normally.

I'll send an update tomorrow morning.

Cause investigation in progress. Will share post-mortem after resolution.

Harry
```

### Diagnosis decision tree

- **Bounce rate spiked first → blacklist followed:** list quality issue. Re-verify all active lists.
- **No bounce spike, sudden blacklist:** content trigger (spam-trigger words) or volume too high → audit recent copy and send rates
- **Multiple blacklists at once:** infrastructure-wide issue → check DNS records, recent changes, IP rotation
- **Single blacklist, single domain:** likely an unfortunate reporter (spam trap hit, complaint cluster) → wait for natural expiry if SpamCop; otherwise submit removal

### After resolution (within 7 days)

8. **Post-mortem** logged to `clients/{slug}/decision-log.md`:
```
### {{date}} - Incident: Blacklist on {{domain}}

**What happened:**
- Detected: {{time}}
- Blacklist: {{name}}
- Domain: {{name}}
- Scope: {{clients/campaigns}}

**Root cause:**
{{Specific root cause confirmed after investigation}}

**Resolution:**
- Removal submitted: {{time}}
- Listing cleared: {{time}}
- Sends resumed: {{date}}

**Prevention:**
- {{Specific change to prevent recurrence}}

**Cost:**
- {{n}} hours of paused sends = ~{{n}} sends missed
- Estimated PRR impact: {{n}} replies lost
```

9. **Update infrastructure runbook** if root cause has a systemic fix

---

## PROTOCOL B - Bounce Rate Spike

### Immediate (first 15 minutes)

1. **Pause campaigns with bounce >4%** immediately
2. **Identify scope:** which campaigns, which mailboxes, which lists
3. **Check: did anything change in last 24h?**
   - New list loaded?
   - New copy launched?
   - DNS records modified?
   - Mailbox quota changed?
4. **Notify Harry** with bounce rate, scope, suspected cause

### Within 1 hour

5. **Re-verify the active list** with ZeroBounce or NeverBounce
6. **Remove all "invalid" and "unknown" entries** from active sequences
7. **Audit bounce reasons** in Instantly (hard vs soft, error codes)
8. **If hard bounces >3%** → list quality issue
9. **If soft bounces >5%** → reputation / domain issue
10. **If complaints >0.3%** → copy is hitting spam filters

### Action by cause

| Cause | Action |
|-------|--------|
| List quality | Re-verify, remove bad data, throttle to 50% volume for 7 days while reputation recovers |
| Domain reputation | Pause campaigns, run warmup at 10-20/day for 7+ days, then resume at low volume |
| Spam trigger in copy | Audit subject + body for spam triggers, A/B test cleaned variant before resuming |
| Mailbox limit hit | Throttle send rate, verify mailbox quota |

### Within 24 hours

11. **Resume sends gradually:** start at 25% of normal volume, monitor for 24h, scale to 50%, then 75%, then full
12. **Notify Harry** of resolution
13. **Notify client** if pause exceeded 24 hours

### Post-mortem

Logged to `clients/{slug}/decision-log.md` per template above.

---

## PROTOCOL C - Bad Reply Going Public / Brand Risk

### Immediate (first 10 minutes)

1. **DO NOT respond** to the original prospect
2. **DO NOT delete or edit** the original cold email (audit trail)
3. **Screenshot or save** the public post / threat
4. **Notify Harry IMMEDIATELY** - this is a brand risk, not a deliverability issue
5. **Notify client** ONLY after Harry has reviewed and agreed on the response

### Within 1 hour

6. **Assess:**
   - Is this a fair complaint? (Wrong-fit targeting, aggressive copy, etc.)
   - Is it a GDPR / CAN-SPAM issue?
   - Is the person threatening legal action?
   - Is it gaining traction (likes, comments, shares)?

7. **Decide response approach:**
   - **No public response if:** isolated, low engagement, no legal threat → let it die
   - **Private DM to prospect if:** they have a fair grievance, low public engagement → apologise, suppress, move on
   - **Public response if:** high engagement OR misrepresentation OR legal threat → coordinate with client, may need formal statement

8. **If legal threat:**
   - Notify Harry immediately, full stop
   - Do not respond to prospect
   - Preserve all comms in writing
   - Escalate to client (they may have legal counsel)

### Same day

9. **Suppress the prospect's email** globally across all clients
10. **Audit the campaign** that triggered the reply:
    - Is the copy too aggressive?
    - Is the ICP wrong?
    - Are we hitting protected categories?
11. **Update `wiki/objection-library.md`** if pattern is novel

### Post-mortem

```
### {{date}} - Incident: Public negative reply / brand risk

**What happened:**
- Prospect: {{name, role, company}} (do not name in public docs unless required)
- Original campaign: {{name}}
- Public surface: {{platform, link}}
- Severity: {{level}}
- Legal action threatened: {{Y/N}}

**Root cause:**
{{e.g. ICP miss - they were on a "no contact" list we didn't have; aggressive Email 3 angle landed wrong; etc.}}

**Resolution:**
{{What we did}}

**Prevention:**
- {{Specific change - e.g. add this list to suppression; soften Email 3; etc.}}
```

---

## PROTOCOL D - Sender Platform Outage (e.g. Instantly down)

### Immediate (first 30 minutes)

1. **Verify it's a platform issue:** check status page (status.instantly.ai), Twitter mentions
2. **Identify scope:** which clients affected
3. **Notify Harry** with: confirmed outage, expected duration if known, affected clients
4. **Do NOT switch to backup tool reactively** - most outages resolve in <2 hours and switching causes more harm

### During outage

5. **Monitor status page** every 30 minutes
6. **If outage >4 hours** → notify affected clients with:

```
Subject: [Heads-up] Brief Instantly outage - campaigns paused

{{firstName}},

Quick note: Instantly is experiencing a brief outage. Campaigns are paused while the platform comes back up.

Expected resolution: {{from status page}}
Replies in your inbox are unaffected - they keep coming through as normal.

I'll send an update once resolved.

Harry
```

### After resolution

7. **Verify all campaigns resumed correctly**
8. **Check for any data loss** (missed sends, missed replies)
9. **Post-mortem** if outage >4 hours or affected client commits

---

## PROTOCOL E - Client Data Exposure / GDPR Breach

### CRITICAL - escalate immediately

1. **Stop all sends** from affected client immediately
2. **Notify Harry within 5 minutes** - no other notifications until Harry reviews
3. **Do NOT notify the client** until Harry has assessed legal posture
4. **Preserve evidence:** screenshots, access logs, the exposed data itself
5. **Do not attempt to "fix"** by deleting data - preserve for legal

### Within 1 hour

6. **Assess scope:**
   - What data was exposed? (names, emails, deeper PII?)
   - How many records?
   - Who had access?
   - Was data accessed by unauthorised party (vs just exposed)?
7. **Harry consults with client** on legal obligations:
   - GDPR breach notification (72 hours from awareness)
   - State-level breach notification (varies)
   - Insurance / liability

### Decision: client notification

This is Harry's call, not the OS's. Default is: full transparency, immediate notification, written confirmation, support during their breach response.

### Post-mortem

Required. Comprehensive. May involve legal counsel. Stored separately from normal decision-log if sensitivity warrants.

---

## PROTOCOL F - Other Incident

Use this when the type doesn't match A-E. Template:

1. Pause active operations affected by the incident
2. Notify Harry within 30 minutes
3. Identify scope and severity
4. Decide on client notification per severity matrix
5. Execute fix
6. Post-mortem within 7 days

---

## RULES

- **No protocol is automatic.** Every incident needs Harry's eyes before client notification.
- **Pause before fixing.** Stopping the bleed comes first.
- **Document everything.** Every action, every time. Audit trail matters.
- **Honest communication.** When notifying clients, be specific about what happened and what we're doing. Vague reassurance damages trust more than honest disclosure.
- **Never delete evidence.** Even if it's embarrassing. Especially if it's embarrassing.
- **Post-mortem within 7 days, no exceptions.** If we don't capture the lesson, the incident repeats.
- **Critical incidents:** Harry first, client second, OS third. People before files.

---

## EXAMPLES

### Example - domain blacklisted

```
Harry: Incident: {{SENDING_DOMAIN}} just appeared on Spamhaus

Claude:
=== INCIDENT - Severity Critical ===
Protocol A activated.

Immediate actions taken:
- Paused Hiring Signal v4 (uses {{SENDING_DOMAIN}})
- Paused Funding v2 (uses {{SENDING_DOMAIN}})
- Scope: {{CLIENT_NAME}} only
- Spamhaus listing confirmed: SBL-CSS reason "low complaint volume but high bounce"

Diagnosis (preliminary):
- Bounce rate spiked to 5.8% in last 48h (was 1.2% prior)
- Recent change: lead list refresh on 2026-05-27
- Likely root cause: list quality regression - bad enrichment source

Next actions:
1. Submit Spamhaus removal request (you confirm)
2. Re-verify the May 27 list with ZeroBounce
3. Notify {{PRIMARY_CONTACT}} at {{CLIENT_NAME}} (draft below)
4. Investigate enrichment source change

Client notification draft:
[paste from Protocol A template]

Confirm Harry to proceed with each step.
```
---

## SUB-AGENT USAGE

For Protocols A (blacklist) and D (platform outage), spawn a general-purpose sub-agent for external fact lookups. See wiki/_subagent-patterns.md Pattern 2.

### Protocol A - blacklist lookup

Spawn sub-agent with prompt:
```
Look up current status of {{domain}} on the following blacklists: Spamhaus ZEN, Spamhaus DBL, Barracuda BRBL, SpamCop, SORBS, URIBL.

For each: report listing status (LISTED / CLEAN) and, if listed, the exact removal procedure and expected timeline.

Use public lookup tools (MXToolbox blacklist check, MultiRBL, individual blacklist sites). Do NOT submit removal requests - just gather information.

Return as a table.
```

### Protocol D - platform outage

Spawn sub-agent with prompt:
```
Check current status of Instantly platform via: status.instantly.ai, Instantly Twitter / X account, Reddit r/Instantly, recent outage reports.

Return:
1. Current status (UP / DEGRADED / DOWN)
2. If DOWN/DEGRADED: estimated resolution time per their communications
3. Affected functionality scope
4. Any workarounds being communicated

Use only verified public sources. Do not infer status from absence of information.
```

### Why this matters

External fact lookups during incidents need to be FAST and AUTHORITATIVE. The main thread shouldn't pause incident handling to fetch status pages. Sub-agent runs in parallel; main thread continues protocol execution.