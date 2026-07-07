# Personalization at Scale

> **PRR conversion:** ColdIQ benchmarks use `reply rate` broadly. Our primary KPI is **PRR**. Rough conversion: `reply rate × 30-50% ≈ PRR`. So "22% reply rate" ≈ "6-11% PRR."

Personalisation is the difference between 6% and 22% reply rate. But over-personalisation kills scale. This file is the framework for personalising at volume without sounding like a robot or a stalker.

**Core rule:** Use AI for ONE specific part of the email, not the whole thing. Control messaging for split testing - static template + dynamic personalisation insert.

---

## When to Personalise (Decision Matrix)

| Factor | Personalise | Skip personalisation |
|--------|-------------|---------------------|
| Deal size | Over $25K ACV | Under $25K ACV |
| Volume | Under 50/day | Over 100/day |
| ICP fit | Tier 1 accounts | Tier 2-3 accounts |
| Signal strength | Weak signals | Strong signals (signal does the work) |
| Competitive | High competition | Low competition |

---

## The 6 Personalisation Buckets (Ranked by Value)

### Bucket 1 - Self-authored content (HIGHEST value)
What they have created themselves: speaking engagements, webinars, articles, posts.
**Why it works:** Direct thought-leadership reference. Proves you actually read them.

### Bucket 2 - Engaged content
What they have commented on, shared, liked.
**Why it works:** Shows what topics matter to them - without putting them on the spot for their own work.

### Bucket 3 - Self-identified traits
"About me" section, role description, headline.
**Why it works:** Uses their own words to frame relevance.

### Bucket 4 - Junk drawer
Personal interests, volunteer work, languages, schools.
**Why it works:** Builds rapport. Use sparingly - easy to feel creepy.

### Bucket 5 - Background centric
Tenure, career trajectory, awards, certifications, mutual connections, recommendations, boards, skill endorsements.
**Why it works:** Reference professional credibility without being sycophantic.

### Bucket 6 - Company level (24 data points)
Funding, hiring, news, M&A, growth, HQ moves, new products, integrations, marketing moves, competitor moves.
**Why it works:** Trigger-based, scales infinitely, low effort per lead.

---

## Hook Types - Strong vs Lite

### Strong Hook (Verbatim Tie)

Direct quote or reference from their content.

**Pattern:**
> "In your recent {{content_type}} about {{topic}}, you mentioned '{{direct_quote}}'..."

**Examples:**
> In your recent post about SDR burnout, you mentioned "the biggest issue is lack of quality leads"...
>
> Your article on RevOps made a point about "data silos killing deal velocity"...

**Use when:** Enterprise deal, high-value prospect, strong content to quote.

### Lite Hook (Conceptual Tie)

Reference the theme without direct quote.

**Pattern:**
> "I noticed you are focused on {{theme}}..."

**Examples:**
> Noticed you are scaling the BDR team at {{company}}.
>
> Saw you have been posting about RevOps challenges.

**Use when:** Higher volume, content is not quotable, time-constrained personalisation.

### Hook Selection Framework

| Situation | Hook | Effort |
|-----------|------|--------|
| Enterprise $100K+ deal | Strong | High |
| Mid-market $25-100K | Either | Medium |
| SMB / volume | Lite | Low |
| Champion already exists | Lite | Low |
| Competitive displacement | Strong | High |

---

## Personalisation Playbook by Category

Outreach falls into 4 categories. Each has a different first/second line structure.

### INBOUND (they showed signal first)
- **Line 1:** Trigger-based relevance ONLY
- **Line 2:** CTA to book time (optional: core-static relevance)

**Example:**
> Thanks for downloading the cold email playbook.
> Got 15 minutes to discuss how to apply it at {{company}}?

### POSTBOUND / BRIDGEBOUND (warm but not inbound)
- **Line 1:** Trigger-based relevance + ("but more importantly") personalisation
- **Line 2:** Personalisation hook + core-static relevance

**Example:**
> Saw you attended our webinar on signal-based outbound - but more importantly, your post about "outbound being dead" caught my attention.
> You mentioned reply rates dropping below 1%. We have been helping B2B SaaS hit 15%+ with signal-first targeting.
> Worth a quick chat?

### OUTBOUND (cold)
- **Line 1:** Personalisation title or summary + personalisation excerpt
- **Line 2:** Personalisation hook + core-static relevance

**Example:**
> Your post on SDR burnout - specifically the line "throwing bodies at the problem does not scale" - resonated.
> We work with SaaS doing $5-20M who have hit that wall. Most are shifting from volume to signal-based.
> Curious if that is on your radar?

### NO PERSONALISATION (automated / scale)
- **Line 1:** Core-static relevance (lean on pattern-interruptive opener)
- **Line 2:** Core-static relevance ("we work with...")

**Example:**
> Quick question: how is your team handling pipeline predictability right now?
> We work with B2B SaaS doing $5-20M who struggle with inconsistent lead flow.
> Worth exploring?

---

## Fallback - Core-Static Relevance (No Personalisation)

When personalisation data is unavailable, use these 5 angles:

1. **Demographic** - buyer persona
2. **Firmographic** - company segment
3. **Firmographic** - industry vertical
4. **Firmographic** - market geography
5. **Technographic** - tech stack

---

## AI Personalisation Prompts (Ready to Deploy)

