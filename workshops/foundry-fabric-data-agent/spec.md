# Workshop spec — Fabric data agent (ContosoMart, Act 8)

Part 2, Act 8 of the ContosoMart tour. Turn the governed OneLake estate from Part 1 into a
plain-English question-and-answer experience with a **Fabric data agent**, then publish it so
downstream agents (Act 10) can consume it.

- **Audience:** data engineers, BI analysts and SEs who finished Part 1 (or have a Fabric estate). Internal enablement + customer-facing.
- **Depth:** hands-on. Requires a **paid F2+ (or P1+) capacity** — the Fabric data agent is **not** available on the free trial.
- **Estate reused:** `ContosoMart-Analytics` workspace, `lh_contosomart` lakehouse (gold), the warehouse star, the Power BI semantic model, and the KQL eventhouse from Part 1.
- **Grounding rule:** no product claim without a Sources row. On a docs delta, update the affected module + the row and bump "Last fetched".

## Sources (canonical URLs)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| A-DATAAGENT | Fabric data agent (concept) | https://learn.microsoft.com/en-us/fabric/data-science/concept-data-agent | 2026-09-14 |
| A-DATAAGENT-CREATE | Create a Fabric data agent | https://learn.microsoft.com/en-us/fabric/data-science/how-to-create-data-agent | 2026-09-14 |
| A-DATAAGENT-SHARE | Share and manage a Fabric data agent | https://learn.microsoft.com/en-us/fabric/data-science/data-agent-sharing | 2026-09-14 |
| A-DATAAGENT-TENANT | Fabric data agent tenant settings | https://learn.microsoft.com/en-us/fabric/data-science/data-agent-tenant-settings | 2026-09-14 |
| A-FABRIC-TOOL | Use the Fabric data agent with Foundry agents | https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/tools/fabric | 2026-09-14 |
| F-PURVIEW | Govern Fabric with Microsoft Purview | https://learn.microsoft.com/en-us/fabric/governance/microsoft-purview-fabric | 2026-09-14 |

## Module map

| # | Module | Goal | Grounded in |
| - | --- | --- | --- |
| 0 | Why a data agent | Concept: conversational analytics over governed OneLake; agent vs copilot | A-DATAAGENT |
| 1 | Prerequisites & tenant settings | Paid capacity, data sources, cross-geo AI settings, RBAC | A-DATAAGENT, A-DATAAGENT-TENANT |
| 2 | Create the agent & add sources | New data agent, add ≤5 sources (gold + warehouse + semantic model + KQL), pick tables | A-DATAAGENT-CREATE |
| 3 | Add context: instructions & examples | Routing instructions, example Q/query pairs, intent-layer precedence | A-DATAAGENT-CREATE, A-DATAAGENT |
| 4 | Test in plain English | Ask ContosoMart questions; read-only NL2SQL/NL2DAX/NL2KQL; row/column caps | A-DATAAGENT |
| 5 | Govern, publish & share | Purview DLP/labels, publish, share with least privilege, ALM/Git | A-DATAAGENT, A-DATAAGENT-SHARE, F-PURVIEW |

## Story framing
- **Recap:** Part 1 delivered one trusted estate — but only SQL/DAX/KQL authors can query it.
- **Tension:** Every ad-hoc question queues behind a few people.
- **Mission:** Ship a governed, read-only, plain-English Q&A agent over the same data.
- **Outcome:** Anyone asks; the agent is published and ready for Foundry to consume in Act 10.

## Key grounded facts (do not drift)
- Data agent is **GA**; up to **5 data sources** (lakehouse, warehouse, Power BI semantic model, KQL DB, mirrored DB, ontology, Microsoft Graph, in any combination).
- **Read-only**: generates only SQL/DAX/KQL *read* queries; never create/update/delete.
- Lakehouse sources answer from **selected tables**, not standalone files.
- Responses are capped (currently **25 rows × 25 columns**); English only; can't change the LLM.
- **Intent precedence** (highest→lowest): Organizational → Role-based → Developer → User.
- Respects **Purview** DLP, access-restriction policies and sensitivity labels on sources.
- Can be consumed by external orchestrators — **Copilot Studio, Azure AI Foundry, Teams** (this sets up Act 10).

## Refresh workflow
Re-fetch the Sources pages, diff against the module map, update the affected module in `index.html`
and the row, bump "Last fetched".
