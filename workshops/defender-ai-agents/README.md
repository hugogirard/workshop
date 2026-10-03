# Act 13 — Secure the agents (Microsoft Defender for AI agents)

Part 3, Act 13 (finale) of the ContosoMart tour. The multi-agent concierge is live (Act 12) —
now discover every agent, score its posture, detect threats in near-real-time, hunt with
Advanced Hunting, and govern its identity and data with **Microsoft Defender for AI agents**.

## Open it
Open [`index.html`](index.html) in any modern browser. No server, build step or network needed.

## What you'll do
- See why autonomous agents need discovery, posture, detection and governance.
- Enable security for AI agents: Agent 365 onboarding, the Microsoft 365 connector, Copilot Studio.
- Discover the agent inventory in the Defender portal and find the ContosoMart Foundry agents.
- Assess risk levels, risk indicators and security recommendations.
- Detect and investigate near-real-time threats (jailbreak, prompt injection, secret leakage).
- **Hands-on:** hunt with Advanced Hunting over the `AgentsInfo` table (runnable KQL).
- Govern identity (Entra Agent ID) and data (Purview) for defense in depth.

## Prerequisites
- This is largely a **guided/illustrated tour** — the Defender experience needs **tenant-admin**
  rights, **Microsoft Agent 365** onboarding and the **Microsoft 365 connector**, which most
  attendees can't self-serve.
- The **hands-on Advanced Hunting** module (Module 5) is runnable if you have access to a
  Microsoft Defender tenant with Advanced hunting and the `AgentsInfo` table.
- Most security-for-AI features are **preview** and depend on Agent 365 onboarding.

## Data
No upload files — Defender works server-side. The `data/` folder ships the runnable Advanced
Hunting queries for Module 5. See [`data/README.md`](data/README.md).

## Sources
Grounded in Microsoft Learn — see [`spec.md`](spec.md). Key pages:
[Discover AI agents & posture](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-inventory) ·
[Enable security for AI agents](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/get-started-defender-security-for-ai) ·
[AI agent posture risk](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-risk-assessment) ·
[Detect & investigate threats](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-detection-protection) ·
[AgentsInfo table](https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-agentsinfo-table)
</content>
