# Acquisition Systems Theory

How to see a client acquisition operation as an engineered system — inputs, processes, outputs, feedback,
environment — rather than a pile of disconnected tactics. This is the systems layer above
`wiki/first-principles-client-acquisition.md` (which defines the atomic unit: Human + Stimulus = Action)
and above `wiki/scientific-method.md` (which defines how a single stimulus gets iterated). This file is
about the machine those stimuli run inside, and how to diagnose it when it isn't producing.

**Where this file's concepts are already partially enforced in the OS** — noted inline so nothing here
duplicates what's already built:
- The Polaris/KPI discipline (Section 6) is already enforced by `wiki/scientific-method.md` Step 3.
- Sample size and latency (Section 8) are already enforced by `wiki/scientific-method.md` Step 1.3-1.4.
- The diagnostic funnel for a single campaign (deliverability → list → signal → offer → copy) already
  lives in `gtm-skills/campaign-optimiser.md`. This file supplies the *systems-level* method for finding
  which sub-system to point that funnel at in the first place.

---

## How to Use This File

- **A whole client acquisition motion has stalled** (not just one campaign) — start at Section 4 (Sub-
  Systems) to work out which stage of the funnel is actually broken before diagnosing any single campaign.
- **Someone wants to change something that's hitting KPI** — read Section 6 (Non-Linear Metric
  Management) first. It explains why that instinct is usually wrong.
- **A client wants to scale** — Section 9 (Scale) before touching volume.
- **A system that used to work has gone quiet** — Section 10 (Entropy) and Section 11 (Feedback Loops).

---

## 1. What Is a System

A system is a collection of processes organised to convert inputs into outputs.

| Part | Definition |
|------|-----------|
| **Function** | The purpose of the system — what it actually does |
| **Inputs** | Raw materials fed into the system |
| **Processes** | What converts and combines raw materials into end products |
| **Outputs** | The end product of the raw materials being processed |
| **Feedback** | Information from outputs that's used to improve inputs and processes |
| **Environment** | The conditions the system operates within |

Two corrections that matter more than they sound:

> **Systems mean predictability, not automation.** A fully manual process run the same way every time is
> still a system. A flashy automated tool with no predictable structure underneath it is not.

> **Systems mean function, not results.** A system always produces the result it is actually designed to
> produce — even if that isn't the result you *intended*. If the output isn't what you wanted, the system
> isn't "broken." Its actual function just doesn't match your intention yet, and the fix is to change the
> system's design, not to declare it defective.

> **Example — the lasagna system.** Intention: make good lasagna. Inputs: no salt, stale sheets. Process:
> grill preheated to 300°C instead of the oven. Actual function: make bad lasagna. The system isn't
> broken — it's doing exactly what its actual inputs and process produce. Same logic applies to a cold
> email system built on a saturated list with no personalisation: it isn't "broken," it's functioning
> exactly as designed. The fix is the input/process, not blaming the system.

---

## 2. The Macro Client Acquisition System

Extending the atomic unit from `wiki/first-principles-client-acquisition.md` Section 1 (Human + Stimulus =
Action) up to the system level:

```
Human (in niche) + Stimuli Chain (from SOPs) = Clients ($$$) + Metrics
                              — inside The Market (environment) —
```

| Part | In a client acquisition system |
|------|--------------------------------|
| **Inputs** | Humans in the niche — typically strangers |
| **Output** | Clients (revenue) |
| **Feedback** | Metrics (data) |
| **Processes** | A chain of stimuli, designed to elicit the Micro-Action-Chain, deployed via SOPs or automation |
| **Environment** | The Market — every system, institution, and party (competitors, influencers, the niche itself) the acquisition system has to operate alongside |

---

## 3. Environment

The environment isn't part of the system, but it constrains what the system can achieve. Two kinds of
element:

| Type | Definition | Examples |
|------|-----------|---------|
| **Static** | Doesn't change — uncontrollable | Human nature, psychology, competition, latency, Classical Conditioning (see `wiki/first-principles-client-acquisition.md` Section 4) |
| **Variable** | Can change — controllable | Team members, the product, operator emotion, tooling, knowledge |

> "It's not the strongest or the fittest that survive, but those most adaptable to the change of the
> environment in which they find themselves." — paraphrasing Darwin.

**Examples relevant to this OS's channels:**

