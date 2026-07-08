# Glossary

All acronyms and specialist terms used across this OS, defined.

When a skill or wiki file uses an unexplained term, look it up here.

---

## Performance Metrics

> These map to specific stages of the 7-stage acquisition funnel (Latent Conditions → Attention →
> Interest → Appointment → Show → Primed Prospect → Closed Deal) - see
> `wiki/acquisition-systems-theory.md` Section 4.

| Term | Stands for | Definition |
|------|-----------|------------|
| **PRR** | Positive Reply Rate | Replies expressing interest, excluding negatives and OOOs. Our primary KPI. |
| **Reply rate** | - | Total replies / sends. Includes negatives and OOOs. Noisier than PRR. |
| **Open rate** | - | Opens / sends. Heavily inflated by Apple Mail Privacy Protection. Largely vanity. |
| **ABR** | Appointment Booking Rate | Meetings booked / sends. Downstream of PRR. |
| **Bounce rate** | - | Hard bounces / sends. Must stay below 2%. |
| **CTR** | Click-Through Rate | Clicks / opens. Rarely used in cold email (no links in body). |
| **OOO** | Out of Office | Auto-reply during recipient absence. Re-queue, do not count as reply. |
| **LVR** | Loom View Rate | Loom/video opens / sends. Used for video-first outreach. |
| **SUR** | Show-Up Rate | Calls attended / appointments booked. Downstream of ABR. |
| **SCR** | Sales Conversion Rate | Clients closed / calls attended (or / offers made). Downstream of SUR. |
| **CTOR** | Call-to-Offer Rate | Offers made / calls attended. |
| **FCR** | Funnel Conversion Rate | Overall macro conversion - clients closed / total top-of-funnel input. |

## Audience and Targeting

| Term | Stands for | Definition |
|------|-----------|------------|
| **ICP** | Ideal Customer Profile | The specific profile of companies/people we target. |
| **ICC** | Ideal Customer Criteria | The filterable attributes that define ICP. |
| **ABM** | Account-Based Marketing | 1:1, 1:few, or 1:many approaches tailored to specific accounts. |
| **TAM** | Total Addressable Market | All companies that could theoretically buy. |
| **ATL** | Above-the-Line | VP, C-Level, Director, Head of. Strategic messaging. |
| **BTL** | Below-the-Line | Manager, Specialist, Analyst, Coordinator, IC. Operational messaging. |
| **DM** | Decision Maker | Person who signs the purchase. |

## Sales and Channels

| Term | Definition |
|------|-----------|
| **Cold email** | Unsolicited email to a target who has no prior relationship. |
| **Outbound** | Sales motion initiated by us. |
| **Inbound** | Sales motion initiated by prospect (form fill, demo request). |
| **Postbound** | Marketing-engaged leads who have not requested contact. |
| **Bridgebound** | Outbound with a relationship or warm signal. |
| **CTA** | Call To Action. The single ask in the email. |
| **ZOR** | Zone Of Resistance. Prospect's psychological friction. |
| **SDR** | Sales Development Rep. Outbound prospecting role. |
| **AE** | Account Executive. Closing role. |

## Deliverability and Infrastructure

| Term | Stands for | Definition |
|------|-----------|------------|
| **SPF** | Sender Policy Framework | DNS record listing authorised sending servers. |
| **DKIM** | DomainKeys Identified Mail | Cryptographic signature on outgoing email. |
| **DMARC** | Domain-based Message Authentication, Reporting and Conformance | Policy for handling SPF/DKIM failures. |
| **MX** | Mail Exchange | DNS record pointing to email provider. |
| **CAN-SPAM** | Controlling the Assault of Non-Solicited Pornography And Marketing Act | US email compliance law. |
| **GDPR** | General Data Protection Regulation | EU data privacy law. |
| **LIA** | Legitimate Interest Assessment | GDPR documentation for lawful basis. |
| **RFC 8058** | - | One-click unsubscribe standard for bulk senders. |
| **Warmup** | - | Gradual ramp of email volume to build sender reputation. |
| **Catch-all** | - | Domain accepts all email; verification is unreliable. |

## Tools and Tech

| Term | Definition |
|------|-----------|
| **MCP** | Model Context Protocol. How Claude connects to external tools (Instantly, Notion, etc.). |
| **Instantly** | Email sending platform. Primary tool for outbound campaigns. |
| **HeyReach** | LinkedIn automation platform. |
| **Clay** | Enrichment and data workflow platform. |
| **RB2B** | Reveal Business 2 Business. Identifies anonymous website visitors. |
| **Trigify** | Signal detection tool (LinkedIn engagement). |
| **Apollo** | Lead database and outreach platform. |
| **Findymail** | Email finder + verifier. |
| **Bombora** | Third-party intent data provider. |
| **6sense** | Predictive intent platform. |
| **Common Room** | Community and signal aggregation. |
| **AI SDR** | The autonomous sending/prospecting agent that runs a client's outbound campaigns. A distinct system from the AI Reply Agent, see `sops/onboarding-24-hour.md`. |
| **AI Reply Agent** | Handles inbound replies to a client's campaigns. A distinct system from the AI SDR, see `sops/onboarding-24-hour.md`. |
| **Cowork** | Claude's AI assistant, queried as the first step when stuck on a client per `sops/gtme-unlock-ladder.md`, before escalating to the support channel or `#grill-my-campaigns`. |

## Services and Engagement

| Term | Stands for | Definition |
|------|-----------|------------|
| **DFY** | Done For You | Fully managed retainer service. |
| **DWY** | Done With You | Build + train hybrid engagement. |
| **MRR** | Monthly Recurring Revenue | Client billing per month. |
| **ACV** | Annual Contract Value | Total annual deal size. |
| **LTV** | Lifetime Value | Total revenue over relationship. |
| **NPS** | Net Promoter Score | Client satisfaction metric. |
| **QBR** | Quarterly Business Review | Quarterly check-in with client. |
| **SLA** | Service Level Agreement | Commitments to client (response times, etc.). |

## Methodology

| Term | Definition |
|------|-----------|
| **Signal** | Trigger event indicating buying intent (funding, hiring, job change, etc.). |
| **Persona** | Specific role/title we target. Different from ICP (which is firmographic). |
| **Sequence** | Multi-step email campaign (typically 3-4 emails). |
| **Variant** | A version of an email used in A/B testing. |
| **Control** | The current best-performing variant in a test. |
| **Spintax** | Notation for randomised text variation at send time. Format and process: `gtm-skills/spintax-ninja.md`. |
| **Liquid syntax** | Dynamic variable insertion at send time. |
| **Bar test** | Could you say this out loud at a bar without sounding like a salesperson? |

## Internal Acronyms

| Term | Definition |
|------|-----------|
| **OS** | Operating System. This multi-client repo: a shared layer plus one isolated `clients/{slug}/` folder per client. |
| **Wiki** | Shared knowledge base in `wiki/` - same for every client (part of the shared layer). |
| **Skill** | A defined AI workflow in `gtm-skills/`. |
| **Compounding loop** | The Friday weekly-reviewer flow that makes the OS smarter over time. |