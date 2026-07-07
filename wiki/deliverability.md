# Deliverability

Deliverability is upstream of every metric. Bad deliverability = nothing else matters. This file covers infrastructure setup, authentication, warmup, monitoring, and recovery.

**The non-negotiables:**
- 3-5 outreach domains (NEVER send cold from the primary domain)
- 2-3 mailboxes per domain
- 30-50 cold emails per mailbox per day (max)
- 4-8 weeks warmup before any cold send
- 100% email verification before every campaign
- Bounce rate under 2%
- Plain text only - no HTML, no images
- Reply rate above 5% to sustain sending

---

## 1. Email Authentication (SPF / DKIM / DMARC)

### SPF - Sender Policy Framework

Tells receiving servers which IPs are authorised to send for the domain.

**Setup - TXT record at root:**
```
Host: @
Type: TXT
Value: v=spf1 include:_spf.google.com ~all
```

**Multiple providers:**
```
v=spf1 include:_spf.google.com include:spf.protection.outlook.com -all
```

**Common mistakes:**
- Multiple SPF records (only ONE allowed per domain - merge them)
- Using `+all` instead of `~all` or `-all`
- Exceeding 10 DNS lookups (each `include:` counts)

### DKIM - DomainKeys Identified Mail

Adds a cryptographic signature proving emails were not tampered with.

**Setup (Google Workspace):**
1. Google Admin → Apps → Gmail → Authenticate Email
2. Generate DKIM key (2048-bit recommended)
3. Add TXT: `Host: google._domainkey` → value `v=DKIM1; k=rsa; p=[public-key]`
4. Back in Google Admin, click "Start Authentication"

**Verify:** Send test email → check headers for `dkim=pass`.

### DMARC - Domain-based Message Authentication

Tells receiving servers what to do when SPF or DKIM fails.

**Progressive setup:**
```
# Weeks 1-2: monitor only
v=DMARC1; p=none; rua=mailto:dmarc@yourdomain.com

# Weeks 3-4: quarantine failures
v=DMARC1; p=quarantine; pct=50; rua=mailto:dmarc@yourdomain.com

# Week 5+: reject failures (full protection)
v=DMARC1; p=reject; rua=mailto:dmarc@yourdomain.com
```

**TXT record:** Host `_dmarc` → above value.

### Verification Checklist

- [ ] SPF: `dig TXT yourdomain.com` shows `v=spf1`
- [ ] DKIM: headers show `dkim=pass`
- [ ] DMARC: `dig TXT _dmarc.yourdomain.com` shows policy
- [ ] mail-tester.com or MXToolbox returns clean

---

## 2. Domain Warmup

### Schedule (new domain)

| Week | Cold emails/day | Warmup emails/day | Notes |
|------|----------------|------------------|-------|
| 1 | 0 | 5-10 | Warmup only |
| 2 | 0 | 10-20 | Warmup only |
| 3 | 5-10 | 15-25 | Begin cold cautiously |
| 4 | 10-20 | 20-30 | Monitor bounces |
| 5-6 | 20-30 | 20-30 | Gradual increase |
| 7-8 | 30-40 | 15-20 | Near steady state |
| 9+ | 30-50 | 10-20 | Full operations, keep warmup running |

### Warmup tools

| Tool | Price | Notes |
|------|-------|-------|
| Instantly (built-in) | Included | Peer network warmup |
| Lemwarm | Included with Lemlist | Auto-adjusts volume |
| Mailreach | $25/mo per mailbox | Detailed reports |
| Warmbox | $19/mo per mailbox | Standalone option |

### Rules

- **Never stop warmup.** Keep 10-20/day even during active campaigns.
- Warmup emails should come from real-looking domains.
- Ensure replies and "move to primary" actions happen.
- Monitor sender score throughout.

### Domain age requirements

| Age | Status | Recommendation |
|-----|--------|---------------|
| 0-2 weeks | Brand new | No email. DNS, mailboxes, warmup setup. |
| 2-4 weeks | Fresh | Warmup only. No cold. |
| 4-8 weeks | Warming | Begin mixing cold per schedule. |
| 8-12 weeks | Establishing | Moderate volume (30-50/mailbox/day). |
| 12+ weeks | Established | Full operations. |
| 6+ months | Mature | Can push slightly higher if reputation supports. |

**Minimum before first cold email:** 4 weeks (2 weeks aging + 2 weeks warmup)
**Ideal:** 6-8 weeks

---

## 3. Infrastructure Architecture

### Domain strategy

```
PRIMARY DOMAIN (NEVER for cold):
  clientcompany.com → website, support, team email

COLD OUTREACH DOMAINS (3-5):
  clientcompany.co
  getclientcompany.com
  tryclientcompany.com
  clientcompanyhq.com
  withclientcompany.com
```