- LinkedIn connection limits cap input volume (variable — work around it)
- Gmail deliverability rule changes alter what the sending process can safely do (variable — adapt)
- A niche developing Stimulus Hypoesthesia to your copy changes your output without you touching anything
  (static — plan for it, see Section 10)
- Inconsistent follow-up cadence from whoever is sending changes the process (variable — fixable)

Your job as the system's builder: understand the static elements well enough to work around them, and
actively manage the variable elements that help or hurt performance.

---

## 4. Client Acquisition Sub-Systems

The macro system decomposes into six sub-systems, each converting a human from one stage to the next:

```
Latent Conditions > Attention > Interest > Appointment > Show > Primed Prospect > Closed Deal
```

| Stage | Definition |
|-------|-----------|
| **Latent conditions** | The human has dormant situational/psychological conditions that make them a potential client (see `wiki/offer-creation-theory.md` Section 12 — this is the raw material Attention is extracted from) |
| **Attention** | They give your offer or initial stimulus attention |
| **Interest** | They express further interest — a click, a reply |
| **Appointment** | An interested person books a meeting |
| **Show** | The booked appointment actually shows up |
| **Primed prospect** | Someone who showed up has been properly questioned and pitched |
| **Closed deal** | They become a client |

Each sub-system has its own inputs, processes, outputs, and feedback. The environment (Section 3) is
shared across all six, since they're all components of the same whole.

> **Worked sub-system example — cold email, sub-systems 1-2 (Latent Conditions → Attention → Interest):**
> **Function:** get positive replies via cold email.
> **Inputs:** leads (emails, names). **Processes:** SOPs + subject line/copy designed to elicit a reply.
> **Outputs:** positive replies. **Feedback:** open rate, PRR, negative reply rate. **Environment:** email
> deliverability, operator psychology, the niche's collective psychology.

**Why this matters diagnostically:** a stalled acquisition motion is almost never uniformly broken across
all six stages. It's usually one or two sub-systems dragging the whole macro system down (see Section 5 —
Bottlenecks). Naming the stage explicitly is what makes it possible to isolate.

---

## 5. Throughput, Yield, Bottlenecks, Latency

| Term | Definition |
|------|-----------|
| **Throughput** | The flow of value through a system — how much of what enters actually converts as it moves through |
| **Yield** | The total output the system produces (clients) |
| **Bottleneck** | The point in the system where throughput is most restricted |
| **Latency** | The time elapsed between an input entering the system and the output it produces appearing |

> **Throughput example:** 10,000 ad impressions → 500 clicks → 200 leads → 50 schedules → 40 calls → 10
> clients. Every arrow is a place value can leak. The job is to open the floodgates at every stage.

> **Yield example:** 1,000 cold emails sent, 1 client closed. Overall system yield: 0.1%.

**The bottleneck law:** yield is always capped by the tightest bottleneck, not the average performance of
the system. A perfect closer converting 100% of calls is irrelevant if show rate is 1% — anything
multiplied by near-zero is near-zero. A client acquisition system is only as effective as its weakest
sub-system.

**Latency:** see `wiki/scientific-method.md` Section 1.4 for how this is already enforced — the OS's rule
that results can't be judged before the full sequence + wait window has elapsed is latency applied to a
single test. The same law applies at the macro level: today's outreach is the client you sign in 2-3
weeks, not today.

### Finding a bottleneck — worked example

A LinkedIn appointment setter, one month, KPI = 5% ABR (Polaris = ABR):

| Stage | Count |
|-------|-------|
| Videos sent | 323 |
| Positive replies | 50 |
| Calendly links sent | 29 |
| Bookings | 12 |

**Step 1 — map the input/output chain:**
```
Connection → initial message → evergreen video → Calendly link sent → call booked
```

**Step 2 — calculate sub-conversion rates** (`output ÷ input × 100`):
- 50 / 323 = **15.48% PRR** — strong, not the bottleneck
- 29 / 50 = **58%** Calendly-sent rate
- 12 / 29 = **41%** booking rate
- Total ABR = 12 / 323 = **3.72%** — below the 5% KPI

The 15% PRR is healthy — the bottleneck is downstream, in the two later conversions (positive-reply→
Calendly-sent and Calendly-sent→booked). That's where the fix belongs, not in the video or connection
copy. This is the general method: map the chain, compute every sub-conversion rate, and fix the stage
with the worst rate relative to what's realistic for that stage — not the stage that "feels" wrong.

---

## 6. Metrics, Polaris, and Non-Linear Metric Management

