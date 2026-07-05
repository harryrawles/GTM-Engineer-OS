# Client Config — {{CLIENT_NAME}}

Central source of truth for variables used across this OS. Other files reference this file rather than hardcoding values.

**Updated by:** `gtm-skills/client-onboarder.md` during setup, then manually maintained.

---

## Identity

| Key | Value |
|-----|-------|
| `slug` | {{SLUG}} — lowercase-kebab folder name under `clients/` (e.g. `acme-corp`) |
| `client_name` | {{CLIENT_NAME}} |
| `tier` | {{TIER}} — e.g. DFY / DWY / Custom, or A/B/C priority |
| `industry` | {{INDUSTRY}} |
| `website` | {{WEBSITE}} |
| `geography` | {{GEOGRAPHY}} |
| `primary_contact_name` | {{NAME}} |
| `primary_contact_email` | {{EMAIL}} |
| `service_type` | {{DFY / DWY / Custom}} |
| `start_date` | {{YYYY-MM-DD}} |
| `reporting_day` | {{Monday / Friday / etc.}} |

## Instantly

| Key | Value |
|-----|-------|
| `instantly_workspace_url` | {{URL}} |
| `instantly_workspace_id` | {{ID}} |
| `instantly_mcp_server` | {{MCP_SERVER_NAME}} — the exact MCP server this client's workspace is mounted as (e.g. the tool prefix `mcp__<server>__…`). Skills MUST target this server when multiple Instantly workspaces are connected. |
| `mcp_connected` | {{true/false}} |

## OS

| Key | Value |
|-----|-------|
| `template_version` | {{TEMPLATE_VERSION}} — copy from repo root `VERSION` at spin-up time |
| `os_setup_date` | {{YYYY-MM-DD}} |
| `last_review_date` | {{YYYY-MM-DD}} |

---

## How Other Files Reference This

When a file needs CLIENT_NAME, INDUSTRY, etc., it points here rather than duplicating. Example pattern:

```
**Client:** see clients/{slug}/_config.md → client_name
**Industry:** see clients/{slug}/_config.md → industry
```

This way: rename a client once (here), and the rest of the OS stays consistent.

## Setup Status

- [ ] All placeholders resolved
- [ ] Instantly MCP connected and verified
- [ ] Reviewed by Harry before first campaign launch