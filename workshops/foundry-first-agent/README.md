# Act 9 — Your first Foundry agent

Part 2, Act 9 of the ContosoMart tour. Create an Azure AI Foundry project, deploy a model, and
build + test a **prompt agent** in the portal — the managed runtime you'll ground in ContosoMart's
Fabric data in Act 10.

## Open it
Open [`index.html`](index.html) in any modern browser. No server, build step or network needed.

## What you'll do
- Understand Foundry: prompt vs hosted agents vs the Responses API.
- Create a Foundry resource + project and get the **Foundry User** RBAC role.
- Deploy an orchestration model from the catalog.
- Build the `contosomart-concierge` prompt agent with instructions and a built-in tool.
- Test it in the playground, inspect tracing and versions.
- See the portal → code path (Python/C#) and how to publish to Teams / M365.

## Prerequisites
- An **Azure subscription** and permission to create a Foundry resource.
- The **Foundry User** RBAC role on the project (same tenant you'll use for Fabric in Act 10).
- Optional for the code step: `az login`, and the `azure-ai-projects` SDK (Python) or
  `Azure.AI.Projects` (C#).

## Data
No data files — this lab provisions Foundry. It reuses the published Fabric data agent from Act 8
only in the *next* lab (Act 10).

## Sources
Grounded in Microsoft Learn — see [`spec.md`](spec.md). Key pages:
[What is Foundry](https://learn.microsoft.com/en-us/azure/foundry/what-is-foundry) ·
[Agent Service](https://learn.microsoft.com/en-us/azure/foundry/agents/overview) ·
[Create a prompt agent](https://learn.microsoft.com/en-us/azure/foundry/agents/quickstarts/prompt-agent)
