# Your Finance Job MCP server

**A job tracker MCP server and job board MCP server for finance careers.** One URL turns a
finance, trading and quant job board, plus your own application pipeline, into 24 tools that
Claude, ChatGPT, Claude Code, Cursor or VS Code can use.

Hosted and free. No API key, no Docker, no `npx`, nothing to self-host. You paste one URL into
your MCP client, sign in once, and your assistant can search open roles, star them, move them
through your application stages, keep notes and set reminders.

```
https://mcp.yourfinancejob.com/mcp
```

Full setup guide, per client: **<https://yourfinancejob.com/mcp>**

---

## What it is

Most job search MCP servers do one of two things: they wrap a search API, or they keep a local
database you have to host. This one is a career MCP server that does both halves, and stays in
one field:

- **A board.** Around 7,400 open roles at 451 firms in finance, trading, quant, technology and
  consulting, rebuilt daily. Levels run from summer internships and off-cycle internships through
  graduate programmes to entry level. Every role links to the firm's own posting, which is where
  you apply. Nothing here is a copy of a job page, and nothing is auto-applied on your behalf.
- **A tracker.** Stars, application stages, lists, notes, reminders, watches and email settings
  live against your account. Your assistant and the website read and write the same records, so
  closing the chat does not lose anything.

| | |
|---|---|
| Type | Remote MCP server, hosted |
| Transport | `streamable-http` |
| Authentication | OAuth 2.1, dynamic client registration, PKCE |
| Tools | 24 |
| Prompts | 6 |
| Resources | 3 |
| Price | Free, no paid tier |
| API key | None issued or needed |
| Rate limit | 60 calls per minute, per member |
| Token lifetime | 30 days |

## Install

You need a free [Your Finance Job](https://yourfinancejob.com/join) account with a verified
email. There is no key to generate: the server registers your client automatically and sends you
to a sign-in page the first time it is used.

### Claude (web, desktop, mobile)

Settings → **Connectors** → **Add custom connector**. Name it `Jobs`, paste the server URL, leave
the advanced fields empty, click **Add**, then **Connect** and sign in. Custom connectors work on
every Claude plan; the Free plan allows one.

### Claude Code

```bash
claude mcp add --transport http --scope user jobs https://mcp.yourfinancejob.com/mcp
```

Then `/mcp` → `jobs` → **Authenticate**. The six briefs become slash commands
(`/jobs:weekly_digest`, `/jobs:firm_brief Optiver`, and so on).

### Cursor

`~/.cursor/mcp.json`

```json
{
  "mcpServers": {
    "jobs": {
      "type": "http",
      "url": "https://mcp.yourfinancejob.com/mcp"
    }
  }
}
```

### VS Code (Copilot agent mode)

`.vscode/mcp.json`

```json
{
  "servers": {
    "jobs": {
      "type": "http",
      "url": "https://mcp.yourfinancejob.com/mcp"
    }
  }
}
```

### ChatGPT

Turn on **Developer mode** (Settings → Security and login), then Settings → **Apps & Connectors**
→ **Create**. Paste the server URL, set Authentication to **OAuth**, create, connect, sign in.
Requires Plus, Pro, Business, Enterprise or Edu.

### Windsurf, Cline, and other MCP clients

Any client that speaks MCP over Streamable HTTP with OAuth 2.1 works. Most read the same shape as
the Cursor example above.

## Tools

### The board (public, no sign-in)

| Tool | What it does |
|---|---|
| `search_jobs` | Open roles by words, firm, city, country, role type, level and date. Filters combine. |
| `latest_jobs` | What appeared most recently. |
| `get_job` | One role in full, with the link to the firm's own posting. |
| `list_companies` | Every firm covered, with its open count. |
| `list_events` | Firm-hosted insight days, spring weeks and career events. |

### Your pipeline

| Tool | What it does |
|---|---|
| `my_roles` | What you starred, each application's stage, and your lists. |
| `save_role` | Star a role. |
| `set_stage` | `Not Applied`, `Applying`, `Applied`, `Interviewing`, `Final Round`, `Offer`, `Rejected`. |
| `add_note` | A note on a role. |
| `manage_list` | Your own buckets of roles: create, add, remove, rename, delete. |
| `my_events` | The career events you saved. |

### Reminders and watches

| Tool | What it does |
|---|---|
| `set_reminder` | A date, optionally a time, on a role or as free text. |
| `list_reminders` / `cancel_reminder` | See and drop reminders. |
| `watch` | New roles at a firm, matching words, in a city, category or level. |
| `list_watches` / `unwatch` | See and stop watches. |

### Noise and email

| Tool | What it does |
|---|---|
| `hide_company` / `hide_role` | Take a firm, one of its categories, or one role off your board. |
| `mute_role` | Email about one tracked role off or on. |
| `report_role` | Flag a dead link or a closed role. |
| `notification_settings` | On or off, daily or weekly, the hour, the timezone. |
| `career_alerts` | New roles matching your category, level and region filters. |

### Briefs

`get_brief(kind, ...)` returns one of six ready-made answers, each pulling its own data server
side so a digest costs one call: `weekly_digest`, `firm_brief`, `application_plan`,
`deadline_calendar`, `compare_roles`, `prep_checklist`. The same six are published as MCP prompts
for clients that surface them.

### Resources

`sophron://me/pipeline` · `sophron://tracker/stats` · `sophron://firms` (and
`sophron://firms/<name>`)

## Things to ask it

- "What quant internships opened in Amsterdam this week?"
- "Star the Jane Street graduate roles and set them to Applying."
- "What is open at Optiver, and where do I stand with them?"
- "Remind me about the Morgan Stanley deadline on 14 October."
- "Watch IMC for anything new at entry level."
- "Which of my applications have gone quiet?"

## Privacy

The server reads the public board, and your own tracker records once you sign in. It cannot read
anything belonging to another member. Nothing about you is sent to a firm: you apply on the firm's
own page, in your own name. Revoke access at any time from your client's connector settings.

## Source

This is a hosted server, so there is nothing here to run or install. This repository holds the
documentation, the client configuration examples and `server.json`. The Worker behind the
endpoint is not published.

## Links

- Setup guide, per client: <https://yourfinancejob.com/mcp>
- What it looks like in a chat: <https://yourfinancejob.com/ai>
- The board itself: <https://yourfinancejob.com>
- Firms covered: <https://yourfinancejob.com/companies>

A [Sophron](https://sophron.eu) product. A firm missing from the board? Write to
<vincent@sophron.eu>. Being listed is free and always will be.