### Rules

- 2-5 domains per sender for rotation
- 2-3 mailboxes per domain
- Domain naming clearly related to brand
- Let domains age 2-4 weeks before warmup
- One sending tool per domain - never mix providers on same domain

### Provider limits

| Provider | Technical limit | Safe cold limit |
|----------|----------------|----------------|
| Google Workspace | 2,000/day | 30-50/day per mailbox |
| Google (new account first 24h) | 500/day | 5-10/day during warmup |
| Microsoft 365 | 10,000/day | 30-50/day per mailbox |
| Gmail (free) | 500/day | DO NOT USE for cold |

### Complete DNS checklist

```
1. MX Records        → Points to email provider
2. SPF (TXT)         → v=spf1 include:[providers] -all
3. DKIM (TXT/CNAME)  → [selector]._domainkey → public key
4. DMARC (TXT)       → _dmarc → policy
5. Tracking CNAME    → track.[domain] → [tool tracking server]
6. Return-Path CNAME → If required by sending tool
7. A Record          → Web server (landing / unsubscribe pages)
```

---

## 4. Inbox Placement

### Plain text vs HTML

| Factor | Plain text | HTML |
|--------|-----------|------|
| Deliverability | Better | Worse |
| Trust signal | Feels personal | Feels like marketing |
| Tracking | Limited (no pixel) | Open tracking possible |
| Rendering | Universal | Can break |
| Cold email best practice | **Use this** | Avoid for cold |

**Rule: Plain text for cold email. Always.**

### Sending time optimisation

- Send during recipient's business hours (9 AM - 5 PM local)
- Peak windows: 8-10 AM and 1-3 PM (Tuesday-Thursday)
- Random delays between sends: 30-120 seconds
- Vary send times day-to-day (not always 9:00 AM)

### Reply rate impact

Reply rate is the single most powerful positive signal.

| Reply rate | Status |
|-----------|--------|
| Over 15% | Excellent - strong positive reputation |
| Over 10% | Good - inbox placement stable |
| Over 5% | Minimum for sustained sending |
| Under 3% | Danger zone - deliverability will degrade |

---

## 5. Bounce Management

### Hard vs soft

| Type | Definition | Action |
|------|-----------|--------|
| Hard (5xx) | Permanent - address invalid | Remove immediately. Never retry. |
| Soft (4xx) | Temporary - server issue | Retry 2-3 times over 24-72 hours |

### Acceptable bounce rates

| Rate | Status | Action |
|------|--------|--------|
| Under 1% | Excellent | Maintain |
| 1-2% | Acceptable | Monitor |
| 2-3% | Warning | Run verification |
| 3-5% | Dangerous | Pause campaigns. Clean list. |
| Over 5% | Critical | Stop immediately. |

### Email verification

**Verify 100% of emails before every campaign. Non-negotiable.**

| Tool | Cost | Accuracy |
|------|------|----------|
| ZeroBounce | $0.008/email | 98%+ |
| NeverBounce | $0.008/email | 97%+ |
| Findymail | ~$0.01/email | 99%+ B2B |
| MillionVerifier | $0.0005/email | 95%+ |
| Bouncer | $0.008/email | 97%+ (EU/GDPR) |

### Verification rules

- Re-verify lists older than 30 days.
- Remove "unknown" and "catch-all" results, or treat with caution.
- Remove role-based emails (info@, admin@, sales@).
- Remove free email providers for B2B.
- Verification costs ($0.005-0.01/email) are trivial vs damaged reputation.

---

## 6. Blacklist Monitoring

### Major blacklists

| Blacklist | Severity | Notes |
|-----------|----------|-------|
| Spamhaus ZEN | Critical | Used by ~80% of ISPs |
| Spamhaus DBL | Critical | Domain-based |
| Barracuda BRBL | High | Corporate gateways |
| SpamCop | Medium-high | Auto-expires 24-48 hours |
| SORBS | Medium | Multiple lists |
| URIBL / SURBL | High | Checks domains in email body |

### How to check

- **MXToolbox:** mxtoolbox.com/blacklists.aspx (100+ blacklists)
- **MultiRBL:** multirbl.valli.org (300+ blacklists)
- **Google Postmaster Tools:** domain/IP reputation with Gmail
- **Microsoft SNDS:** reputation with Outlook/Hotmail

**Frequency:** daily during warmup, weekly during active campaigns.

### Removal

| Blacklist | Process | Timeline |
|-----------|---------|----------|
| Spamhaus | Submit at spamhaus.org | 24-48 hours |
| Barracuda | Self-service at barracudacentral.org | 12-24 hours |
| SpamCop | Auto-expires | 24-48 hours |
| SORBS | Self-service at sorbs.net | Varies |

---

## 7. Compliance

### CAN-SPAM (US)

