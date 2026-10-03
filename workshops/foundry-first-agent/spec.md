# Workshop spec — Your first Foundry agent (ContosoMart, Act 9)

Part 2, Act 9. Stand up an Azure AI Foundry project, deploy a model, and build + test a **prompt
agent** in the portal — the managed runtime you'll ground in ContosoMart's Fabric data in Act 10.

- **Audience:** SEs, data/AI engineers moving from Fabric to agents. Internal + customer-facing.
- **Depth:** hands-on. Requires an **Azure subscription** and the **Foundry User** RBAC role.
- **Grounding rule:** no product claim without a Sources row.

## Sources (canonical URLs)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| A-FOUNDRY | What is Microsoft Foundry | https://learn.microsoft.com/en-us/azure/foundry/what-is-foundry | 2026-09-14 |
| A-AGENTS | What is Foundry Agent Service | https://learn.microsoft.com/en-us/azure/foundry/agents/overview | 2026-09-14 |
| A-PROMPT-QS | Quickstart: create a prompt agent | https://learn.microsoft.com/en-us/azure/foundry/agents/quickstarts/prompt-agent | 2026-09-14 |
| A-MODELS | Foundry Models overview | https://learn.microsoft.com/en-us/azure/foundry/concepts/foundry-models-overview | 2026-09-14 |
| A-TOOLBOX | What is Toolbox in Foundry | https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/toolbox-overview | 2026-09-14 |
| A-RBAC | Azure RBAC in Foundry | https://learn.microsoft.com/en-us/azure/foundry/concepts/rbac-foundry | 2026-09-14 |
| A-OBS | Trace agents (observability) | https://learn.microsoft.com/en-us/azure/foundry/observability/concepts/trace-agent-concept | 2026-09-14 |

## Module map

| # | Module | Goal | Grounded in |
| - | --- | --- | --- |
| 0 | What Foundry is | Unified agents+models+tools; prompt vs hosted vs Responses API | A-FOUNDRY, A-AGENTS |
| 1 | Project & access | Create a Foundry resource + project; Foundry User RBAC | A-FOUNDRY, A-RBAC |
| 2 | Deploy a model | Browse the catalog, pick and deploy an orchestration model | A-MODELS |
| 3 | Build a prompt agent | Instructions + model + a built-in tool, in the portal | A-PROMPT-QS, A-AGENTS |
| 4 | Test & trace | Playground; tracing/observability; versioning | A-AGENTS, A-OBS |
| 5 | Portal → code / publish | SDK create_version + Responses API; publish to Teams/M365 | A-AGENTS, A-PROMPT-QS |

## Story framing
- **Recap:** Act 8 published a Fabric data agent — great at governed Q&A, but it can't plan or act.
- **Tension:** ContosoMart wants an assistant that reasons, uses tools, and lives where people work.
- **Mission:** Build the first Foundry agent and learn the agent runtime.
- **Outcome:** A working prompt agent, ready to be grounded in Fabric data (Act 10).

## Key grounded facts (do not drift)
- Foundry = one management plane for **agents, models, tools** with RBAC, networking, policies, tracing, evals.
- **Prompt agent** = declarative (instructions + model + tools), Foundry-managed, no code/containers.
  **Hosted agent** = your code/framework as a container. **Responses API** = ephemeral agent in your own code.
- Catalog has 10,000+ models; swap models without changing agent code.
- Tools via a **Toolbox** (one managed MCP endpoint): web search, file search, code interpreter, MCP, custom functions, plus Fabric/Foundry/Work IQ.
- Lifecycle: create → test (playground) → trace → evaluate → optimize → publish → monitor.

## Refresh workflow
Re-fetch the Sources pages, diff, update the affected module + row, bump "Last fetched".