These are designed to be dropped into Clay / Instantly / Smartlead. Each prompt produces ONE component. The static template handles everything else.

### Prompt 1 - ICP Identification

```
Find the top 3 most likely ICPs this person is prospecting based on {{companyDomain}}.
If unavailable, use {{companyDescription}}.

Rules:
- Keep ICPs to just job titles (max 3)
- Use shorter abbreviated alternatives (CEO not Chief Executive Officer)
- Always use "and" before the last example
- Never end with a full stop

Output examples:
- Input: Chief Executive Officer → CEOs
- Input: CEO, BDR, AE → CEOs, BDRs and AEs
```

### Prompt 2 - Short Company Description

```
Describe the company in one concise sentence based on {{companyDomain}} or {{companyDescription}}.

Rules:
- Do not mention company name
- Do not mention ICP
- Maximum 8 words
- Neutral tone, all lower case
- No quotes in output
- Use main value prop from website

Output must fit grammatically in:
"Getting people interested in [insert] is not the easiest thing in the world."
```

### Prompt 3 - Similar Product / Service

```
Categorise the product or service type based on {{companyDomain}}.

Rules:
- Maximum 6 words
- Neutral tone, all lower case
- No full stops
- Keep it singular
- Avoid vagueness
- Can use abbreviations

Output must fit grammatically in:
"We work with a similar [output]."
```

### Prompt 4 - Top 3 Problems

```
Identify the top 3 problems of the main ICP based on {{companyDomain}}.

Requirements:
- Problems directly linked to lagging indicators
- Rank 1-3 with 1 being biggest
- Each problem max 10 words
- Do not capitalise letters
- No full stop at end
- Add "and" before problem 3
- Avoid buzzwords / sales-y words

Output format: [Problem 1], [Problem 2], and [Problem 3]

Must fit phrase: "They book 25 meetings a month with leads struggling to [Problem 1], [Problem 2], and [Problem 3]"
```

### Prompt 5 - Subject Line (2 words)

```
Write a two-word email subject line based on {{companyDomain}}.

Rules:
- MUST be exactly 2 words
- All lower case
- Relevant to the user's business
- No sales or buzzwords
- No spam triggers
- Should flow into the email naturally
```

### Prompt 6 - Strong Hook from LinkedIn Post

```
Find the most recent LinkedIn post by {{firstName}} {{lastName}} at {{company}}.
Summarise the post's main argument in one sentence.

Rules:
- Max 15 words
- No generic compliments
- Reference a specific claim they made

Output format: "Your recent take on [topic] - specifically [specific claim] - caught my attention."
```

---

## Assembled Templates (Drop-In)

### Template A - Similar Client Approach (Outbound)

```
Hi {{firstName}}, saw you focus on {{prompt_2_output}}.

A client of ours prospects {{prompt_1_output}} for a {{prompt_3_output}}.

They help clients struggling to {{prompt_4_output}}.

{spintax CTA: Can I share|Can I show you|Would it interest you to see|Would you be open to|If you have 15 minutes, I can share|Could I show you}
...the email campaigns they were using to book 25+ meetings a month?

{{signature}}

p.s if not, happy to share how AI wrote this email ;)
```

### Template B - Case Study Reference

```
Our client {{lead_solution}} used to prospect {{prompt_1_output}}.

They focused on: {{prompt_4_output}}.

Since you focus on {{prompt_2_output}}, might work well if you combined {{free_resource}}.

Could I share the outbound campaign they were using to book 35 meetings a month?
```

---

## Advanced Personalisation Plays

### Play 1 - AI personalised video (Sendspark)
AI video says "Hi {{first_name}}" with the prospect's website scrolling in the background. Rest of the video is templated.
- Clay enriches → Sendspark generates → HTTP API → push to sequencer

### Play 2 - DynaPictures custom images
Layer the prospect's own ad creative onto a custom image. Example: ad in a CVS mini-billboard.
- Ad library scraping → Clay → DynaPictures API → push to campaign

### Play 3 - Lookalike campaigns
Build lookalikes of closed-won clients, positive responders, or newsletter engagers. Import best customers into Clay → enrich → find common patterns → build similar lists.

### Play 4 - LinkedIn follower campaign (battle cards)
Scrape competitor followers. Create battle cards (your product vs competitor). Personalised outreach referencing the prospect's known competitor allegiance.

### Play 5 - Job opening intent
Monitor job postings. Filter by relevant roles. Find decision-makers. "I saw you are hiring for X - companies in this phase usually need Y."

### Play 6 - Ad library scraping
Scrape Facebook Ad Library / Google Ads / LinkedIn Ad Library. Reference their current ads in outreach.

---

## DOs and DON'Ts

### DO
- Use custom prompts based on research
- Reference facts prospects consistently care about
- Use specific, sourced data ("according to SimilarWeb, you get 50K visitors a month")
- Cite sources - if data is wrong, the source takes the blame, not you
- Use AI for ONE specific component, not the whole email

### DO NOT
- Use generic AI compliments ("Love your work!")
- Over-personalise on personal interests (creepy)
- Reference signal directly ("I saw you raised your Series A") - prospects know what triggered it
- Compliment LinkedIn posts without substance
- Make personalisation feel like a sweeping AI summary

---

## Source Material
Synthesised from ColdIQ GTM Skills personalization sub-skill and Kiln Gitbook (Clay Agency) campaign playbooks.