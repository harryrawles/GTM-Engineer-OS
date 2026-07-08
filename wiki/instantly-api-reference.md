# Instantly API v2 - Full Reference

The comprehensive endpoint-by-endpoint reference for the Instantly v2 API. `sops/instantly-api.md` is the
operational "how the OS calls it" SOP (auth model, the wrapper command, safety gating); this file is the
deep reference for what the API can actually do, sourced directly from the live OpenAPI spec
(`https://api.instantly.ai/openapi/api_v2.json`) and `https://developer.instantly.ai/`.

**Base URL:** `https://api.instantly.ai` - every path below is `/api/v2/...`.

**Read this file when:** building a new integration point, debugging an unexpected response shape, or
checking whether an endpoint has a rate limit, a batch-size cap, or an async job pattern before wiring it
into a skill.

---

## Table of Contents

1. [Conventions](#1-conventions) - auth, versioning, rate limits, pagination, errors, global field patterns
2. [Campaigns](#2-campaigns)
3. [Leads, Lead Lists, Subsequences](#3-leads-lead-lists-subsequences)
4. [Sending Accounts and Warmup](#4-sending-accounts-and-warmup)
5. [Inbox, Email, Verification, Templates](#5-inbox-email-verification-templates)
6. [Workspace, Members, Billing, API Keys](#6-workspace-members-billing-api-keys)
7. [Webhooks](#7-webhooks)
8. [Audit Logs and Background Jobs](#8-audit-logs-and-background-jobs)
9. [Enrichment (SuperSearch)](#9-enrichment-supersearch)
10. [Custom Tags and Tag Mappings](#10-custom-tags-and-tag-mappings)
11. [Custom Prompt Templates](#11-custom-prompt-templates)
12. [Lead Labels](#12-lead-labels)
13. [Inbox Placement Testing](#13-inbox-placement-testing)
14. [DFY Email Account Orders](#14-dfy-email-account-orders)
15. [CRM Actions](#15-crm-actions)
16. [Blocklist](#16-blocklist)
17. [Known Gaps and Undocumented Areas](#17-known-gaps-and-undocumented-areas)

---

## 1. Conventions

### Authentication

- Header: `Authorization: Bearer {api_key}` (standard HTTP Bearer scheme, security scheme name
  `ApiKeyAuth`, applied globally to every endpoint).
- Generate a key: workspace Settings/Integrations - API Keys - create - name it - choose scopes - save.
  The key is shown once only, it cannot be recovered later if lost (only rotated).
- Scopes follow a `resource:action` pattern, action is one of `all | create | read | update | delete`
  (e.g. `campaigns:read`, `leads:all`). A workspace-wide wildcard tier also exists: `all:all`, `all:create`,
  `all:read`, `all:update`, `all:delete`. Every endpoint's own description states exactly which scopes
  satisfy it.
- Multiple keys per workspace are supported and independently revocable.
- V1 and V2 keys are not interchangeable. V1 was deprecated 2026-01-19, use v2 for everything.
- A separate OAuth flow exists only for connecting client Google/Microsoft mailboxes into a workspace
  (`POST /api/v2/oauth/google/init`, `.../microsoft/init`, plus a status-poll endpoint) - this authorises
  *mailboxes*, not API calls. Normal API calls always use the Bearer key.

### Base URL and versioning

- `https://api.instantly.ai`, every endpoint prefixed `/api/v2/...`. Versioning is path-based, there is no
  header or query-param version.
- Naming is strict snake_case throughout (`timestamp_created`, `target_hook_url`, `starting_after`).
- `POST /api/v2/leads/list` is a deliberate exception to REST convention (POST instead of GET) because the
  filter payload is too complex for query params - the spec calls this out explicitly.

### Rate limits

**Global (applies to every endpoint, workspace-wide, shared across all API keys and both API versions):**

- **100 requests/second** and **6,000 requests/minute**. Breaching either returns `429`.
- No `X-RateLimit-*` or `Retry-After` response headers exist anywhere in the spec, only a JSON error body.
- Instantly's own guidance for bulk work: batch in groups of ~100 with a 2-second pause between batches,
  and spread large jobs across 2-4 runs/day rather than one burst.

**Per-endpoint overrides (the only six endpoints in the whole spec with a numeric override):**

| Endpoint | Limit |
|---|---|
| `GET /api/v2/emails` | 20 requests/minute |
| `POST /api/v2/emails/test` | 10 requests/minute per workspace |
| `POST /api/v2/lead-labels/ai-reply-label` | 500 requests/30 days per workspace (test/simulate endpoint only - does not apply to live automatic reply tagging) |
| `POST /api/v2/dfy-email-account-orders/domains/check` | 30 requests/minute, or 900/hour |
| `POST /api/v2/oauth/google/init` | 75/min per workspace, 150/min per IP, escalating blocks on abuse (30 min then 2h then 24h) |
| `POST /api/v2/oauth/microsoft/init` | Same as Google |

Everything else falls under the global ceiling only.

### Pagination

- Cursor-based, not offset/limit (with one exception noted below).
- Request params: `limit` (integer, 1-100, no stated default, always pass it explicitly) and
  `starting_after` (opaque cursor string, typically a UUID but can be a timestamp or email depending on
  the endpoint).
- Response shape, consistent everywhere: `{ "items": [...], "next_starting_after": "..." }`. Feed
  `next_starting_after` back in as `starting_after` for the next page.
- Exception: `GET /api/v2/accounts` also supports an offset-style `skip` param alongside the cursor. Don't
  mix the two pagination styles in one call.
- `POST /api/v2/leads/list` orders by `id` ascending (or by `contact`/email when `distinct_contacts:true`).
  Leads created before 2025-10-15 may appear out of sequence when paginating by ID.

### Error handling

Standard error body, all three fields required on every error response:

```json
{ "statusCode": 401, "error": "Unauthorized", "message": "Missing Authorization header" }
```

| Status | Meaning in this API |
|---|---|
| 400 | Invalid request body (missing/invalid field) |
| 401 | Missing or revoked API key |
| 402 | Workspace has no active paid plan (common, hits many endpoints, distinct from auth failure) |
| 404 | Resource not found |
| 409 | Unique-constraint violation (e.g. duplicate custom tag name) |
| 429 | Rate limit exceeded |

**Gotcha:** some endpoints return errors inside a `200` response body instead of a non-2xx status, e.g.
`POST /api/v2/emails/test` returns `{"status":"success"}` on success but `{"error":"ACC_AUTH_ERROR"}` (still
HTTP 200) on failure. Never assume HTTP status alone reflects success, check documented body fields too.

### Global field conventions

- Every resource's primary key is `id` (string, UUID). Foreign keys are inconsistent: sometimes
  `{resource}_id`, sometimes the bare resource name (`campaign_id` as a filter vs `campaign` as a field on
  `Webhook`) - check each schema, don't assume one universal rule.
- Timestamps: ISO 8601 with milliseconds, UTC, `Z` suffix, fields named `timestamp_created` /
  `timestamp_updated` (not `created_at`/`updated_at`).
- Date-only fields (e.g. campaign `start_date`/`end_date`): plain `YYYY-MM-DD`, in the *resource's own
  configured timezone*, not UTC or workspace-wide.
- Time-of-day fields (e.g. sending windows): `HH:MM` 24-hour, same per-resource timezone rule.
- Numeric status enums carry semantic meaning via `x-enumDescriptions` rather than string values - e.g.
  `Campaign.status`: `0`=Draft, `1`=Active, `2`=Paused, `3`=Completed, `4`=Running Subsequences,
  `-1`=Accounts Unhealthy, `-2`=Bounce Protect, `-99`=Account Suspended. Treat every status field as an
  integer enum, not a string, unless stated otherwise.

---

## 2. Campaigns

Total: 20 endpoints (19 tagged `Campaign` + 1 `AccountCampaignMapping`). **No native bulk-activate or
bulk-pause endpoint exists** despite those names appearing as MCP tool wrappers - only single-campaign
`POST /{id}/activate` and `POST /{id}/pause` exist server-side. Bulk behaviour must be a client-side loop
respecting the global rate limit.

### Campaign object (shared shape, returned by CRUD + lifecycle calls)

| Field | Type | Notes |
|---|---|---|
| `id` | string | UUID |
| `name` | string | required |
| `status` | number enum | see Global field conventions above |
| `not_sending_status` | number\|null enum | `1`=out of schedule, `2`=waiting for lead to process, `3`=daily send limit hit, `4`=all sending accounts hit their limit, `99`=error, contact support. Read-only. |
| `campaign_schedule` | object, required | `{ start_date, end_date, schedules: [{ name, timing: {from, to} (HH:MM), days: {"0".."6": bool, 0=Sun}, timezone (IANA) }] }`, min 1 schedule |
| `sequences` | array, required | **only `sequences[0]` is used** even though it's an array - put every step inside that one element's `steps` array. Each step: `{ type: "email", delay, delay_unit: minutes|hours|days, variants: [{ subject, body, v_disabled }] }` |
| `email_list` / `cc_list` / `bcc_list` | array\<string\> | sending accounts / cc / bcc |
| `daily_limit`, `email_gap`, `random_wait_max`, `daily_max_leads` | number\|null | pacing controls |
| `stop_on_reply`, `stop_on_auto_reply`, `stop_for_company` | boolean\|null | |
| `open_tracking`, `link_tracking`, `text_only`, `first_email_text_only` | boolean(\|null) | |
| `is_evergreen`, `prioritize_new_leads`, `match_lead_esp`, `allow_risky_contacts`, `disable_bounce_protect`, `insert_unsubscribe_header` | boolean\|null | |
| `pl_value` | number\|null | value assigned per positive lead |
| `owned_by`, `ai_sdr_id`, `organization` | string\|null | |
| `timestamp_created`, `timestamp_updated` | string | read-only |

### Campaign CRUD

| Method + Path | Purpose | Key params | Type |
|---|---|---|---|
| `POST /campaigns` | Create | `name`* , `campaign_schedule`* required, everything else in the object above optional | WRITE |
| `GET /campaigns` | List | `limit`, `starting_after`, `search` (name), `tag_ids` (csv), `ai_sales_agent_id`, `status` | READ |
| `GET /campaigns/{id}` | Get one | path `id`* | READ |
| `PATCH /campaigns/{id}` | Update | any subset of create fields, partial update | WRITE |
| `DELETE /campaigns/{id}` | Delete | path `id`* | WRITE, irreversible |

### Campaign lifecycle

| Method + Path | Purpose | Type | Gotcha |
|---|---|---|---|
| `POST /campaigns/{id}/activate` | Start or resume | WRITE | Also serves as "resume" from paused |
| `POST /campaigns/{id}/pause` | Pause | WRITE | No bulk variant, loop client-side |
| `POST /campaigns/{id}/duplicate` | Duplicate | WRITE | Body `name` optional, defaults to "`<original>` (copy)" |
| `GET /campaigns/{id}/sending-status` | Diagnose why a campaign isn't sending / is slow | READ | Query `with_ai_summary` (bool). Response `{ diagnostics, summary }`, both nullable. Some fields absent when out of schedule window |

### Sharing, export, variables

| Method + Path | Purpose | Type | Gotcha |
|---|---|---|---|
| `POST /campaigns/{id}/share` | Share so others can create from it | WRITE | **Share expires after 7 days**, must re-call to keep active |
| `POST /campaigns/{id}/from-export` | Create a new campaign from a shared/exported one | WRITE | 403 "requested campaign not shared" if the share lapsed |
| `POST /campaigns/{id}/export` | Export to JSON | READ | POST verb, but read-only |
| `POST /campaigns/{id}/variables` | Set campaign-level variables | WRITE | Body `variables` (array\<string\>) |

### Campaign analytics

| Method + Path | Purpose | Key params | Gotcha |
|---|---|---|---|
| `GET /campaigns/analytics` | Per-campaign summary (one row per campaign) | `id`, `ids` (repeat param, not csv), `start_date`, `end_date`, `exclude_total_leads_count` (bool, speeds up the call) | Omitting `id`/`ids` returns every campaign, expensive |
| `GET /campaigns/analytics/overview` | Aggregated totals across one/many/all campaigns | `id`, `ids`, `start_date`, `end_date`, `campaign_status`, `expand_crm_events` (bool) | Interest-status totals (`total_interested`, `total_meeting_booked`, etc.) count only the first occurrence per contact unless `expand_crm_events:true`. A 10-minute dedupe window suppresses rapid re-triggered events. |
| `GET /campaigns/analytics/daily` | Day-by-day time series | `campaign_id` (single only, no `ids`), `start_date`, `end_date`, `campaign_status` | No multi-campaign filter, unlike the other two analytics endpoints |
| `GET /campaigns/analytics/steps` | Per-step / per-variant breakdown | `campaign_id`, `start_date`, `end_date`, `include_opportunities_count` (bool) | `step`/`variant` can be null when an event can't be attributed to a step |

### Misc

| Method + Path | Purpose | Type |
|---|---|---|
| `GET /campaigns/count-launched` | Count of campaigns ever launched, workspace-wide | READ |
| `GET /campaigns/search-by-contact` | Which campaign(s) a lead email belongs to | READ |
| `GET /account-campaign-mappings/{email}` | Given a sending account email, list campaigns it's used in | READ |

Subsequences are a related but distinct object, see [Section 3](#3-leads-lead-lists-subsequences).

---

## 3. Leads, Lead Lists, Subsequences

### Leads CRUD

**`POST /leads`** (create, WRITE) - body (all optional except noted): `campaign` (uuid), `list_id` (uuid),
`email`, `first_name`, `last_name`, `company_name`, `job_title`, `phone`, `website`, `personalization`,
`lt_interest_status` (number enum `[1,2,3,4,0,-1,-2,-3,-4]`), `pl_value_lead`, `assigned_to` (uuid),
`blocklist_id`, `skip_if_in_workspace`/`skip_if_in_campaign`/`skip_if_in_list` (bool dedupe guards),
`verify_leads_for_lead_finder`/`verify_leads_on_import` (bool), `custom_variables` (object, string/number/
boolean/null values only, no nesting - this is how personalisation merge-tags get set).

**`GET /leads/{id}`** (READ), **`PATCH /leads/{id}`** (WRITE, subset of create fields, cannot change
`email`/`campaign`/`list_id`), **`DELETE /leads/{id}`** (WRITE) all standard, path `id`* required.

Response Lead object includes: `status` (1,2,3,-1,-2,-3), `verification_status`, `enrichment_status`,
`subsequence_id`, engagement counters (`email_open_count`, `email_reply_count`, `email_click_count`),
`status_summary`, `payload` (a read-only camelCase mirror, e.g. `firstName` - always write through the
snake_case fields + `custom_variables`, never rely on `payload` being writable), `upload_method`
(`manual`/`api`/`website-visitor`), `esp_code`/`esg_code`, `assigned_to`.

### Leads - bulk and filtered operations

| Method + Path | Purpose | Key params | Type | Gotcha |
|---|---|---|---|---|---|
| `POST /leads/list` | Filtered search | `search`, `filter` (enum, see below), `campaign`, `list_id`, `in_campaign`/`in_list`, `ids`, `excluded_ids`, `contacts`, `queries`, `smart_view_id`, `is_website_visitor`, `distinct_contacts`, `limit`, `starting_after` | READ | See pagination note above re: pre-2025-10-15 leads |
| `POST /leads/add` | Bulk add to a campaign or list | `campaign_id` XOR `list_id`, `leads`* (array, **max 1000/call**), `blocklist_id`, `assigned_to`, `verify_leads_on_import`, skip-if-* flags | WRITE | Synchronous - returns `created_leads` mapping input to created records immediately |
| `DELETE /leads` | Bulk delete | `campaign_id` OR `list_id`, `status`, `ids`, `limit` | WRITE, destructive | **No `limit` = deletes everything matching** |
| `POST /leads/bulk-assign` | Bulk assign to org users | `organization_user_ids`*, plus the same filter surface as `/leads/list` | WRITE | Returns `202 Accepted`, async background job, no job ID returned in body |
| `POST /leads/merge` | Merge two leads | `lead_id`* (merged away), `destination_lead_id`* (survives) | WRITE | Single pair per call |
| `POST /leads/move` | Move to a campaign or list | same filters as `/leads/list` + `to_campaign_id`/`to_list_id`, `copy_leads` (bool), `reset_interest_status` (bool) | WRITE | If using `ids` you must also pass `campaign` or `list_id` (ids filters within a source, isn't standalone). Returns a background job, poll `/background-jobs/{id}` |
| `POST /leads/update-interest-status` | Update interest status | `lead_email`* (**by email, not id**), `interest_value` (null resets to default), `campaign_id`, `list_id`, `ai_interest_value`, `disable_auto_interest` | WRITE | |

Filter enum used by `/leads/list`, `/leads/move`, `/leads/bulk-assign`: `FILTER_VAL_CONTACTED`,
`FILTER_VAL_NOT_CONTACTED`, `FILTER_VAL_COMPLETED`, `FILTER_VAL_UNSUBSCRIBED`, `FILTER_VAL_ACTIVE`,
`FILTER_LEAD_INTERESTED`, `FILTER_LEAD_NOT_INTERESTED`, `FILTER_LEAD_MEETING_BOOKED`,
`FILTER_LEAD_MEETING_COMPLETED`, `FILTER_LEAD_CLOSED`, `FILTER_LEAD_OUT_OF_OFFICE`,
`FILTER_LEAD_WRONG_PERSON`, `FILTER_LEAD_LOST`, `FILTER_LEAD_NO_SHOW`,
`FILTER_LEAD_CUSTOM_LABEL_POSITIVE`, `FILTER_LEAD_CUSTOM_LABEL_NEGATIVE`, `FILTER_VAL_BOUNCED`,
`FILTER_VAL_SKIPPED`, `FILTER_VAL_RISKY`, `FILTER_VAL_INVALID`, `FILTER_VAL_VALID`,
`FILTER_VAL_IN_SUBSEQUENCE`, `FILTER_VAL_OPENED_NO_REPLY`, `FILTER_VAL_COMPLETED_NO_REPLY`,
`FILTER_VAL_NO_OPENS`, `FILTER_VAL_REPLIED`, `FILTER_VAL_LINK_CLICKED`.

### Leads to subsequence

| Method + Path | Purpose | Type |
|---|---|---|
| `POST /leads/subsequence/move` | Move a lead into a subsequence | WRITE, single lead only |
| `POST /leads/subsequence/remove` | Remove a lead from its subsequence | WRITE, single lead only |

To move a lead from Subsequence A to B, call `move` again with the new `subsequence_id` - there's no
dedicated between-subsequences endpoint.

### Lead Lists CRUD

| Method + Path | Purpose | Key params | Type |
|---|---|---|---|
| `POST /lead-lists` | Create | `name`*, `has_enrichment_task` (bool, auto-enrich on add), `owned_by` | WRITE |
| `GET /lead-lists` | List | `limit`, `starting_after`, `has_enrichment_task`, `search` | READ |
| `GET /lead-lists/{id}` | Get one | path `id`* | READ |
| `PATCH /lead-lists/{id}` | Update | `name`, `has_enrichment_task`, `owned_by`, all optional | WRITE |
| `DELETE /lead-lists/{id}` | Delete | path `id`* | WRITE. Not documented as cascading - check whether leads inside need moving first |
| `GET /lead-lists/{id}/verification-stats` | Verification stats for the list | path `id`* | READ, returns `total_leads` + `stats {verified, invalid, risky, catch_all, job_change, ...}` |

### Subsequences CRUD and control

**`POST /subsequences`** (WRITE) - body: `parent_campaign`*, `name`*, `conditions`* (trigger, e.g. "no
reply after step X"), `subsequence_schedule`* , `sequences`* (**same one-array-element-only rule as
campaigns**), `daily_limit_mode` (`inherit`/`custom`/`unlimited`), `daily_limit`, `ignore_account_daily_limit`.

| Method + Path | Purpose | Type | Gotcha |
|---|---|---|---|
| `GET /subsequences` | List | READ | `parent_campaign` query param is **required**, cannot list workspace-wide |
| `GET /subsequences/{id}` | Get one | READ | |
| `PATCH /subsequences/{id}` | Update | WRITE | Only `name`, `daily_limit_mode`, `daily_limit`, `ignore_account_daily_limit` are patchable - `conditions`/`schedule`/`sequences`/`parent_campaign` are not |
| `DELETE /subsequences/{id}` | Delete | WRITE | |
| `POST /subsequences/{id}/duplicate` | Duplicate, optionally into a different campaign | WRITE | body `parent_campaign`*, `name`* |
| `POST /subsequences/{id}/pause` | Pause | WRITE | |
| `POST /subsequences/{id}/resume` | Resume | WRITE | |
| `GET /subsequences/{id}/sending-status` | Diagnose sending | READ | query `with_ai_summary` (bool) |

### Structural notes for lead-write code

1. Most endpoints key leads by `id` (uuid), but `update-interest-status` uniquely keys by `lead_email`.
2. Write personalisation through `custom_variables` (create/patch), never through the read-only `payload`
   mirror.
3. `/leads/add` and `/leads/merge` are synchronous. `/leads/move` and `/leads/bulk-assign` are async
   (background job / 202), poll `/background-jobs/{id}`.
4. Hard cap: 1000 leads per `/leads/add` call. `/leads/move` and bare `DELETE /leads` are filter-driven and
   can silently affect an unbounded number of records if `limit` is omitted.
5. `lt_interest_status`'s exact ordinal-to-label mapping isn't printed inline in the spec - verify against
   a live account before hardcoding, since custom lead labels can also occupy this field.

---

## 4. Sending Accounts and Warmup

### Accounts (mailboxes)

Accounts are keyed by **email address** in the real REST API, not an opaque ID (some tool wrappers alias
it as `id`, the underlying path param is always `email`).

| Method + Path | Purpose | Key params | Type |
|---|---|---|---|
| `POST /accounts` | Create via SMTP/IMAP creds | `email`*, `first_name`*, `last_name`*, `provider_code`* (1=Custom, 2=Google, 3=Microsoft, 4=AWS, 8=AirMail), `smtp_*`/`imap_*` creds, `daily_limit`, `warmup{limit, increment, advanced}`, `tracking_domain_name`, `signature`, `reply_to`, `sending_gap` (0-1440 min), `enable_slow_ramp`, `inbox_placement_test_limit` | WRITE |
| `GET /accounts/{email}` | Get one | path `email`* | READ |
| `GET /accounts` | List/search | `limit`, `starting_after`, `skip` (offset, don't mix with cursor), `search`, `status`, `provider_code`, `tag_ids`/`tag_ids_all`, `filter` (`ACC_FILTER_PAUSED`/`ACC_FILTER_ERROR`/`ACC_FILTER_DFY`/etc.), `sort_by`, `sort_order` | READ |
| `PATCH /accounts/{email}` | Update | `first_name`, `last_name`, `daily_limit`, `sending_gap`, `signature`, `reply_to`, `tracking_domain_name`, `enable_slow_ramp`, `warmup{...}`, min 1 field | WRITE |
| `DELETE /accounts/{email}` | Delete | path `email`* | WRITE. Effect on campaigns actively using it isn't documented, verify empirically |
| `POST /accounts/{email}/pause` | Pause | path `email`* | WRITE |
| `POST /accounts/{email}/resume` | Resume | path `email`* | WRITE |
| `POST /accounts/{email}/mark-fixed` | Clear an error flag after fixing the underlying issue | path `email`* | WRITE, doesn't fix anything itself |
| `POST /accounts/test/vitals` | Test DNS vitals (MX/SPF/DKIM/DMARC) | `accounts` (array of emails) | READ, diagnostic |
| `GET /accounts/ctd/status` | Check custom tracking domain SSL/CNAME | `host`* | READ |

`Account.status` enum: `1`=Active, `2`=Paused, `3`=Maintenance, `-1`=Conn Error, `-2`=Soft Bounce,
`-3`=Sending Error. `warmup_status` enum: `0`=Paused, `1`=Active, `-1`=Banned, `-2`=Spam Folder Unknown,
`-3`=Permanent Suspension. `warmup.increment` uses the string `"disabled"` for full-limit sending, not
numeric `0`.

### Warmup

| Method + Path | Purpose | Key params | Type | Gotcha |
|---|---|---|---|---|---|
| `POST /accounts/warmup/enable` | Bulk enable | `emails[]` (max 100) OR `include_all_emails` + `excluded_emails[]` + `filter{tag_id, filter, search}` | WRITE | **Async** - returns a `BackgroundJob`, not a completed state. Poll `/background-jobs/{id}` |
| `POST /accounts/warmup/disable` | Bulk disable | same shape as enable | WRITE | Same async caveat |
| `POST /accounts/warmup-analytics` | Warmup performance (sent/inbox/spam/health) | `emails[]` (min 1, max 100) | READ | POST despite being a read (body-driven lookup) |

No documented warmup-specific rate limit beyond the global ceiling. The real gotcha is that
enable/disable are fire-and-forget background jobs, not synchronous state changes.

---

## 5. Inbox, Email, Verification, Templates

### Inbox / email management

| Method + Path | Purpose | Key params | Type | Gotcha |
|---|---|---|---|---|---|
| `GET /emails` | List Unibox emails | `limit`, `starting_after`, `search` (supports `thread:` prefix), `campaign_id`, `list_id`, `eaccount`, `is_unread`, `mode` (`emode_focused`/`emode_others`/`emode_all`), `email_type` (`received`/`sent`/`manual`), `min/max_timestamp_created` | READ | **20 requests/minute** |
| `GET /emails/{id}` | Get one (full body/headers/thread) | path `id`* | READ | Timestamps can be inaccurate if sender/server manipulated them |
| `PATCH /emails/{id}` | Mark read/unread, set/clear reminder | `is_unread`, `reminder_ts`, only these two fields | WRITE | |
| `DELETE /emails/{id}` | Delete | path `id`* | WRITE | |
| `POST /emails/reply` | Reply in-thread | `eaccount`*, `reply_to_uuid`*, `subject`*, `body{html,text}`* | WRITE | `reply_to_uuid` must reference an existing email, can't reply to an arbitrary address |
| `POST /emails/forward` | Forward | `reply_to_uuid`*, `to_address_email_list`*, `eaccount`*, `subject`*, at least one of `body`/`include_original_body:true` | WRITE | |
| `POST /emails/threads/{thread_id}/mark-as-read` | Mark whole thread read | path `thread_id`* | WRITE | |
| `GET /emails/unread/count` | Unread count | none | READ | |
| `POST /emails/test` | Send a test/preview email | `eaccount`*, `to_address_email_list`*, `subject`*, `body{html}`* | WRITE | **10/min/workspace**. Errors return as HTTP 200 with an `error` field (`ACC_AUTH_ERROR`/`ACC_NOT_FOUND`/`ACC_UNKNOWN_ERROR`), check the body not just status |

### Email verification

| Method + Path | Purpose | Key params | Type | Gotcha |
|---|---|---|---|---|---|
| `POST /email-verification` | Verify an address | `email`*, `webhook_url` (for async results) | WRITE | Read `verification_status` (`pending`/`verified`/`invalid`), never the top-level `status`, for the actual result. If verification takes over 10s it returns `pending` synchronously. Consumes credits. |
| `GET /email-verification/{email}` | Poll a pending result | path `email`* | READ | |

### Email templates - undocumented

`email_templates_create/list/delete` exist as MCP tool names but have **zero documented HTTP paths** in
the public OpenAPI spec or `developer.instantly.ai`. Treat as undocumented/private API surface - don't
build hard dependencies on their exact request/response shape without a runtime contract test, and log
full raw responses the first time a skill hits one.

---

## 6. Workspace, Members, Billing, API Keys

### Workspace

| Method + Path | Purpose | Key params | Type | Gotcha |
|---|---|---|---|---|---|
| `GET /workspaces/current` | Get current workspace (resolved from the API key) | none | READ | No workspace-ID param exists anywhere in this API, it's always implicit from the key |
| `PATCH /workspaces/current` | Update name/logo | `name`, `org_logo_url` | WRITE | Billing/plan fields aren't writable here |
| `POST /workspaces/current/change-owner` | Transfer ownership | `email`*, `sec`* | WRITE | `sec` is an undocumented confirmation token, treat as sensitive. Irreversible |
| `POST /workspaces/current/schedule-for-removal` | Schedule deletion | none | WRITE, destructive | 24-hour grace window |
| `DELETE /workspaces/current/schedule-for-removal` | Cancel a pending deletion | none | WRITE | Must be inside the 24h window |
| `GET /workspaces/current/whitelabel-domain` | Get agency whitelabel status | none | READ | |
| `POST /workspaces/current/whitelabel-domain` | Set agency domain | `domain`* | WRITE | Call GET after to retrieve the DNS records to publish |
| `DELETE /workspaces/current/whitelabel-domain` | Remove | none | WRITE | |
| `GET /workspace-billing/plan-details` | Plan + addons | none | READ | Nested objects are loosely typed, inspect at runtime |
| `GET /workspace-billing/subscription-details` | Line-item subscriptions | none | READ | Includes `price_in_dollars`, `current_period_end`, `cancel_at_time` per product |

### Workspace members

| Method + Path | Purpose | Key params | Type |
|---|---|---|---|
| `GET /workspace-members` | List | `limit`, `starting_after`, `accepted`, `search` | READ |
| `POST /workspace-members` | Invite | `email`*, `nickname`, `role`* (`admin`/`editor`/`view`/`client` - `owner` cannot be set via API), `permissions[]` | WRITE |
| `GET /workspace-members/{id}` | Get one | path `id`* | READ |
| `PATCH /workspace-members/{id}` | Update nickname/role | `nickname`, `role` | WRITE. `permissions` is not patchable here, only settable at create |
| `DELETE /workspace-members/{id}` | Remove | path `id`* | WRITE, destructive |

### Workspace group members (agency multi-workspace linking)

| Method + Path | Purpose | Type | Gotcha |
|---|---|---|---|
| `GET /workspace-group-members` | List sub-workspace links | READ | |
| `POST /workspace-group-members` | Invite a sub-workspace | WRITE | Only sends an invite, becomes active once the sub-workspace owner accepts |
| `GET /workspace-group-members/admin` | Is the current workspace itself a managed sub-workspace | READ | `{ workspace_name, has_admin_workspace, workspace_group_member_id }` |
| `GET /workspace-group-members/{id}` | Get one link | READ | |
| `DELETE /workspace-group-members/{id}` | Unlink | WRITE, destructive | |

### API keys

| Method + Path | Purpose | Key params | Type | Gotcha |
|---|---|---|---|---|---|
| `GET /api-keys` | List | `limit`, `starting_after` | READ | **Returns the full key value unmasked** - never log this response |
| `POST /api-keys` | Create | `name`*, `scopes`*[] | WRITE | Capture `key` immediately, it's a live credential |
| `DELETE /api-keys/{id}` | Revoke | path `id`* | WRITE, destructive | Revoking the key your own automation uses locks you out immediately |

---

## 7. Webhooks

### Management

| Method + Path | Purpose | Key params | Type |
|---|---|---|---|
| `GET /webhooks` | List | `limit`, `starting_after`, `campaign`, `event_type` | READ |
| `POST /webhooks` | Create | `target_hook_url`* (must match `^https?://`), `event_type` (null = custom-label event, `"all_events"` = everything), `campaign` (null = all campaigns), `name`, `custom_interest_value` (for custom-label subscriptions), `headers` (static key/value map sent with every delivery) | WRITE |
| `GET /webhooks/{id}` | Get one | path `id`* | READ |
| `PATCH /webhooks/{id}` | Update | same fields as create | WRITE |
| `DELETE /webhooks/{id}` | Delete | path `id`* | WRITE |
| `POST /webhooks/{id}/resume` | Re-enable after auto-disable from repeated failures | path `id`* | WRITE |
| `POST /webhooks/{id}/test` | Fire a test payload | path `id`* | WRITE (real HTTP call to your endpoint) |

`Webhook.status`: `1`=active, `-1`=error/disabled due to delivery failures. Instantly auto-disables a
webhook after enough failures rather than retrying forever, poll `status`/`timestamp_error` to detect this.

### Event types and verification

**`GET /webhooks/event-types`** lists every subscribable type including dynamically-created custom labels
- use this at runtime rather than hardcoding, since custom-label events are workspace-specific.

**Static event types:** `all_events`, `email_sent`, `email_opened`, `email_link_clicked`,
`reply_received`, `email_bounced`, `lead_unsubscribed`, `campaign_completed`, `account_error`,
`lead_neutral`, `lead_interested`, `lead_not_interested`, `lead_meeting_booked`, `lead_meeting_completed`,
`lead_closed`, `lead_out_of_office`, `lead_wrong_person`, `lead_no_show`,
`supersearch_enrichment_completed`. Plus any custom lead label as its own event.

**Payload base fields:** `timestamp`, `event_type`, `workspace`, `campaign_id`, `campaign_name`, plus
conditional fields by event category (`lead_email`, `email_account`, `unibox_url`, step/variant info,
`email_subject`/`email_text`/`email_html`, `reply_text_snippet`/`reply_subject`/`reply_text`/`reply_html`).

**No signature verification exists.** Checked exhaustively across the spec and docs for HMAC, signing
secret, or any cryptographic verification mechanism - none exists. The only quasi-auth is the `headers`
field on create/update: set a static shared-secret header yourself (e.g. `{"X-My-Secret": "<random>"}`)
and check for an exact match on receipt. This is caller-defined static-header matching, not a rotating
signature - it does not protect against someone who has both the URL and the header value. **If a skill
needs strong inbound-webhook verification, it must implement its own shared-secret check via `headers`,
Instantly provides nothing stronger.**

Delivery is retried with undocumented backoff, tracked via `retry_count`, `will_retry`,
`timestamp_next_retry`, `retry_group_id`, `retry_successful` on each event record.

### Delivery log and analytics (all READ)

| Method + Path | Purpose | Key params |
|---|---|---|
| `GET /webhook-events` | List individual delivery attempts | `limit`, `starting_after`, `success`, `from`, `to`, `search` |
| `GET /webhook-events/{id}` | One delivery event, includes full `payload` sent | path `id`* |
| `GET /webhook-events/summary` | Aggregate success/failure counts | `from`, `to` |
| `GET /webhook-events/summary-by-date` | Same, bucketed by day | `from`, `to` |

---

## 8. Audit Logs and Background Jobs

| Method + Path | Purpose | Key params | Type | Gotcha |
|---|---|---|---|---|---|
| `GET /audit-logs` | List workspace audit entries | `limit`, `starting_after`, `activity_type` (opaque number), `search`, `start_date`, `end_date` | READ | `activity_type` has no published number-to-label lookup table anywhere, `from_api` (bool) distinguishes UI vs API-driven actions |
| `GET /background-jobs` | List async jobs | `limit`, `starting_after`, `ids`, `type`, `entity_type`, `entity_id`, `status` | READ | Poll this for any endpoint that returned a job ID (warmup enable/disable, leads move, bulk-assign, enrichment) |
| `GET /background-jobs/{id}` | Get one job | path `id`*, query `data_fields` | READ | `data` shape is job-type-specific, no fixed schema. No webhook exists for job completion, polling is the only option |

---

## 9. Enrichment (SuperSearch)

Base path `/api/v2/supersearch-enrichment/*`.

| Method + Path | Purpose | Type |
|---|---|---|
| `POST /supersearch-enrichment/` | Create + auto-run an enrichment on a resource | WRITE |
| `POST /supersearch-enrichment/ai` | Create an AI enrichment column | WRITE |
| `GET /supersearch-enrichment/ai/{resource_id}/in-progress` | AI enrichment jobs in progress for a resource | READ |
| `POST /supersearch-enrichment/count-leads-from-supersearch` | Count leads matching a query (no enrichment) | READ |
| `POST /supersearch-enrichment/enrich-leads-from-supersearch` | Pull + enrich leads from a SuperSearch query | WRITE |
| `GET /supersearch-enrichment/history/{resource_id}` | Enrichment run history | READ |
| `POST /supersearch-enrichment/preview-leads-from-supersearch` | Preview matches, no enrichment/import | READ |
| `POST /supersearch-enrichment/run` | Run all/specific enrichments on a resource | WRITE |
| `POST /supersearch-enrichment/signal-keywords-facet` | Autocomplete for the Signals filter | READ |
| `GET /supersearch-enrichment/{resource_id}` | Get enrichment config/state | READ |
| `PATCH /supersearch-enrichment/{resource_id}/settings` | Update auto-update/skip settings | WRITE, needs `supersearch_enrichments:create` scope (not `:update`) |

Key gotchas:
- `POST /supersearch-enrichment/` runs on creation, it's the "fire it" call, not a config save.
- AI enrichment (`.../ai`) supports `use_instantly_account:false` to bill through your own provider key
  instead of Instantly credits, a real cost-control lever.
- `count-leads-from-supersearch` before `enrich-leads-from-supersearch` to budget credits, the enrich call
  spends SuperSearch credits based on `limit` x enrichment types selected, and can spawn a recurring
  `live_list` automation.
- `preview-leads-from-supersearch` returns `number_of_redacted_results` for trial-plan accounts.

---

## 10. Custom Tags and Tag Mappings

| Method + Path | Purpose | Key params | Type |
|---|---|---|---|
| `POST /custom-tags` | Create | `label`* (unique per workspace), `description` | WRITE |
| `GET /custom-tags` | List | `limit`, `starting_after`, `search`, `resource_ids`, `tag_ids` | READ |
| `GET /custom-tags/{id}` | Get one | path `id`* | READ |
| `PATCH /custom-tags/{id}` | Update | `label`, `description` | WRITE |
| `DELETE /custom-tags/{id}` | Delete | path `id`* | WRITE |
| `POST /custom-tags/toggle-resource` | Assign/unassign tags to accounts or campaigns in bulk | `tag_ids`*[], `resource_type`* (1|2), `assign`* (bool), `resource_ids[]`, `excluded_resource_ids[]`, `selected_all`, `filter`, `search` | WRITE |
| `GET /custom-tag-mappings` | List which tags are on which resources | `limit`, `starting_after`, `resource_ids` | READ |

**Gotcha, confirmed inconsistency in Instantly's own spec:** `toggle-resource`'s own description says
`resource_type` 1=campaigns/2=accounts, but the `CustomTagMapping` schema's `x-enumDescriptions` says
1=Account/2=Campaign. Verify empirically against a live workspace before hardcoding either mapping.
Mappings have no direct create/delete, they're only managed via `toggle-resource`.

---

## 11. Custom Prompt Templates

**No live HTTP endpoints exist in the public spec or docs today**, despite a full `CustomPromptTemplate`
schema and `custom_prompt_templates:*` scopes being defined. The schema has: `id`, `workspace_id`,
`created_by`, `name`, `description`, `category` (1-6 enum), `properties[]`, `prompt`, `is_public`,
`model_version`, `template_type` (`custom`/`public`). The one confirmed, documented integration point is
consuming a template by `template_id` inside `POST /supersearch-enrichment/ai` (Section 9).

If a skill's MCP layer exposes `custom_prompt_templates_create/get/list/update/delete` and they work at
runtime, they're calling undocumented/private endpoints not in `api_v2.json`. Don't build a hard
dependency on their exact shape without a runtime contract test.

---

## 12. Lead Labels

| Method + Path | Purpose | Key params | Type |
|---|---|---|---|
| `POST /lead-labels` | Create | `label`*, `interest_status_label`* (`positive`/`negative`/`neutral`), `description`, `use_with_ai` | WRITE |
| `GET /lead-labels` | List | `limit`, `starting_after`, `search`, `interest_status` | READ |
| `GET /lead-labels/{id}` | Get one | path `id`* | READ |
| `PATCH /lead-labels/{id}` | Update | any of the create fields | WRITE |
| `DELETE /lead-labels/{id}` | Delete | path `id`* | WRITE |
| `POST /lead-labels/ai-reply-label` | Test AI reply-label prediction | `reply_text`* | READ (simulation only) |

`ai-reply-label` is capped at **500 requests/30 days/workspace** - this only gates the test/simulate
endpoint, not live automatic reply tagging in production. Easy to burn through in a copy-tuning loop,
worth a client-side counter if a skill batch-tests label wording.

---

## 13. Inbox Placement Testing

### Tests

| Method + Path | Purpose | Type |
|---|---|---|
| `POST /inbox-placement-tests` | Create | WRITE |
| `GET /inbox-placement-tests` | List | READ |
| `GET /inbox-placement-tests/{id}` | Get one | READ |
| `PATCH /inbox-placement-tests/{id}` | Update | WRITE |
| `DELETE /inbox-placement-tests/{id}` | Delete | WRITE |
| `GET /inbox-placement-tests/email-service-provider-options` | List available ESPs (no scope required) | READ |

Create requires: `name`*, `type`* (1=one-time, 2=automated/scheduled), `sending_method`* (1=via Instantly,
2=external), `email_subject`*, `email_body`*, `emails`*[] (seed recipients). For testing mail sent from
outside Instantly, use `sending_method:2` with a `test_code` (must start `ptid_`) that gets correlated
against inbound mail hitting the seed mailboxes.

### Analytics (all READ, all require `test_id`)

| Method + Path | Purpose |
|---|---|
| `GET /inbox-placement-analytics` | Raw records |
| `GET /inbox-placement-analytics/{id}` | One record |
| `POST /inbox-placement-analytics/deliverability-insights` | Summary with period-over-period comparison |
| `POST /inbox-placement-analytics/stats-by-date` | Time series |
| `POST /inbox-placement-analytics/stats-by-test-id` | Aggregate across multiple tests (`test_ids[]`) |

### Reports (READ, require `test_id`)

`GET /inbox-placement-reports` and `.../reports/{id}` return blacklist and SpamAssassin scan results per
domain (`spam_assassin_score`, `blacklist_report{...}`).

**`GET /inbox-placement-tests/email-service-provider-options`** is the decoder ring for the numeric
`recipient_esp`/`sender_esp` codes used throughout this section, fetch and cache it once.

---

## 14. DFY Email Account Orders

The endpoint family with the most real financial risk in the whole API.

| Method + Path | Purpose | Type |
|---|---|---|
| `POST /dfy-email-account-orders` | Place an order | WRITE, charges a card |
| `GET /dfy-email-account-orders` | List orders | READ |
| `GET /dfy-email-account-orders/accounts` | List ordered mailboxes | READ |
| `POST /dfy-email-account-orders/accounts/cancel` | Cancel/delete ordered mailboxes | WRITE, destructive |
| `POST /dfy-email-account-orders/domains/check` | Check domain availability | READ, **30/min or 900/hour** |
| `POST /dfy-email-account-orders/domains/pre-warmed-up-list` | List available pre-warmed domains | READ |
| `POST /dfy-email-account-orders/domains/similar` | Generate similar available domain names | READ |

**Always call `POST /dfy-email-account-orders` with `simulation:true` first.** With simulation on, no
order is placed and no card is charged, only a price quote and `order_is_valid` flag come back. Without
it, `total_price` is charged immediately with no separate confirm step. Gate any real order behind
explicit GTME approval after inspecting a simulated response.

Provider limits: Google/AirMail up to 5 mailboxes/domain, billed per mailbox/month. Microsoft/Outlook is
exactly 50 mailboxes per new domain, billed per domain/month, and does not support `extra_accounts`
orders. Only `.com`/`.org` TLDs, trademarked domains rejected, workspace needs an active Outreach plan and
a payment method on file.

`POST /dfy-email-account-orders/accounts/cancel` is irreversible: cancelling permanently deletes all
Unibox emails and conversations tied to the cancelled accounts.

---

## 15. CRM Actions

| Method + Path | Purpose | Type |
|---|---|---|
| `GET /crm-actions/phone-numbers` | List provisioned phone numbers | READ |
| `DELETE /crm-actions/phone-numbers/{id}` | Delete/release a number | WRITE, destructive |

Backed by Twilio (`twilio_sid`, `subscription_id`, `renewal_date`). Deleting likely stops a recurring
charge but check billing implications before automating bulk deletes.

---

## 16. Blocklist

| Method + Path | Purpose | Key params | Type |
|---|---|---|---|
| `POST /block-lists-entries` | Create one entry | `bl_value`* (email or domain) | WRITE |
| `GET /block-lists-entries` | List | `limit`, `starting_after`, `domains_only`, `search` | READ |
| `DELETE /block-lists-entries` | **Delete every entry matching the filter, no ID needed** | `domains_only`, `search` | WRITE, destructive |
| `POST /block-lists-entries/bulk-create` | Bulk add | `bl_values`*[] | WRITE |
| `POST /block-lists-entries/bulk-delete` | Bulk delete by ID | `ids`*[] | WRITE, destructive |
| `GET /block-lists-entries/download` | Export as CSV (literal CSV text, not JSON) | `domains_only`, `search` | READ |
| `GET /block-lists-entries/{id}` | Get one | path `id`* | READ |
| `PATCH /block-lists-entries/{id}` | Update value | `bl_value` | WRITE |
| `DELETE /block-lists-entries/{id}` | Delete one | path `id`* | WRITE |

**Gotcha:** the bare `DELETE /block-lists-entries` (no ID) wipes the whole blocklist, scoped only by
`domains_only`/`search`. An extremely easy accidental-mass-deletion call to guard against if a skill's
tool wrapper ever calls `blocklist_delete` with no explicit ID.

---

## 17. Known Gaps and Undocumented Areas

- **Email templates** (Section 5) and **Custom Prompt Templates** (Section 11) have no documented HTTP
  paths despite existing as usable MCP tools, they are calling undocumented/private endpoints.
- **Audit log `activity_type`** (Section 8) has no published number-to-label mapping, build a lookup table
  from observed live values if this matters.
- **Webhooks have no signature verification** (Section 7), only a caller-defined static header. Do not
  assume HMAC-style verification exists.
- **`custom-tag-mappings`'s `resource_type` numbering contradicts `toggle-resource`'s own description**
  (Section 10), verify which is correct empirically before hardcoding either.
- No global default `limit` is documented for paginated list endpoints (only min 1 / max 100 bounds),
  always pass `limit` explicitly.

This reference reflects the OpenAPI spec and developer docs as fetched on 2026-07-08. Instantly does not
publish a spec changelog, re-verify against a live workspace before depending on an exact field name in a
new integration, particularly in the sections flagged above as undocumented.
