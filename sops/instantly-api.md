# SOP - Instantly API v2 (per-client, direct)

How the OS talks to each client's Instantly workspace. This is the **direct-API** model: no MCP
server. Each client has one API key, stored git-ignored in `clients/{slug}/secrets/credentials.md`,
and the OS calls the REST API v2 with **that client's** key via one wrapper.

Official docs: <https://developer.instantly.ai/> · Base URL: `https://api.instantly.ai/api/v2`

---

## The one command

Claude never calls the API with raw `curl` (raw calls are blocked by `safety-guard.sh` because they
would put the key in the logs). All access goes through:

```
.claude/bin/instantly.sh [--client SLUG] METHOD PATH [JSON_BODY]
```

- **Active client (default):** the wrapper reads `_state/active-client`, loads that client's key, and
  calls the API. `switch to {client}` is all it takes to change which key is used.
- **Inline override:** `--client acme` targets one client for a single call without changing the
  active client (mirrors the "…for acme" inline-override rule in `wiki/_skill-context.md`).
- **Security:** the key is read from the secrets file *inside* the wrapper and passed to curl via a
  stdin config, so it never appears in argv, the process list, chat, or `.claude/sessions/*.jsonl`.
- **Isolation:** only ever one client's key is loaded per call - the active client's (or the explicit
  `--client`). No shared key, no cross-client bleed. This is enforced by construction.

### Examples

```
.claude/bin/instantly.sh GET  /campaigns
.claude/bin/instantly.sh GET  /campaigns/CAMPAIGN_ID/analytics
.claude/bin/instantly.sh POST /leads/list '{"campaign_id":"CAMPAIGN_ID","limit":50}'   # a READ
.claude/bin/instantly.sh --client acme GET /campaigns/CAMPAIGN_ID/steps-analytics
.claude/bin/instantly.sh POST /campaigns/CAMPAIGN_ID/activate                          # a WRITE - gated
```

Output ends with a `[HTTP <code>]` line so you can see the status.

---

## Read vs write - what runs automatically vs what needs approval

`safety-guard.sh` gates the wrapper by **HTTP verb**. Reads are automatic; everything else stops and
asks Harry (CLAUDE.md → Safety Guard, Credentials & Instantly Access).

| Runs automatically (reads) | Needs explicit approval (writes / sends) |
|---|---|
| Any `GET` (campaigns, analytics, accounts, emails, leads, warmup…) | Any `POST` / `PATCH` / `PUT` / `DELETE` |
| `POST /leads/list` - a list endpoint that is POST only because of complex filters | `POST /campaigns/:id/activate`, `POST /campaigns/:id/pause` |
| | `POST /campaigns`, `PATCH /campaigns/:id`, `DELETE /campaigns/:id` |
| | `POST /leads`, `PATCH /leads/:id`, `DELETE /leads/:id`, `POST /leads/bulk-add`, `POST /leads/bulk-delete` |
| | `POST /emails/reply`, `POST /emails/forward`, `PATCH /emails/:id`, `DELETE /emails/:id` |

**The rule of thumb:** if it changes the workspace or sends anything, it's a write - the guard blocks
it, and Claude must state the action + name the client/workspace and wait for a yes.

---

## Common endpoints (from the v2 spec)

| Purpose | Method + path |
|---|---|
| List campaigns | `GET /campaigns` |
| Get one campaign | `GET /campaigns/:id` |
| Campaign analytics | `GET /campaigns/:id/analytics` |
| Per-step analytics | `GET /campaigns/:id/steps-analytics` |
| Activate / resume campaign | `POST /campaigns/:id/activate` *(write)* |
| Pause campaign | `POST /campaigns/:id/pause` *(write)* |
| Create / update / delete campaign | `POST /campaigns` · `PATCH /campaigns/:id` · `DELETE /campaigns/:id` *(write)* |
| List leads (filtered) | `POST /leads/list` *(read)* |
| Get one lead | `GET /leads/:id` |
| Create / update / delete lead | `POST /leads` · `PATCH /leads/:id` · `DELETE /leads/:id` *(write)* |
| Bulk add / delete leads | `POST /leads/bulk-add` · `POST /leads/bulk-delete` *(write)* |
| List / get emails (replies) | `GET /emails` · `GET /emails/:id` |
| Reply / forward email | `POST /emails/reply` · `POST /emails/forward` *(write / send)* |

Full surface is in the OpenAPI spec: `https://api.instantly.ai/openapi/api_v2.json`.

## Rate limits (known)

- `GET /emails` (list emails): **20 requests / minute**.
- Send test email: **10 / minute / workspace**.
- AI reply-label testing: **500 / 30 days / workspace**.
- Others: not published - batch reads and avoid tight polling loops.

---

## Setup per client (once)

1. In the client's Instantly workspace: **Settings → API Keys → generate** a key labelled
   `Claude Code - {CLIENT_NAME}`. Give it the scopes the OS needs (campaign + analytics read; lead
   and campaign write only if you want the OS to action changes directly).
2. Paste it into `clients/{slug}/secrets/credentials.md → instantly_api_key` (git-ignored). Never into
   `_config.md` or any tracked file. Never print it in chat.
3. Verify: `switch to {client}` then `.claude/bin/instantly.sh GET /campaigns` → expect a campaign list
   and `[HTTP 200]`.

**Rotation:** replace the value in `clients/{slug}/secrets/credentials.md`. No repo history is touched
(the file is never tracked). Rotate quarterly or after any team change.

**Troubleshooting:** `[HTTP 401]` → key wrong/revoked/insufficient scope. `no active client` → run
`switch to {client}`. `no credentials file` → onboard the client first.

See root `CLAUDE.md` → *Credentials & Instantly Access* and `wiki/_skill-context.md` → *Instantly Access*.
