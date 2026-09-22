#!/usr/bin/env bash
# Add the Your Finance Job MCP server to Claude Code, for every project.
# Then run Claude Code, type /mcp, pick "jobs" and choose Authenticate.
claude mcp add --transport http --scope user jobs https://mcp.yourfinancejob.com/mcp
