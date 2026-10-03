# Act 10 — Connect Fabric to Foundry (the Fabric tool)

Part 2, Act 10 of the ContosoMart tour. Attach the published Fabric data agent (Act 8) to your
Foundry agent (Act 9) as the **Microsoft Fabric tool**, so it answers grounded in real OneLake data
via identity passthrough.

## Open it
Open [`index.html`](index.html) in any modern browser. No server, build step or network needed.
Code snippets have Python / C# / TypeScript / REST tabs.

## What you'll do
- Understand the grounding flow and On-Behalf-Of (OBO) identity passthrough.
- Line up permissions on both the Fabric and Foundry sides.
- Create a **Microsoft Fabric** project connection from the data agent's `workspace_id` + `artifact_id`.
- Attach the `fabric_dataagent_preview` tool in the portal or in code; force it with `tool_choice="required"`.
- Ask the ContosoMart questions again — grounded this time — and verify the source.
- Troubleshoot common errors, and know when to use the Fabric IQ tool instead.

## Prerequisites
- Act 8 Fabric data agent **published** (paid F2+/P1+ capacity) and Act 9 Foundry agent created.
- **Foundry User** RBAC; each user has READ on the data agent and its sources.
- Data agent + Foundry project in the **same tenant**; data agent + sources in the **same region**.
- **User identity** auth (`az login`) — service principal is not supported.

## Data
Reuses the Act 8 data agent (ContosoMart gold / warehouse / semantic model / KQL). No new files —
see [`data/README.md`](data/README.md).

## Sources
Grounded in Microsoft Learn — see [`spec.md`](spec.md). Key page:
[Use the Fabric data agent with Foundry agents](https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/tools/fabric).
