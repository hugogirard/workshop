# Data — Secure the agents (Act 13)

There is **nothing to upload** for this workshop. Microsoft Defender for AI agents works on the
server side over your tenant's agents (discovered through Microsoft Agent 365), so the "data" here
is the set of **Advanced Hunting queries** you run against your own Defender tables.

## Files

| File | Use |
| --- | --- |
| `agent-hunting-queries.kql` | The hands-on KQL for **Module 5**. Paste into Defender → Investigation & response → Hunting → Advanced hunting and run. |

## How to use

1. Sign in to the [Microsoft Defender portal](https://security.microsoft.com/).
2. Go to **Investigation & response → Hunting → Advanced hunting**.
3. Open `agent-hunting-queries.kql`, copy a query, paste it into the editor, and select **Run query**.

Each query is read-only. They target the `AgentsInfo` inventory table and correlate it with the
alert / activity tables. You need the Microsoft 365 connector enabled (Module 1) for the alert and
`CloudAppEvents` correlations to return data.

> `AIAgentsInfo` is being replaced by `AgentsInfo`. Use `AgentsInfo`; the old table name is
> accessible only until 2026-07-01.
</content>
