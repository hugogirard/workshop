# Data — Act 11 (Foundry IQ knowledge)

Three tiny **synthetic** ContosoMart documents (no real people, customers or data). These are the
questions the Fabric data agent can't answer — they live in files, not tables — so they're what the
Foundry IQ knowledge base indexes.

| File | What it covers | Sample question |
|---|---|---|
| `returns-policy.md` | Returns & refund policy, Freshness Guarantee, subscriptions | "Can a customer return an opened bag of beans?" |
| `supplier-contract.md` | Highland Roastery agreement — covers Ethiopia Yirgacheffe, lead times | "Which supplier covers Yirgacheffe, and the priority lead time?" |
| `ops-runbook.md` | Cold-store temperature thresholds & spoilage response | "A fridge hit 11 °C for 40 minutes — what do we do?" |

## How they're used
1. Upload all three to a Blob/ADLS Gen2 container (e.g. `contosomart-docs`).
2. Create a blob **knowledge source** over the container.
3. Build a **knowledge base** (`contosomart-knowledge`) in Azure AI Search.
4. Connect it to the `contosomart-concierge` agent for cited retrieval.

The docs cross-reference each other and Part 1 (the Yirgacheffe stock-out, the cold-store IoT
stream), so answers tie back to the wider ContosoMart story.
