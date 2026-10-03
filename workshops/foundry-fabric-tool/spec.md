# Workshop spec — Connect Fabric to Foundry (ContosoMart, Act 10)

Part 2, Act 10. Ground the Foundry prompt agent (Act 9) in real ContosoMart data by attaching the
published Fabric data agent (Act 8) as the **Microsoft Fabric tool**, with identity passthrough.

- **Audience:** AI/data engineers, SEs. Internal + customer-facing.
- **Depth:** hands-on. Requires the Act 8 published data agent, the Act 9 Foundry agent, an Azure
  subscription, and **user identity** auth (service principal is not supported for the Fabric tool).
- **Grounding rule:** no product claim without a Sources row. The Fabric tool is in **preview**.

## Sources (canonical URLs)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| A-FABRIC-TOOL | Use the Fabric data agent with Foundry agents | https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/tools/fabric | 2026-09-14 |
| A-AGENTS | What is Foundry Agent Service | https://learn.microsoft.com/en-us/azure/foundry/agents/overview | 2026-09-14 |
| A-AGENT-ID | Agent identity | https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/agent-identity | 2026-09-14 |
| A-RBAC | Azure RBAC in Foundry | https://learn.microsoft.com/en-us/azure/foundry/concepts/rbac-foundry | 2026-09-14 |
| A-DATAAGENT-SHARE | Underlying data source permissions | https://learn.microsoft.com/en-us/fabric/data-science/data-agent-sharing | 2026-09-14 |
| A-FABRIC-IQ | Fabric IQ tool (alternative) | https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/tools/fabric-iq | 2026-09-14 |

## Module map

| # | Module | Goal | Grounded in |
| - | --- | --- | --- |
| 0 | The tool & identity passthrough | How the Fabric tool grounds an agent; On-Behalf-Of auth | A-FABRIC-TOOL, A-AGENT-ID |
| 1 | Prerequisites & permissions | READ on data agent + sources, same tenant/region, user identity | A-FABRIC-TOOL, A-DATAAGENT-SHARE, A-RBAC |
| 2 | Create the Fabric connection | workspace_id + artifact_id → project connection ID | A-FABRIC-TOOL |
| 3 | Attach the tool to the agent | Portal + Python/C#/TS/REST; tool_choice=required | A-FABRIC-TOOL |
| 4 | Ask & verify | ContosoMart questions grounded in OneLake; expected output | A-FABRIC-TOOL |
| 5 | Troubleshoot & alternatives | Troubleshooting table; Fabric IQ tool | A-FABRIC-TOOL, A-FABRIC-IQ |

## Story framing
- **Recap:** Act 9's concierge reasons and uses tools, but has no access to ContosoMart's numbers.
- **Tension:** An assistant that guesses revenue is worse than none.
- **Mission:** Wire the Fabric data agent in as a governed tool via identity passthrough.
- **Outcome:** The Foundry agent answers grounded in the same trusted OneLake data — ready for Act 11's knowledge.

## Key grounded facts (do not drift)
- Flow: build & publish the Fabric data agent → create a **Microsoft Fabric** project connection →
  attach the Fabric tool → the agent decides to call it → it runs queries **as the end user** (OBO).
- Copy `workspace_id` and `artifact_id` from the data-agent URL: `.../groups/<workspace_id>/aiskills/<artifact_id>...`.
- Tool type is `fabric_dataagent_preview`; force it with `tool_choice="required"`.
- **User identity** auth only — service principal is not supported.
- Keep the data agent + sources in the **same region**; data agent + Foundry project in the **same tenant**.
- End users need READ on the data agent and the minimum permission on each underlying source (RLS/CLS still apply).
- The orchestration model is separate from the data agent's NL2SQL model.
- Alternative: the **Fabric IQ** tool reasons over Fabric data agents, ontologies and Power BI semantic models.

## Refresh workflow
Re-fetch the Sources pages, diff, update the affected module + row, bump "Last fetched".
