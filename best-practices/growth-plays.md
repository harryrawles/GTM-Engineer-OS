# Growth Plays

Client-agnostic tactical plays for squeezing more value out of an existing list or campaign, without
needing fresh data. Written to be proposed to a client directly, each entry below is close to sendable as
written, just adapt to the client's voice. Used by `gtm-skills/client-checkin-writer.md` when a play fits
a client's current state, can also be pulled manually any time.

**Part of the shared layer** (`CLAUDE.md` → *Shared Brain*), never client-specific, never a promotion
destination for one client's raw copy, only for the generalisable tactic itself.

---

## How to use

Each play below lists: what it is, why it works, when it fits, whether there's a real downside, and
whether proposing it means a live write to Instantly (and is therefore gated per `sops/instantly-api.md`).

Before proposing any play to a client, check `clients/{slug}/comms-log.md` and
`clients/{slug}/decision-log.md` for whether it was already proposed in the last 4 weeks (see Rotation
Discipline below). Don't repeat the same idea back to back.

---

## Play: Re-run Non-Repliers (Second-Pass Send)

**What:** Filter everyone previously sent to who never replied (no reply, no bounce, just silence) into a
fresh list, and run them through the sequence again as a brand-new send.

**Why it works:** Silence rarely means no, it usually means bad timing, inboxes are chaos and the first
send simply landed at the wrong moment. A second pass catches a different moment, and because the name has
already been seen once, a familiarity effect makes the second touch land warmer than a cold first one.

**When it fits:** The campaign has been live long enough to have a meaningful non-reply pool (typically
3+ weeks, enough sends per `wiki/scientific-method.md` sample-size guidance), and either no fresh data is
available right now or the GTME wants to extract more value from the existing list while new data or a
new campaign is being built.

**Downside:** None, these are contacts already owned, no new data spend required.

**Write required:** Yes, moving leads back into a campaign is a WRITE (`POST /leads/move` or re-adding via
`POST /leads/add`), gated per `sops/instantly-api.md`. Get the client's go-ahead in the message, then get
the GTME's explicit approval before running it.

---

## Play: Add an Extra Sequence Step

**What:** Add one more email to the existing sequence, so everyone still active in it gets an additional
automatic touch, no list reshuffling needed.

**Why it works:** Extends the number of touches without needing new data or a rebuild, and catches recent
sends that haven't finished the sequence yet, complementary to the re-run play above rather than a
substitute for it.

**When it fits:** Works well paired with the re-run play (the extra step catches recent sends, the re-run
catches the older, fully-lapsed ones), or on its own if the list is too small to justify a second pass.

**Downside:** None, no new data needed, reuses the existing campaign structure.

**Write required:** Yes, editing the sequence is a WRITE (`PATCH /campaigns/{id}`), gated per
`sops/instantly-api.md`.

---

## Rotation Discipline

Before proposing any play to a client, check `clients/{slug}/comms-log.md` and
`clients/{slug}/decision-log.md` for a prior mention of that same play within the last 4 weeks. If found,
propose the next-most-relevant play instead, or skip proposing anything that week rather than repeating
the same idea back to back.

---

## Adding a New Play

When a tactic works for a client and is genuinely generalisable (works for any client, not tied to one
client's specific data, offer, or copy), promote it here, de-identified, following the same promotion
discipline as `gtm-skills/weekly-reviewer.md` Step 8, strip client name, numbers, and verbatim copy before
it lands in this file.