Requirements:
1. Accurate "From" and "Reply-To" headers
2. Non-deceptive subject lines
3. Valid physical postal address in footer
4. Clear opt-out explanation
5. Honour opt-outs within 10 business days

CAN-SPAM does NOT require prior consent. B2B cold email is compliant with unsubscribe + physical address.

**Penalties:** Up to $51,744 per email in violation.

### GDPR (EU/UK)

**Legal bases for B2B cold email:**
- Legitimate Interest (Article 6(1)(f)) - most common. Conduct an LIA. Email must be relevant to professional role.
- Consent (Article 6(1)(a)) - required in some countries (notably Germany).

**Country-specific:**

| Country | B2B cold email |
|---------|---------------|
| UK | Permitted (legitimate interest) |
| France | Permitted if relevant to professional role |
| Germany | Very restrictive - consent generally required |
| Netherlands | Permitted with legitimate interest |
| Nordics | Generally permit with legitimate interest |

**Compliant footer:**
```
You are receiving this because of your role as {{Role}} at {{Company}}.
To opt out, reply "unsubscribe" or click here: [link]
Privacy policy: [link]
```

**Penalties:** Up to 4% of global annual revenue or EUR 20M.

### RFC 8058 - One-click unsubscribe

Required since February 2024 for bulk senders (5,000+/day to Gmail/Yahoo).

```
List-Unsubscribe: <https://yourdomain.com/unsubscribe?id=token>, <mailto:unsubscribe@yourdomain.com>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
```

Most cold email tools (Instantly, Smartlead, Lemlist) add these automatically.

---

## 8. Pre-Launch Checklist

Before launching any cold campaign:

- [ ] 3-5 outreach domains purchased (NOT primary domain)
- [ ] Domains aged 2+ weeks
- [ ] Google Workspace or Microsoft 365 on each domain
- [ ] 2-3 mailboxes per domain
- [ ] SPF, DKIM, DMARC configured for each domain
- [ ] Custom tracking domain (CNAME) per domain
- [ ] Warmup running on every mailbox (2-4 weeks minimum)
- [ ] 100% email verification before loading campaigns
- [ ] Blacklist monitoring alerts set up
- [ ] Compliant templates (physical address, unsubscribe)
- [ ] Legitimate interest assessment (if emailing EU)

## 9. Active Campaign Monitoring

- [ ] Cold email volume: 30-50/mailbox/day
- [ ] Warmup tool running (10-20/day per mailbox)
- [ ] Bounce rate under 2%
- [ ] Spam complaint rate under 0.1%
- [ ] Reply rate over 5%
- [ ] Blacklists checked weekly
- [ ] Google Postmaster + Microsoft SNDS reviewed weekly
- [ ] Plain text emails (no HTML / images)
- [ ] Sending during business hours in recipient timezone
- [ ] Unsubscribes processed within 24 hours
- [ ] Mailbox rotation across campaigns
- [ ] Re-verify lists older than 30 days

---

## 10. Troubleshooting Common Issues

### "DNS records not found"
1. Wait 15 min - 48 hours for propagation
2. Verify records are saved in registrar panel
3. Flush DNS cache (`ipconfig /flushdns` Windows, `dscacheutil -flushcache` Mac)
4. Lower TTL to 300 seconds for faster propagation

### "Multiple SPF records detected"
Only ONE SPF record allowed per domain. Delete duplicates. Common with GoDaddy auto-creating SPF records.

### "DKIM authentication failed"
1. Re-generate the DKIM key
2. Copy the EXACT value - no extra spaces
3. Verify host: `google._domainkey` (Google) or `selector1._domainkey` / `selector2._domainkey` (Microsoft)
4. Wait 24 hours
5. Re-start authentication in admin panel

### "DMARC record missing"
Add manually. Never auto-configured.

### "Custom tracking domain not working"
1. Verify CNAME points to provider's tracking server
2. Cloudflare: proxy OFF (grey cloud)
3. Test: `nslookup [subdomain].yourdomain.com`

### Red flame in Instantly (warmup disabled)
**Cause:** high bounce rate on warmup emails. Usually a DNS problem.

**Recovery:**
1. Run "Test domain setup" - fix red items
2. Verify SPF, DKIM, DMARC
3. Check blacklists (MXToolbox)
4. Request reactivation code in Instantly → enter when received

### Bounce rate above 5% (campaign in danger)
1. Pause campaign immediately
2. Re-verify remaining list
3. Check if domain is blacklisted
4. Pause new sends for 7 days, run warmup at 10-20/day only
5. Resume slowly - 5-10 cold per mailbox per day, build back up

---

## Source Material
Synthesised from ColdIQ GTM Skills cold-email master skill - deliverability-guide, email-infra-guide, and email-infra-troubleshooting resources.