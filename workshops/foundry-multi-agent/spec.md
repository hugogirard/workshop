# Workshop spec — Agents that talk to each other (ContosoMart, Act 12)

Part 2, Act 12 — the capstone. Split the overloaded concierge into specialist agents that
collaborate: a numbers agent (Fabric tool), a knowledge agent (Foundry IQ), and a router that
delegates. Build it with Foundry workflows, and learn the code-first paths (Agent Framework, A2A).

- **Audience:** AI/data engineers, SEs. Internal + customer-facing.
- **Depth:** hands-on. Requires the Act 10 and Act 11 agents in one Foundry project.
- **Grounding rule:** no product claim without a Sources row. Workflows are **preview** and the
  in-portal designer retires **Dec 1, 2026** — teach the migration paths.

## Sources (canonical URLs)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| A-WORKFLOW | Build a workflow in Foundry | https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/workflow | 2026-09-14 |
| A-AGENTS | What is Foundry Agent Service | https://learn.microsoft.com/en-us/azure/foundry/agents/overview | 2026-09-14 |
| A-A2A | Enable an incoming A2A endpoint | https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/enable-agent-to-agent-endpoint | 2026-09-14 |
| A-AF | Microsoft Agent Framework workflows | https://learn.microsoft.com/en-us/agent-framework/workflows/orchestrations/ | 2026-09-14 |
| A-OBS | Trace agents (observability) | https://learn.microsoft.com/en-us/azure/foundry/observability/concepts/trace-agent-concept | 2026-09-14 |

## Module map

| # | Module | Goal | Grounded in |
| - | --- | --- | --- |
| 0 | Why multi-agent | Specialize + route; avoid one overloaded agent | A-WORKFLOW, A-AGENTS |
| 1 | Design the concierge team | Router + Fabric-numbers agent + IQ-knowledge agent | A-WORKFLOW |
| 2 | Build a workflow | Portal patterns: sequential, group chat, human-in-loop; nodes | A-WORKFLOW |
| 3 | Route &amp; test | Assign agents to nodes; run; verify routing/variables | A-WORKFLOW |
| 4 | Code-first: A2A &amp; Agent Framework | Workflow retirement; migrate to Agent Framework / A2A | A-WORKFLOW, A-A2A, A-AF |
| 5 | Trace, evaluate &amp; publish | Observe the multi-agent run; publish specialists + router | A-AGENTS, A-OBS |

## Story framing
- **Recap:** One concierge now answers numbers (Act 10) and documents (Act 11) — but it's getting muddled.
- **Tension:** A single overloaded agent is hard to trust, debug and extend.
- **Mission:** Give each capability its own focused agent, and route between them.
- **Outcome:** A clean multi-agent ContosoMart concierge — the CEO's "just ask, and act" assistant. Part 2 complete.

## Key grounded facts (do not drift)
- Workflows orchestrate multiple agents + business logic visually; patterns: **sequential**, **group chat**, **human-in-the-loop**.
- Workflow nodes: **Agent**, **Logic** (if/else, go to, for each), **Data transformation**, **Basic chat**; Power Fx for expressions.
- Hosted agents aren't supported in the workflow designer; to orchestrate from hosted-agent code, use **Agent Framework** workflows.
- **Retirement:** Foundry retires in-portal workflow execution/designer on **Dec 1, 2026**; YAML workflow definitions still run when deployed as a **hosted agent**.
- Migration paths: **Agent Framework** (recommended, reuse exported YAML), **Azure Logic Apps** (visual), **A2A** (lightweight one-agent-calls-another).
- Connected agents (classic) is deprecated (retires Mar 31, 2027) → use the new workflows / A2A.

## Story-only data
No new upload files. The specialist agents reuse the Act 10 Fabric tool connection and the Act 11
knowledge base.

## Refresh workflow
Re-fetch the Sources pages, diff, update the affected module + row, bump "Last fetched".
