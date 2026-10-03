# Act 11 — Ground it in knowledge with Foundry IQ

Part 2, Act 11 of the ContosoMart tour. Add a **Foundry IQ** knowledge base (agentic retrieval over
Azure AI Search) so the concierge answers document questions — policies, contracts, runbooks — with
citations, alongside the Fabric numbers from Act 10.

## Open it
Open [`index.html`](index.html) in any modern browser. No server, build step or network needed.

## What you'll do
- Learn the Foundry IQ building blocks: knowledge source, knowledge base, agentic retrieval.
- Upload the three sample ContosoMart docs to Blob/ADLS Gen2.
- Create a blob knowledge source and a knowledge base in Azure AI Search.
- Connect the knowledge base to `contosomart-concierge` and route questions.
- Ask mixed prompts — document + numbers — and get cited, grounded answers.
- Decide between Foundry IQ, file search and memory.

## Prerequisites
- The Act 10 agent (Foundry concierge grounded in the Fabric tool).
- An **Azure subscription**, an **Azure AI Search** resource, and an Azure Storage account
  (knowledge bases are built on Azure AI Search).
- Foundry IQ is **partial GA** (API-level GA; portal access remains preview).

## Data
Three tiny synthetic documents in [`data/`](data/) — no real PII:
- [`data/returns-policy.md`](data/returns-policy.md)
- [`data/supplier-contract.md`](data/supplier-contract.md)
- [`data/ops-runbook.md`](data/ops-runbook.md)

## Sources
Grounded in Microsoft Learn — see [`spec.md`](spec.md). Key pages:
[What is Foundry IQ](https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/what-is-foundry-iq) ·
[Connect IQ to agents](https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/foundry-iq-connect)
