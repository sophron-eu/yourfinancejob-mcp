# Your Finance Job MCP server

[![mcptry](https://mcptry.com/badge/com.yourfinancejob/job-tracker)](https://mcptry.com/servers/com.yourfinancejob/job-tracker)

**A job tracker MCP server and job board MCP server for finance careers.** One URL turns a
finance, trading and quant job board, plus your own application pipeline, into 47 tools that
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

- **A board.** More than 14,000 open roles at over 1,000 firms in finance, trading, quant,
  technology and consulting, rebuilt every morning, with 41 ready-made lists, 49 city pages and
  19 kinds of firm to search by. Levels run from summer internships and off-cycle
  internships through graduate programmes to entry level. Every role links to the firm's own
  posting, which is where you apply. Nothing here is a copy of a job page, and nothing is
  auto-applied on your behalf.
- **A tracker.** Stars, application stages, lists, notes, reminders, watches, followed firms,
  saved lists and cities, saved filters, your CVs and cover letters, your networking contacts
  and email settings live against your account. Your
  assistant and the website read and write the same records, so closing the chat does not lose
  anything.

| | |
|---|---|
| Type | Remote MCP server, hosted |
| Transport | `streamable-http` |
| Authentication | OAuth 2.1, dynamic client registration, PKCE |
| Tools | 47 |
| Prompts | 10 |
| Resources | 5 |
| Price | Free, no paid tier |
| API key | None issued or needed |
| Rate limit | 60 calls per minute, per member |
| Token lifetime | 30 days |

## Install

Want to try it first? The public board needs no account and no sign-in:
`https://mcp.yourfinancejob.com/board` gives the eight board tools (search, newest roles, role
details, who is hiring, firms, events, lists, cities), 30 calls a minute. Everything below that
touches your own records uses the main URL and a free account.

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

Then `/mcp` → `jobs` → **Authenticate**. The seven briefs become slash commands
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
| `search_jobs` | Open roles by words, firm, city, country, kind of firm, ready-made list, role type, level, workplace (remote, hybrid, on site) and date, sorted as you like. Filters combine. |
| `latest_jobs` | What appeared most recently, with the same scopes. |
| `get_job` | One role in full: the description, and the closing date, pay range, employment and workplace type, offices and departments where the firm declared them. |
| `list_companies` | Firms with their kinds and open counts, by kind, country or city; `include_quiet` adds every watched firm with nothing open today. |
| `list_events` | Insight days, spring weeks, academies, hackathons and career events worldwide, with the professional conferences that take students on request. |
| `market_stats` | Who is hiring: new roles in the last days versus the window before, the firms posting most, rising firms, and the mix by level, role type, country and city. |
| `browse_lists` | The 41 ready-made lists with live counts, and the 19 kinds of firm. |
| `list_cities` | The 49 city pages: open roles, hiring firms, busiest firms, upcoming events. |

### Your pipeline

| Tool | What it does |
|---|---|
| `my_roles` | Everything on your account: stars, stages, lists, notes, reminders, watches, saved lists and cities, followed firms, saved filters, hidden. |
| `my_profile` | Your own background: what was extracted from the CV you uploaded (university, study, skills, languages, ventures) plus the details you wrote yourself (target roles, right to work, strengths, how drafts should sound). Only returned when you allow assistant access under Profile on your account page. Read only, and never the file itself. |
| `update_profile` | Read or edit the "About you" details on your account page (target roles, right to work, strengths, how drafts should sound, links) and the "Sophron® may contact me about opportunities" switch. Editing needs assistant access to be on; that access, and uploading a CV, are only done by you on the site. |
| `best_fits` | A ranked shortlist of open roles that fit you, each with a fit score and the reasons (role type, level, place, followed firm, skills), from your filters, saved roles and, with your permission, your profile. |
| `track_outside_role` | Track a role that is not on the board from its posting link; it then takes stages, notes and reminders like any other and shows in your pipeline. |
| `save_role` | Star a role, or up to fifty at once. |
| `set_stage` | `Not Applied`, `Applying`, `Applied`, `Interviewing`, `Final Round`, `Offer`, `Rejected`; one role or many; `clear` removes the stage. |
| `add_note` | A note on a role. |
| `untrack_role` | Take a role off your overview: star, stage, note, reminders and list memberships in one go. |
| `manage_list` | Your own buckets of roles: create, add, remove, rename, delete. |
| `save_list` | Keep a ready-made list or a city page on your account, the star on `/lists` and `/cities`. |
| `follow_company` | Follow a firm: new roles there ride in your email. |
| `my_events` / `save_event` | The career events you saved, and starring one. |
| `saved_filters` | The filter set the board and the events page open with. |

### CVs, cover letters and your network

| Tool | What it does |
|---|---|
| `my_documents` | The CVs and cover letters you keep under Tools on the site: the list, or one in full, so your assistant can improve it, tailor it to another role or write a letter in the same voice. |
| `save_document` | Save a new one-page CV or cover letter into your Tools, where you edit it and download the PDF. Built only from your profile and what you said; gaps get a `[placeholder]`, never an invented fact. It never overwrites an existing document. |
| `my_network` | Your networking tracker: people you know or want to meet, their stage, last contact dates, replies you owe, coffee chats with notes, and the next follow-up. |
| `update_network` | Add a person or change one: stage, notes, a planned chat, a follow-up date, or log a chat that happened. A follow-up date also lands in your morning email. |

### LinkedIn outreach

Your own outreach lists on top of the same network: named groups of people (say "Traders at
Amsterdam prop shops") with a goal, message templates and a count per stage, from to contact
through request sent, connected and messaged to a coffee chat. Your assistant drafts every
message; you send it yourself from your own LinkedIn.

| Tool | What it does |
|---|---|
| `my_outreach` | Your outreach lists with a count per stage, or one list with its templates and people. |
| `save_outreach_list` | Create a list, change its title, goal or templates (`{first}`, `{name}`, `{firm}`, `{role}`, `{me}`), or delete it; its people stay in your network. |
| `add_to_outreach` | Add up to 50 people at once (name, firm, position, LinkedIn link), or put people already in your network on a list. Nobody is duplicated. |
| `next_outreach` | The next person on a list for a one-by-one run, with the list's templates filled in for them. |
| `mark_outreach` | Record what you sent for one person or fifty: the stage, the message, a dated note, a follow-up date. |
| `sync_linkedin` | Paste your LinkedIn Connections or Sent invitations page and people move forward to request sent or connected, after a preview. |

The `outreach_run` prompt works through a list one person at a time: a card with the profile
link, why them and the message ready to copy; you answer sent, skip or what to change.

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
| `my_usage` | How many calls you made today, and the ceiling. |

### Briefs

`get_brief(kind, ...)` returns one of nine ready-made answers, each pulling its own data server
side so a digest costs one call: `weekly_digest`, `firm_brief`, `city_brief`, `list_brief`,
`application_plan`, `deadline_calendar`, `compare_roles`, `prep_checklist`, `application_draft`.
The same nine are published as MCP prompts for clients that surface them. The plan and the
calendar read your own roles' published closing dates.

`application_draft` joins a posting to your own CV profile and writes a motivation letter, the
usual application answers, and an honest list of what the role asks for that your CV does not
show. It drafts; you edit it and send it yourself. Nothing here submits anything to a firm.

### Resources

`sophron://me/pipeline` · `sophron://tracker/stats` · `sophron://firms` (and
`sophron://firms/<name>`) · `sophron://lists` (and `sophron://lists/<slug>`) · `sophron://cities`
(and `sophron://cities/<slug>`)

## Things to ask it

- "What quant internships opened in Amsterdam this week?"
- "Which hedge funds are hiring in London, and what is open there?"
- "Follow Optiver and IMC, and save the Amsterdam city page."
- "Brief me on Zurich as a place to start."
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
