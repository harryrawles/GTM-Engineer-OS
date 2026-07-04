# Playbook: SaaS 2 — Dev-Tools / In-Workflow Automation (Autonomous QA)

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client selling a **developer-workflow
tool** to product & engineering teams — led by in-IDE workflow integration, speed/autonomy, and shipping
velocity (not tooling jargon). Example built around MCP-powered autonomous QA.
**Origin:** Abstracted from a dev-tools QA campaign. All brand-specific values are placeholders —
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. Integration claims (which IDEs/tools it runs inside) must be real — confirm the client's actual
> supported surfaces. Never carry one client's specifics into another.

---

## Campaign Goal

Introduce product and engineering teams to a tool that **runs inside the developer workflow** — reducing
cycle delays and increasing coverage while coding.

## Ideal Customer Profile (ICP)

**Targets:**
- Product Managers
- Engineering Managers
- Tech Leads
- Founders at product-led SaaS companies

**Company type:**
- SaaS teams shipping frequently
- Teams using modern AI-assisted IDEs (e.g. Cursor, Claude, VS Code)
- Teams struggling with slow QA feedback loops

**Pain points:**
- QA feedback arrives too late
- Manual test cycles slow releases
- Context switching between code and testing
- Coverage gaps introduced during rapid iteration

## Core Messaging Strategy

- Lead with **workflow integration** (inside the IDE)
- Emphasise **speed and autonomy**
- Position QA as **part of coding, not a separate step**
- Keep the CTA lightweight: overview, not demo
- Avoid QA jargon — speak in shipping-velocity terms
- Tone: modern, product-driven, developer-friendly (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables — keep them as-is (`{{firstName}}`, `{{sendingAccountFirstName}}`).
`{{COMPANY}}` = the active client's brand; `{{SUPPORTED_IDES}}` = the client's real supported surfaces.

### Email 1 — Primary Outreach

```
Hi {{firstName}},

We're introducing engineering teams to {{COMPANY}}'s new MCP-powered workflow — autonomous QA that runs directly inside {{SUPPORTED_IDES}}.

Early adopters are replacing slow test cycles with instant coverage checks as they code.

Interested in a quick overview?

{{RANDOM|Best|Thanks|Talk soon}},
{{sendingAccountFirstName}}
```

---

## Key Value Points (use only real, approved points)

- Autonomous QA inside the IDE
- MCP-powered workflows
- No context switching
- Faster shipping with higher confidence
- QA happens as code is written

## When to Use This Playbook

**Use when:**
- Targeting product or engineering leadership
- Selling speed, velocity, and reliability
- Reaching teams modernising dev workflows

**Avoid when:**
- Targeting manual QA teams only
- Selling traditional test-management tools

---

## Adapting for a client (checklist)

- [ ] `{{COMPANY}}` → client brand (from `clients/{slug}/_config.md`)
- [ ] `{{SUPPORTED_IDES}}` → the client's real supported IDEs/surfaces (`offer.md`) — don't claim integrations that don't exist
- [ ] `{{firstName}}` / `{{sendingAccountFirstName}}` → confirm these Instantly fields exist and are mapped
- [ ] Confirm capability claims (MCP, autonomous coverage, "as you code") are real and in `voice.md` → Approved Claims
- [ ] Add follow-up steps if the client wants a sequence (this angle ships as a single overview email)
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
