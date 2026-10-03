# Act 12 — Agents that talk to each other (multi-agent)

Part 2, Act 12 (capstone) of the ContosoMart tour. Split the overloaded concierge into specialist
agents that collaborate — a Fabric numbers agent, a Foundry IQ knowledge agent, and a router — built
with Foundry workflows, with the code-first paths (Agent Framework, A2A) for what lasts.

## Open it
Open [`index.html`](index.html) in any modern browser. No server, build step or network needed.

## What you'll do
- See why specializing + routing beats one overloaded agent.
- Design the concierge team: router + numbers agent (Act 10 Fabric tool) + knowledge agent (Act 11 IQ).
- Build a workflow (group chat / sequential / human-in-the-loop) and wire agent nodes.
- Route and test mixed questions across specialists.
- Learn the workflow retirement (Dec 1, 2026) and migrate via Agent Framework / A2A / Logic Apps.
- Trace the multi-agent run, then publish the specialists and router.

## Prerequisites
- The Act 10 agent (Fabric tool) and Act 11 knowledge base, in one Foundry project.
- An Azure subscription with **Contributor** or higher on the project to create/run workflows.
- Workflows are **preview**; the in-portal designer retires **Dec 1, 2026** — the lab teaches the
  durable code-first paths.

## Data
No new files — the specialist agents reuse the Act 10 Fabric connection and the Act 11 knowledge
base. See [`data/README.md`](data/README.md).

## Sources
Grounded in Microsoft Learn — see [`spec.md`](spec.md). Key pages:
[Build a workflow](https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/workflow) ·
[A2A endpoint](https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/enable-agent-to-agent-endpoint) ·
[Agent Framework workflows](https://learn.microsoft.com/en-us/agent-framework/workflows/orchestrations/)