**Conversion rate formula:** `output ÷ input × 100 = CR%`.

Additional funnel-stage acronyms beyond what's in `wiki/glossary.md` (Performance Metrics): LVR (Loom View
Rate), SUR (Show-Up Rate), CTOR (Call-to-Offer Rate), SCR (Sales Conversion Rate), FCR (Funnel Conversion
Rate). Use these when reasoning about sub-systems 3-6 specifically (Section 4) — `wiki/glossary.md`'s
existing PRR/ABR/CTR cover sub-systems 1-2.

**The Polaris Star:** the one metric a system is optimised for — already the operating principle behind
`wiki/scientific-method.md`'s ABR-before-PRR rule. If Polaris is within KPI, the system works and nothing
should change, regardless of how any other metric looks. A 5% open rate that converts every opener to a
booked call is a system with Polaris in KPI — leave it alone.

**Non-linear metric management — why "just improve everything" breaks systems:**

> Improving open rate from 5% to 10% with a punchier, more bait-y subject line sounds like a pure win. But
> if the subject line now over-promises what the body copy delivers, or the extra follow-ups needed to
> drive that open rate annoy people into disengaging, ABR can fall from 5% to 1% in the same move. Systems
> are non-linear — a change to one part can wreck an unrelated-looking part elsewhere.

**The rule:** if Polaris is in KPI, don't touch the system. If you want more efficiency, build a separate
test ("petri dish") copy of the system and optimise the *non-Polaris* metric there — never on the live
system that's already hitting its number. Metrics behave like a pyramid: pull blocks from the bottom to
make the top taller and you risk collapsing the whole structure.

---

## 7. Metric Validity

Validity means the data is factually sound and representative. Better data → better validity → better
decisions. More data → more validity → more accuracy.

Treat metric logging as non-negotiable. `wiki/scientific-method.md` already enforces this operationally
(mandatory V-number logging, daily logging discipline) — this is the underlying reason why: a system
without a metric log cannot be diagnosed, only guessed at.

---

## 8. Regression to the Mean

Small samples do not distribute evenly, even when the underlying odds are fixed. A fair coin flip is
50/50, but ten flips are just as likely to land `H H H H H T T T T T` as they are to alternate cleanly.

> **Sales rep example, 20% true conversion rate over 30 calls.** It looks just as plausible to lose 25 in
> a row and then win 5 in a row, as it does to win roughly 1 in every 5 calls evenly spaced. Most people,
> after a 20-call losing streak, would tear up the script, the offer, the entire system — despite the
> streak being fully consistent with a system that is actually working exactly at its true rate.

This is the mechanism behind the sample-size rule already enforced in `wiki/scientific-method.md` (300
sends per cold email variant, 30 for Loom/video, etc.) — the rule exists specifically to prevent decisions
being made on a run of results that's still inside normal variance, not yet a real average. Never judge a
system from a small, recent slice of outcomes; judge it from the full sample size the fundamentals call
for.

---

## 9. Scale

Client acquisition systems tend to hold their conversion rates roughly constant regardless of size —
**scaling is primarily a function of increasing the volume of the input**, not reinventing the system.

- Scale ads → spend more.
- Scale cold email → send more.
- Scale organic → publish more.

> **Worked example.** A cold email system at 1% ABR feeding a sales system at 10% SCR, $3k fee: 20
> emails/day → 4 calls/month → 1.2 clients / 3 months (~$1.2k/mo). Scale to 200 emails/day (10x volume,
> same conversion rates): 120 calls / 3 months → 12 clients / 3 months (~$12k/mo). The conversion rates
> never had to improve — only the input volume did.

**The lesson:** don't wait for "ideal metrics" before scaling. A validated proof of concept (Section 8 —
enough sample size to trust the average) is the actual gate, not a perfect conversion rate. Volume is the
primary lever for scale once a system is proven.

### Observing nature

If you want a model for how scale actually behaves, look at biological systems rather than business case
studies: however an organism (or, less pleasantly, a virus) behaves and spreads at a population of 10,000
is very close to how it behaves at a population of 1,000,000,000, provided the underlying "DNA" (the
system design) is well-suited to its environment. Client acquisition systems scale the same way — the
system's design is the DNA; if it's fit for the environment (Section 3), volume alone compounds it.

### Limiting factors

Scale has a ceiling. You're capped by how many humans with the right latent conditions actually exist in
the niche (Section 4), and by team capacity — time and energy for a sales rep, sending limits for
infrastructure.

