# Visual Diagrams

Mermaid flowcharts of the core OS workflows. Open this file in any markdown viewer that supports Mermaid (GitHub, VS Code, Obsidian) to see the rendered diagrams.

---

## 1. Onboarding Flow (Client Onboarder)

```mermaid
flowchart TD
    A[Clone template repo] --> B[Open in Claude Code]
    B --> C[Run client-onboarder]
    C --> D{Pre-call worksheet filled?}
    D -->|Yes| E[Ingest worksheet]
    D -->|No| F[Pure conversational mode]
    E --> G[Phase 1: Identity 5min]
    F --> G
    G --> H[Phase 2: Offer 15min]
    H --> I[Phase 3: ICP 15min]
    I --> J[Phase 4: Voice 10min]
    J --> K[Phase 5: Infrastructure 5min]
    K --> L[Completeness report]
    L --> M{Any TO CONFIRM items?}
    M -->|Yes| N[Flag for manual resolution]
    M -->|No| O[Run pre-launch-check]
    N --> O
    O --> P{Verdict READY?}
    P -->|Yes| Q[OS ready for copy]
    P -->|No| R[Fix gaps, re-check]
    R --> O

    style C fill:#4CAF50,color:#fff
    style Q fill:#2196F3,color:#fff
```

---

## 2. Campaign Lifecycle

```mermaid
flowchart LR
    A[Signal Selection<br/>signal-sourcer] --> B[Lead List<br/>list-builder]
    B --> C[Copy Generation<br/>cold-email-writer]
    C --> D[Pre-Launch Check<br/>pre-launch-check]
    D --> E{Ready?}
    E -->|No| C
    E -->|Yes| F[Campaign Launch<br/>campaign-launcher]
    F --> G[Active Campaign<br/>monitoring]
    G --> H[Replies received]
    H --> I[Reply Handler<br/>reply-handler]
    G --> J[Weekly Review<br/>weekly-reviewer]
    J --> K[Log Winners/Losers<br/>copy-library + decision-log]
    K --> L[Queue Tests<br/>test-launcher]
    L --> C
    G --> M{Performance issue?}
    M -->|Yes| N[Campaign Optimiser]
    N --> C
    G --> O{Deliverability issue?}
    O -->|Yes| P[Deliverability Doctor]
    P --> G

    style F fill:#4CAF50,color:#fff
    style J fill:#FF9800,color:#fff
    style I fill:#9C27B0,color:#fff
```

---

## 3. Weekly Review Flow (Friday Compounding Loop)

```mermaid
flowchart TD
    A[Friday: Run weekly-reviewer] --> B[Pull Instantly data 7 days]
    B --> C[Step 2: Signal Trends]
    C --> D{Any signal declining 30%+?}
    D -->|Yes| E[Flag pivot recommendation]
    D -->|No| F[Step 3: Identify Winners]
    E --> F
    F --> G{PRR >= 1% and sample >= 300?}
    G -->|Yes| H[Confirm with the GTME]
    G -->|No| I[Step 4: Identify Losers]
    H --> J{Confirmed?}
    J -->|Yes| K[Ask 'why it worked']
    J -->|No| I
    K --> L[Write to copy-library + decision-log]
    L --> I
    I --> M{PRR < 0.5%?}
    M -->|Yes| N[Confirm + log graveyard]
    M -->|No| O[Step 5: Update Tests]
    N --> O
    O --> P[Step 6: Update Health]
    P --> Q[Step 7: Chain to Report]
    Q --> R[client-report-writer]
    R --> S[Send weekly report]

    style A fill:#FF5722,color:#fff
    style L fill:#4CAF50,color:#fff
    style S fill:#2196F3,color:#fff
```

---

## 4. Optimisation Decision Tree

```mermaid
flowchart TD
    A[Campaign underperforming] --> B[Campaign Optimiser]
    B --> C{Bounce rate > 5%?}
    C -->|Yes| D[Deliverability Doctor]
    C -->|No| E{List quality check passes?}
    E -->|No| F[List Builder: re-verify]
    E -->|Yes| G{Signal still fresh?}
    G -->|No| H[Signal Sourcer: pivot]
    G -->|Yes| I{Offer fits ICP/persona?}
    I -->|No| J[Reframe offer in copy]
    I -->|Yes| K{Copy passes QA?}
    K -->|No| L[Cold Email Writer: rewrite]
    K -->|Yes| M{Sequence complete chain works?}
    M -->|No| N[Adjust sequence]
    M -->|Yes| O{Personalisation tier right?}
    O -->|No| P[Personalization Strategist]
    O -->|Yes| Q[Diagnose deeper / consult the GTME]

    style D fill:#F44336,color:#fff
    style Q fill:#9E9E9E,color:#fff
```

