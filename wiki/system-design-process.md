# System Design - Building a Sub-System from Scratch

The 6-step process for designing a brand-new client acquisition sub-system - not iterating an existing one
(that's `wiki/scientific-method.md`), but building the channel/mechanism from nothing. Scoped to the GTME
role: building a new channel or motion for an Instantly client, not a general business-building guide.

**When this file is actually needed:** every client in this OS already runs on a built channel - Instantly
cold email - so day-to-day work uses `gtm-skills/chain-build-campaign.md` directly, which is the cold-email
channel already instantiated from this exact process (its sub-skills map onto the steps below - see the
table in Section 7). Reach for this file specifically when:
- A client wants a **second channel** added (LinkedIn, YouTube organic, paid ads, cold calling)
- Something about an existing channel feels arbitrary and needs re-deriving from first principles

---

## How to Use This File

Work through Steps 1-7 in order once, per new sub-system. Each step links to the existing wiki file that
already covers its theory in depth - this file supplies the parts of the *build process* that aren't
covered elsewhere: locating an input pool for a channel that doesn't exist yet, inverting a micro-action-
chain into a stimuli-chain, deriving a KPI when no benchmark exists, and the human/machine task split that
turns a validated system into something a team member (not just Claude) can run.

---

## Systems Recap (already covered - no restatement)

The system model (Function/Inputs/Processes/Outputs/Feedback/Environment), the Macro Client Acquisition
System equation, and the 6 sub-systems (Latent Conditions → Attention → Interest → Appointment → Show →
Primed Prospect → Closed Deal) are fully specified in `wiki/acquisition-systems-theory.md` Sections 1-4.
Read those first if unfamiliar - everything below assumes them.

---

## Step 1 - Define Core Premises

**1.1 Define the sub-system.** Pick exactly one of the 6 sub-systems
(`wiki/acquisition-systems-theory.md` Section 4) to build. Don't design across more than one at a time.

**1.2 State the desired function.** Answer directly: why am I building this? What does success look like
if it functions properly? What problem does it solve? What do I actually want out of it? (Ties to Section
1's Function/Intention distinction in `wiki/acquisition-systems-theory.md` - be precise here, because a
vague function produces a system that "works" but not for the goal you actually meant.)

**1.3 State inputs and outputs.** Identify exactly what goes in and what comes out, using the sub-system
map. Example: sub-system 3 (Interest → Appointment) - input is "interest," output is "appointment."

---

## Step 2 - Establish Input Mechanisms

**2.1 Locate the input pool.** The input pool is where the system draws its raw humans from.

- For sub-systems 2-6, the input pool is simply the **output of the sub-system before it** - sub-system
  3's output (appointments) is sub-system 4's input pool. No external sourcing needed.
- Only **sub-system 1** (Latent Conditions → Attention) needs an external input pool, and it depends on
  the channel:

| Channel type | Input pool |
|--------------|-----------|
| Outbound | Email lists, phone lists, social account lists |
| Inbound | Social accounts you connect with + the platform's algorithm |
| Ads | The audience-targeting layer of the ad platform |

For this OS's actual channel (cold email), the input pool is already fully specified -
`wiki/signal-sourcing.md` (which signals to source from) and `wiki/list-building.md` (ICP scoring and
validation) are the input-pool answer for sub-system 1 on cold email specifically. Building a new channel
means answering the equivalent question for that channel from scratch.

**2.2 Build the input management system.** A place to manage and track inputs as they move through the
sub-system - usually a spreadsheet, mostly needed for outbound and parts of inbound (conversation
management, lead tracking). For this OS, `clients/{slug}/campaign-state.md` and the Instantly workspace
itself already serve this role for cold email.

---

## Step 3 - Build Stimuli Mechanisms

**3.1 Define the micro-action-chain.** List the exact sequence of actions a human must take to convert
from the sub-system's input state to its output state. See
`wiki/first-principles-client-acquisition.md` Section 1 for the full worked example (YouTube organic) and
the underlying Human + Stimulus = Action model this is built on. A micro-system's chain will be much
shorter than that macro example - often just 2-4 actions.

**3.2 Invert the chain into a stimuli-chain.** For every action in the micro-action-chain, define the
specific stimulus that elicits it. This is the direct build-step version of the DNA/genotype model in
`wiki/darwinian-acquisition-theory.md` Section 3 - each stimulus in the chain will itself decompose into
variables once you get to Step 3.3.

> **Worked example - inverting a YouTube attraction chain:**
> ```
> Micro-action:  clicking vid → reading description → clicking link → watching video → clicking to book
> Stimulus:      thumbnail+title → CTA in video → funnel link/title → social proof in video → CTA to book
> ```
> Every action has exactly one stimulus engineered to cause it. If an action in the chain has no
> corresponding stimulus, that's the point in the system where humans will silently drop off.

**3.3 Create the stimuli and frameworks.**

- Model off what's already proven - this OS's `best-practices/`, `wiki/copywriting-frameworks.md`, and
  the client's own `copy-library.md` are exactly this.
- A strong offer improves every stimulus in the chain at once - see `wiki/offer-creation-theory.md`
  Section 7 (Offer Power).
- Apply psychology deliberately - `wiki/psychological-principles.md`.
- Introduce genuine variation, don't just copy - `wiki/darwinian-acquisition-theory.md` Section 9.
- **For stimuli that need constant re-creation** (not static, one-and-done) - build a reusable framework
  rather than reinventing each instance. `wiki/copywriting-frameworks.md`'s 13 named frameworks are exactly
  this principle already applied to cold email; do the equivalent for any new recurring stimulus (e.g. two
  YouTube thumbnail frameworks: "show my face," or "describe the video in 3-5 words").
- Template the result somewhere reusable so someone other than the system's designer can execute it.

---

## Step 4 - Build Feedback Mechanisms

**4.1 Build the data tracking sheet.** Log daily, always on yesterday's data (already the exact rule in
`wiki/scientific-method.md` Step 2.3). One rule that isn't stated elsewhere in this wiki:

