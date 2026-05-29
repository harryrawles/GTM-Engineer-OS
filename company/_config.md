# Client Config — {{CLIENT_NAME}}

Central source of truth for variables used across this OS. Other files reference this file rather than hardcoding values.

**Updated by:** `gtm-skills/client-onboarder.md` during setup, then manually maintained.

---

## Identity

| Key | Value |
|-----|-------|
| `client_name` | {{CLIENT_NAME}} |
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
| `mcp_connected` | {{true/false}} |

## OS

| Key | Value |
|-----|-------|
| `template_version` | 1.0.0 |
| `os_setup_date` | {{YYYY-MM-DD}} |
| `last_review_date` | {{YYYY-MM-DD}} |

---

## How Other Files Reference This

When a file needs CLIENT_NAME, INDUSTRY, etc., it points here rather than duplicating. Example pattern:

```
**Client:** see company/_config.md → client_name
**Industry:** see company/_config.md → industry
```

This way: rename a client once (here), and the rest of the OS stays consistent.

## Setup Status

- [ ] All placeholders resolved
- [ ] Instantly MCP connected and verified
- [ ] Reviewed by Harry before first campaign launch