---

## 5. Reply Handling Flow

```mermaid
flowchart TD
    A[Reply received] --> B[Reply Handler]
    B --> C{Classify}
    C -->|Positive| D[Send calendar link]
    C -->|Negative polite| E[Graceful exit + suppress]
    C -->|Negative hostile| F[No response + immediate suppress]
    C -->|OOO| G[Re-queue with return date]
    C -->|Wrong person| H[Re-route + new contact]
    C -->|Stall| I[Send asset + 7-day follow-up]
    C -->|Objection| J[Objection Library]
    C -->|Question only| K[Concise answer + bridge]
    C -->|Forwarded internally| L[Acknowledge + new contact]
    C -->|Unclear| M[Flag for the GTME]

    F --> N[Escalate to the GTME]
    J --> O{Pattern recognized?}
    O -->|Yes| P[Use template response]
    O -->|No| Q[Custom response + add to library]
    P --> R[Log to comms-log]
    Q --> R
    D --> R
    E --> R
    H --> R
    I --> R
    K --> R
    L --> R

    style B fill:#9C27B0,color:#fff
    style N fill:#F44336,color:#fff
```

---

## 6. Incident Response Flow

```mermaid
flowchart TD
    A[Incident detected] --> B[Incident Responder]
    B --> C{Classify type}
    C -->|A: Blacklisted| D[Protocol A]
    C -->|B: Bounce spike| E[Protocol B]
    C -->|C: Public bad reply| F[Protocol C]
    C -->|D: Platform outage| G[Protocol D]
    C -->|E: Data exposure| H[Protocol E]
    C -->|F: Other| I[Protocol F]

    D --> J[Pause campaigns + flag AM to submit removal]
    E --> K[Pause campaigns + re-verify list - GTME]
    F --> L[Do not respond + escalate to manager]
    G --> M[Wait + notify if extended]
    H --> N[STOP all + escalate to manager + preserve evidence]
    I --> O[Capture + escalate + fix]

    J --> P[Resolution]
    K --> P
    L --> P
    M --> P
    N --> P
    O --> P
    P --> Q[Post-mortem to decision-log]

    style B fill:#F44336,color:#fff
    style N fill:#B71C1C,color:#fff
    style Q fill:#4CAF50,color:#fff
```

---

## 7. Operating Rhythm (Daily/Weekly/Quarterly)

```mermaid
gantt
    title Operating Rhythm Across the Week
    dateFormat HH:mm
    axisFormat %H:%M

    section Daily
    Morning check 10min     :09:00, 10m
    Reply triage             :09:10, 20m
    End of day wrap 5min    :17:30, 5m

    section Monday Only
    Portfolio health 1hr     :10:00, 60m

    section Friday Only
    Weekly review (per client)  :14:00, 180m
    Send weekly reports       :17:00, 30m

    section Monthly
    ICP / offer review (per client)  :09:00, 30m

    section Quarterly
    QBR prep + call (per client) :09:00, 120m
```

---

## 8. File Architecture

```mermaid
flowchart TD
    A[Client OS Repo] --> B[Per-client files<br/>clients/{slug}/]
    A --> C[Shared knowledge<br/>wiki/]
    A --> D[AI skills<br/>gtm-skills/]
    A --> E[Infrastructure<br/>README, BOOTSTRAP, VERSION]

    B --> B1[_config.md]
    B --> B2[overview.md]
    B --> B3[icp.md]
    B --> B4[offer.md]
    B --> B5[voice.md]
    B --> B6[campaign-state.md]
    B --> B7[decision-log.md]
    B --> B8[comms-log.md]
    B --> B9[competitive-intel.md]
    B --> B10[copy-library.md]
    B --> B11[test-log.md]

    C --> C1[_skill-context.md]
    C --> C2[copywriting-101.md]
    C --> C3[signal-sourcing.md]
    C --> C4[deliverability.md]
    C --> C5[...]

    D --> D1[client-onboarder.md]
    D --> D2[weekly-reviewer.md]
    D --> D3[reply-handler.md]
    D --> D4[...]

    style B fill:#FF9800,color:#fff
    style C fill:#4CAF50,color:#fff
    style D fill:#2196F3,color:#fff
```

---

## How to Use These Diagrams

- **Onboarding:** show diagram #1 to a new collaborator
- **Pitching the OS:** show diagram #2 to a prospect or stakeholder
- **Training Claude:** these diagrams give Claude visual context for the workflows it operates
- **Documentation:** when updating workflows, update the corresponding diagram