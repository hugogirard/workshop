# Workshop spec — Ground it in knowledge with Foundry IQ (ContosoMart, Act 11)

Part 2, Act 11. Add a **Foundry IQ** knowledge base (agentic retrieval over Azure AI Search) so the
ContosoMart concierge can answer document questions — policies, contracts, runbooks — with citations,
alongside the Fabric numbers from Act 10.

- **Audience:** AI/data engineers, SEs. Internal + customer-facing.
- **Depth:** hands-on. Requires the Act 10 agent, an Azure subscription, and an Azure AI Search
  resource (knowledge bases are built on Azure AI Search). Foundry IQ is **partial GA** (API-level GA;
  portal access remains preview).
- **Grounding rule:** no product claim without a Sources row.

## Sources (canonical URLs)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| A-IQ | What is Foundry IQ | https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/what-is-foundry-iq | 2026-09-14 |
| A-IQ-CONNECT | Connect a Foundry IQ knowledge base to agents | https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/foundry-iq-connect | 2026-09-14 |
| A-IQ-QS | Quickstart: Foundry IQ knowledge base on a hosted agent | https://learn.microsoft.com/en-us/azure/foundry/agents/quickstarts/quickstart-foundry-iq-hosted-agent | 2026-09-14 |
| A-IQ-FAQ | Foundry IQ FAQ | https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/foundry-iq-faq | 2026-09-14 |
| A-KB | Create a knowledge base (Azure AI Search) | https://learn.microsoft.com/en-us/azure/search/agentic-retrieval-how-to-create-knowledge-base | 2026-09-14 |
| A-KS-BLOB | Create a blob knowledge source | https://learn.microsoft.com/en-us/azure/search/agentic-knowledge-source-how-to-blob | 2026-09-14 |
| A-CONN | Add a connection to your project | https://learn.microsoft.com/en-us/azure/foundry/how-to/connections-add | 2026-09-14 |

## Module map

| # | Module | Goal | Grounded in |
| - | --- | --- | --- |
| 0 | Why Foundry IQ | Agentic retrieval, grounding + citations; IQ vs file search vs memory | A-IQ, A-IQ-FAQ |
| 1 | Prepare the docs | Land the 3 ContosoMart docs in Blob/ADLS Gen2 | A-KS-BLOB |
| 2 | Create a knowledge base | Blob knowledge source → knowledge base in Azure AI Search | A-KB, A-KS-BLOB |
| 3 | Connect it to the agent | Project connection; attach knowledge to the concierge | A-IQ-CONNECT, A-CONN |
| 4 | Ask & cite | Document questions; citation-backed answers; combine with Fabric | A-IQ, A-IQ-CONNECT |
| 5 | Choose the right grounding | IQ vs file search vs memory; Copilot vs IQ sources | A-IQ-FAQ |

## Story framing
- **Recap:** Act 10 grounded the concierge in ContosoMart numbers.
- **Tension:** "What's our returns policy?" / "Which supplier contract covers Yirgacheffe?" aren't in any table.
- **Mission:** Add a knowledge base over ContosoMart documents and connect it for cited retrieval.
- **Outcome:** The concierge answers from both the numbers (Fabric) and the documents (Foundry IQ) — ready for Act 12's routing.

## Key grounded facts (do not drift)
- Foundry IQ = **agentic retrieval over a knowledge base**, built on **Azure AI Search**; grounds answers with source attribution.
- Knowledge bases can be called from Foundry Agent Service, Agent Framework, or any app using the Azure AI Search knowledge base APIs.
- IQ knowledge sources and **Copilot** knowledge sources are **not interoperable**.
- Decision guide: **Foundry IQ** to ground on curated org content; **file search** for a few user-provided files; **memory** for cross-session recall.
- Foundry IQ status: **partial GA** (API-level GA; portal access remains preview).

## Sample data (data/)
Three tiny synthetic ContosoMart documents (no real PII): a returns policy, a supplier contract
excerpt, and a cold-store ops runbook. These are the knowledge the tables can't answer.

## Refresh workflow
Re-fetch the Sources pages, diff, update the affected module + row, bump "Last fetched".
