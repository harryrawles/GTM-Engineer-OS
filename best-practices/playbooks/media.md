# Playbook: Media Placement - Trusted Distribution → Target Audience

**Type:** Shared campaign playbook (client-agnostic). Reusable for any client selling **media placements /
content partnerships** by positioning an owned audience as a high-trust distribution channel (not ad
inventory) - example built around education brands reaching parents.
**Origin:** Abstracted from a media-placement campaign. All brand-specific values are placeholders -
fill them from the active client's `clients/{slug}/offer.md`, `icp.md`, and `voice.md`.

> **How to use:** this is a starting structure, not drop-in copy. Swap every `{{PLACEHOLDER}}` for the
> active client's real values, and only make claims that appear in that client's `voice.md` → *Approved
> Claims*. Audience-size claims (`{{AUDIENCE_SIZE}}`) and credibility mentions (`{{CREDIBILITY_MENTION}}`)
> must be real and approved. The founder-led signature is core to the angle - fill the founder block with the
> client's real signatory. Never carry one client's specifics into another.

---

## Campaign Goal

Start warm, credibility-driven conversations by showing how the target audience discovers resources through
**trusted content**, and positioning the network as a **high-trust distribution channel, not ad inventory**.

## Ideal Customer Profile (ICP)

**Targets (example - education brands; re-skin per client):**
- Education brands
- EdTech companies
- Enrichment programs
- Tutoring platforms
- Curriculum & learning tools

**Decision makers:**
- Heads of Marketing
- Growth leaders
- Brand partnerships managers
- Founders

**Audience they want (example):**
- Parents of K–12 children
- Families actively seeking learning resources
- Parents who trust editorial recommendations

## Core Messaging Strategy

- Lead with **audience trust, not reach alone**
- Emphasise **discovery behaviour** (the audience uses content to explore options)
- Position outreach as **curation, not selling ad slots**
- Use light CTAs: media kit, example placements, visibility overview
- Anchor credibility with **founder identity + a credibility mention** (`{{CREDIBILITY_MENTION}}`)
- Tone: credible, calm, partnership-oriented (defer to `clients/{slug}/voice.md`)

---

## Sequence

Merge fields are Instantly variables - keep them as-is (`{{FirstName}}`, `{{CompanyName}}`). The signature is
founder-led - fill `{{FOUNDER_NAME}}` / `{{FOUNDER_TITLE}}` / `{{CREDIBILITY_MENTION}}` and `{{AUDIENCE_SIZE}}`
from the client's approved details.

### Angle 1 - Audience Discovery Behaviour

```
Hey / Hi / Hello {{FirstName}},

Parents in our network regularly use our content to explore educational resources, programs, and tools that support their kids' learning.

We reach more than {{AUDIENCE_SIZE}} through trusted newsletters and editorial content. I pulled a short view showing where education brands like {{CompanyName}} typically get attention.

Want me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{FOUNDER_NAME}}
{{FOUNDER_TITLE}}
{{CREDIBILITY_MENTION}}

If this isn't relevant, just let me know.
```

### Angle 2 - Visibility Examples

```
Hey / Hi / Hello {{FirstName}},

Parents use our newsletters and articles to discover learning opportunities, enrichment programs, and educational support for their kids.

We reach more than {{AUDIENCE_SIZE}} weekly. I pulled together a short example showing how education brands typically gain visibility across the network.

Should I send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{FOUNDER_NAME}}
{{FOUNDER_TITLE}}
{{CREDIBILITY_MENTION}}

If this isn't relevant, just let me know.
```

### Angle 3 - Curated Brand Group

```
Hey / Hi / Hello {{FirstName}},

I'm putting together a small group of education brands that make sense for our parent audience, and {{CompanyName}} stood out during that review.

We reach more than {{AUDIENCE_SIZE}} through newsletters and trusted content. I can send over our media kit so you can see how education brands typically appear across the network.

Want me to send it over?

{{RANDOM|Thanks|Thank you|Best regards|Warm regards|Kind regards}},
{{FOUNDER_NAME}}
{{FOUNDER_TITLE}}
{{CREDIBILITY_MENTION}}

If this isn't relevant, just let me know.
```

---

## Key Selling Points (use only real, approved points)

- Reach a large, defined audience (`{{AUDIENCE_SIZE}}`)
- Trusted, editorial-driven discovery
- Audience actively seeking the client's category
- Brand-safe environment
- Founder-led credibility (`{{CREDIBILITY_MENTION}}`)
- Curated placements, not open ad inventory

## When to Use This Playbook

**Use when:**
- Targeting brands that want the network's audience
- Selling sponsorships, native placements, or content partnerships
- You want brand conversations, not ad negotiations
- Positioning long-term visibility vs short-term clicks

**Avoid when:**
- Targeting performance-only advertisers
- Selling CPC/CPA-only inventory
- Brands outside the network's audience

---

## Adapting for a client (checklist)

- [ ] `{{FirstName}}` / `{{CompanyName}}` → confirm these Instantly fields exist and are mapped
- [ ] `{{FOUNDER_NAME}}` / `{{FOUNDER_TITLE}}` → the client's real signatory (this is a founder-led angle)
- [ ] `{{AUDIENCE_SIZE}}` / `{{CREDIBILITY_MENTION}}` → real, approved audience figures and credibility proof (`voice.md` → Approved Claims)
- [ ] Re-skin the vertical/audience if the client isn't education→parents (the sample copy is)
- [ ] Keep the opt-out line
- [ ] Match tone/spelling to `clients/{slug}/voice.md`
- [ ] Log the resulting variants and PRR to `clients/{slug}/copy-library.md`