### Non-linear scaling factors

Increased input does not automatically mean increased output — scaling can break the process or collide
with the environment:

- More ad spend without a bigger audience → frequency saturation, not more reach
- More emails without added deliverability precautions → spam folder, not more replies
- More content without accounting for audience fatigue → diminishing returns, not more attention

Systems often break *because* of scale, not despite it. Never assume `inputs × N = outputs × N`.

### Flowing river

Still water stagnates; flowing water stays fresh. A client acquisition system with no constant stream of
fresh humans with the right latent conditions will stagnate and stop, even if it worked perfectly before.
Because of latency (Section 5), a system can be starved of new input today and still produce clients for
another week or two before the effect is visible — which is exactly why it's dangerous to stop. If a
system is working and you can't take on more clients, don't stop running it — solve the capacity problem
instead, because restarting a stalled system from zero is far more expensive than pacing intake.

---

## 10. Entropy

All systems die — once a system is built and producing, the clock on its eventual decline has already
started. This is the system-level version of Stimuli Entropy in
`wiki/first-principles-client-acquisition.md` Section 4 — that section covers why a single stimulus (a
subject line, a script) fatigues; this is the same law applied to the SOP or sub-system running it.

**The practical response, not just the diagnosis:** when a system is working, don't touch the live
version. Duplicate it into an identical environment with all variables held the same, then test small
variations on the duplicate to find the next iteration that will replace the original once entropy catches
up. This is Section 6's "petri dish" rule, applied specifically as an entropy countermeasure rather than a
pure optimisation exercise.

---

## 11. Feedback Loops

A feedback loop is when a system's outputs feed back into its own inputs.

| Type | Effect | Example |
|------|--------|---------|
| **Positive** | Output increases future output — growth | More clicks on a video → more algorithmic reach → more clicks. A rep on a win streak develops stronger self-belief → longer streak. Prospects reply → proof the copy works → better copy gets written. |
| **Negative** | Output decreases future output — decline | Fewer clicks → less reach → fewer clicks. A rep on a loss streak loses self-belief → longer losing streak. |

**The trap to avoid:** reacting to a single data point as if it were a feedback loop. One prospect replying
negatively is not evidence the copy is broken — treat that as noise (Section 8), not signal, and change
copy based on aggregated data, not a single reaction.

**Feedback delay:** because of latency (Section 5), feedback always arrives late. Before changing anything
based on metrics, confirm the feedback window has actually elapsed — `wiki/scientific-method.md`'s latency
rule is this principle already encoded for single tests; it applies identically to judging a rep's bad
morning, or a channel's bad week, at the macro level.

---

## 12. Supporting Models

Additional mental models useful when reasoning about a system as a whole (companions to the general
toolkit in `wiki/first-principles-client-acquisition.md` Section 9):

| Model | Definition | Applied here |
|-------|-----------|--------------|
| **Emergence** | New structure arising from simpler underlying rules | A well-taught set of fundamentals should let genuinely novel systems emerge, not just copies of the ones taught |
| **Critical mass** | The minimum input needed before a system becomes self-sustaining | E.g. the subscriber count at which a channel starts getting algorithmic promotion, changing its own growth rate |
| **Equilibrium** | A state of balance between two opposing forces | Clients lost vs clients acquired — a portfolio holding steady is equilibrium, not stagnation |
| **Margin of safety** | A buffer between the safe zone and the danger zone | If a rule calls for 300 sends before trusting a result, send 330 |
| **Churn** (component wear) | Parts of a system wear out and need constant replenishment | A lead list depletes; a sending domain's reputation decays — budget for replacement as a standing cost, not an exception |
| **Law of diminishing returns** | Beyond a point, more input stops producing proportionally more output | A rep given more than 7-8 calls a day gets less effective per call, not more effective overall |
| **Sunk costs** | Prior investment doesn't establish current value | A script that cost real money to develop gets dropped the moment it stops converting — prior spend is not a reason to keep it (contrast with `wiki/psychological-principles.md` #29, which covers a *prospect's* sunk-cost bias during a sales call — this is the operator avoiding the same bias in their own decisions) |
| **Butterfly effect** | Systems are sensitive to initial conditions; small early changes can have outsized downstream effects | A small change to Email 1 changes which prospects even reach Email 3 — early-stage changes compound further than late-stage ones |

---

## Source Material

Primary methodology (per `CLAUDE.md` → Source Knowledge) — provided by Harry Rawles.