> **Attribute outputs to the date of the original input, not the date the output occurred.** If an email
> sent on the 15th produces a booked call on the 29th, log that booking against the 15th, not the 29th.
> Otherwise your daily conversion rates are systematically distorted by latency (see
> `wiki/acquisition-systems-theory.md` Section 5) and become impossible to compare day-to-day.

**4.2 Decide KPIs.** When no existing benchmark applies (a genuinely new channel), derive the KPI by
reverse-engineering it from an acceptable ROI or effort budget: how much are you willing to spend, or how
much time are you willing to invest, to get one conversion at this stage? Back-solve the conversion rate
that makes that spend/effort acceptable - that's your KPI, not an arbitrary industry number. (For
established channels this OS already runs, the benchmark exists - see `wiki/email-benchmarks.md` and
`wiki/signal-sourcing.md`.)

**4.3 Define the tracking timeframe.** Daily, on yesterday's data - same rule as 4.1.

**4.4 Define testing volume.** How many inputs are needed before the conversion rate is trustworthy? See
`wiki/scientific-method.md` Step 1.3 (sample size) and `wiki/acquisition-systems-theory.md` Section 8
(Regression to the Mean) for why this can't be skipped.

**4.5 Define metric-variable relationships.** Map which metrics reflect the effectiveness of which
stimuli/variables - `wiki/darwinian-acquisition-theory.md` Section 6 is the worked example of exactly this
(LVR/PRR/ABR mapped to their driving variables). Do the equivalent mapping for a new channel's metrics
before you can troubleshoot it.

**4.6 Create troubleshooting heuristics.** A decision framework for what to check, in what order, when
metrics fall out of KPI. `gtm-skills/campaign-optimiser.md` is exactly this, already built for cold email -
building a new channel means writing its equivalent diagnostic funnel.

---

## Step 5 - Establish Flow

Visualise the system: box out every stimulus, SOP, and asset the system needs, then link them in sequence
on a whiteboard (Miro or equivalent) so the relationships between stimuli and SOPs are visible at a glance,
not just implied by a document. `wiki/diagrams.md` is this OS's own version of this practice - Mermaid
flowcharts of the OS's internal skill workflows - applied at the OS-architecture layer instead of a single
client-channel layer. Build the equivalent for a new channel's SOPs before handing it to anyone else to
run.

---

## Step 6 - Establish Deployment Methods

A deployment method is whatever makes a stimulus or task actually run - either an SOP (a human follows a
written procedure) or software (a machine runs it automatically).

**6.1 Define tasks.** List literally everything that has to happen for the system to function - sending,
logging, remembering, creating.

**6.2 Label each task human or machine.**

**6.3 Organise machine tasks.** Group them by which tool/software will run them; that tool list is what
needs to be procured and learned.

**6.4 Create an SOP hub.** A single document collecting every human-run task for this system.

**6.5 Build SOPs in this order** (each layer depends on the one before it):
1. Core stimuli assets and templates
2. Spreadsheets to manage human conversions
3. Spreadsheet(s) to manage metrics
4. The system's flow (Step 5)
5. An overall daily workflow tying the tasks together
6. A summary index of every template/spreadsheet needed

**6.6 Record a video walkthrough of each SOP.** Whoever runs the task benefits far more from seeing it
done than reading it described - the clearer the instruction, the more reliable the execution.

---

## What a Fully Designed Sub-System Has

1. A clear function (Step 1)
2. A pool of inputs (Step 2)
3. Stimuli that process those inputs (Step 3)
4. Sound KPIs and a feedback mechanism (Step 4)
5. A visual flow (Step 5)
6. Tasks deployable by human or machine, with SOPs (Step 6)

Every channel in this OS is run by the GTME and Claude together, not a hired operator, so there's no separate
"recruit a team" step here. Once iterated with `wiki/scientific-method.md`, this is the entire loop this
OS's own theory files describe: design once (this file), then iterate forever (the scientific method) - the
same closing point `wiki/scientific-method.md` and `wiki/darwinian-acquisition-theory.md` make about time
being the only real constraint once the process itself is sound.

---

## 7. This Process, Already Instantiated for Cold Email

`gtm-skills/chain-build-campaign.md` is this exact 6-step process, already run once for the one channel
this OS operates, so its sub-skills can be run individually instead of re-deriving the process each time:

| System Design step | Already answered by |
|---------------------|----------------------|
| 1. Core premises | `clients/{slug}/icp.md`, `offer.md` |
| 2. Input mechanisms | `gtm-skills/list-builder.md`, `gtm-skills/signal-sourcer.md` |
| 3. Stimuli mechanisms | `gtm-skills/cold-email-writer.md`, `wiki/copywriting-frameworks.md` |
| 4. Feedback mechanisms | `gtm-skills/pre-launch-check.md`, `wiki/email-benchmarks.md` |
| 5. Flow | `wiki/diagrams.md` (OS-level; no client-level flow doc exists yet - a genuine gap if a client ever needs one) |
| 6. Deployment | `gtm-skills/campaign-launcher.md`, `.claude/bin/instantly.sh` |

Building a second channel for any client means writing the equivalent right-hand column from scratch,
using Steps 1-6 above as the checklist.

---

## Source Material

Primary methodology (per `CLAUDE.md` → Source Knowledge) - provided by Harry Rawles.
