# Data — Act 10 (Connect Fabric to Foundry)

This lab has **no new sample data**. It connects the Foundry agent to the **Act 8 Fabric data
agent**, which already reads the ContosoMart estate (gold lakehouse, warehouse star, semantic
model, KQL eventhouse).

What you need instead of files:
- The published data agent's `workspace_id` and `artifact_id` (from its URL:
  `.../groups/<workspace_id>/aiskills/<artifact_id>...`).
- The Foundry **Microsoft Fabric** connection ID created from those two GUIDs.

Test with the same questions as Act 8 — e.g. "What were total sales last week?" — but ask them
through the Foundry concierge.
