# Act 8 — Fabric data agent: ask ContosoMart in plain English

Part 2, Act 8 of the ContosoMart tour. Build and publish a **Fabric data agent** over the
governed OneLake estate from Part 1, so anyone can ask questions in plain English — and so an
Azure AI Foundry agent can consume it in Act 10.

## Open it
Open [`index.html`](index.html) in any modern browser. No server, build step or network needed.
Progress, theme and checkboxes persist in `localStorage`.

## What you'll do
- Understand how a data agent parses → routes → generates → validates → executes → answers.
- Create a data agent, add up to five sources (gold lakehouse, warehouse star, semantic model, KQL), pick tables.
- Add routing instructions and example question/query pairs; understand the four intent layers.
- Ask the "Monday numbers war" questions and see governed, read-only answers.
- Confirm Purview governance, then publish and share — and note the IDs Act 10 needs.

## Prerequisites (important)
- A **paid F2 or higher** Fabric capacity (or Power BI Premium **P1+** with Fabric enabled).
  The Fabric data agent is **not** available on the free 60-day trial.
- The Part 1 estate: `ContosoMart-Analytics` workspace with gold tables, warehouse, semantic
  model and KQL eventhouse (do Acts 1–7 first, or bring your own equivalent data).
- Read access to each source; the AI cross-geo tenant settings enabled where required.
- Keep the agent and its sources on capacities in the **same region**.

## Data
This lab reuses the ContosoMart data you already landed in Part 1 — no new files. See
[`data/README.md`](data/README.md) for the tables the agent uses and the sample questions.

## Sources
All steps are grounded in Microsoft Learn — see [`spec.md`](spec.md) for the full table. Key pages:
[Fabric data agent concept](https://learn.microsoft.com/en-us/fabric/data-science/concept-data-agent) ·
[Create a data agent](https://learn.microsoft.com/en-us/fabric/data-science/how-to-create-data-agent) ·
[Use it with Foundry](https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/tools/fabric)
