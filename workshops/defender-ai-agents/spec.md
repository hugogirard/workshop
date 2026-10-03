# Workshop spec — Secure the agents (ContosoMart, Act 13)

Part 3, Act 13 — the finale. The multi-agent concierge is live (Act 12). Now discover every
ContosoMart agent, assess its security posture, detect threats in near-real-time, hunt with
Advanced Hunting, and govern its identity + data with **Microsoft Defender for AI agents**
(and Entra Agent ID + Purview for defense in depth).

- **Audience:** SecOps, AI/data engineers, SEs. Internal + customer-facing.
- **Depth:** guided/illustrated portal tour (Defender XDR needs tenant-admin + Agent 365
  onboarding + connectors most attendees can't self-serve) **plus** a hands-on Advanced Hunting
  KQL module anyone with Defender access can run against the `AgentsInfo` table.
- **Grounding rule:** no product claim without a Sources row. Most security-for-AI features are
  **preview** and depend on **Microsoft Agent 365** onboarding — flag both in `note` callouts.

## Sources (canonical URLs — verified 2026-09-14)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| SAI-GETSTARTED | Enable security for AI agents using Microsoft Defender | https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/get-started-defender-security-for-ai | 2026-09-14 |
| SAI-INVENTORY | Discover AI agents and assess security posture | https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-inventory | 2026-09-14 |
| SAI-RISK | AI agent posture risk in Microsoft Defender (Preview) | https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-risk-assessment | 2026-09-14 |
| SAI-DETECT | Detect and investigate threats to AI agents (Preview) | https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-detection-protection | 2026-09-14 |
| SAI-AGENTSINFO | AgentsInfo table (advanced hunting schema) | https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-agentsinfo-table | 2026-09-14 |
| SAI-AH | Proactively hunt with Advanced Hunting | https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-overview | 2026-09-14 |
| SAI-AGENT365 | Microsoft Agent 365 overview | https://learn.microsoft.com/en-us/microsoft-agent-365/overview | 2026-09-14 |
| SAI-PURVIEW | Microsoft Purview data security & compliance for AI apps | https://learn.microsoft.com/en-us/purview/ai-microsoft-purview | 2026-09-14 |
| SAI-PURVIEW-AGENTS | Use Microsoft Purview for AI agents | https://learn.microsoft.com/en-us/purview/ai-agents | 2026-09-14 |
| SAI-ENTRA | Secure Generative AI with Microsoft Entra | https://learn.microsoft.com/en-us/entra/architecture/secure-generative-ai | 2026-09-14 |

## Sample data (`data/`)

Defender is portal-side — there is nothing to upload. The `data/` folder ships the runnable
Advanced Hunting queries for Module 5 instead.

| File | Represents | Shape / notable quirks |
| --- | --- | --- |
| `agent-hunting-queries.kql` | The hands-on KQL for Module 5 | Runs against `AgentsInfo` + correlation tables in *your* Defender tenant; read-only |
| `README.md` | Why there's no upload + how to use the KQL | — |

## Module map (source of truth)

Scenario workshop (not a lakehouse) — uses scenario modules per AUTHORING §2. Legend:
**[hands-on]** = runnable KQL; the rest are guided/illustrated portal tours.

### Module 0 — Why secure autonomous agents
- The Part 2 concierge now acts on its own: invokes tools, reads data, takes actions. Who
  watches it? Shadow agents, indirect prompt injection, over-privileged tools, no inventory.
- Defender + Agent 365 give one place to discover, assess, detect and hunt. (Ref: SAI-DETECT, SAI-AGENT365)

### Module 1 — Enable security for AI agents
- Onboard to Microsoft Agent 365; enable security-for-AI data collection (on by default).
- Connect the Microsoft 365 connector (Entra ID mgmt events, sign-in, apps, M365 activities).
- Onboard Copilot Studio real-time protection (Power Platform admin collaboration). (Ref: SAI-GETSTARTED)

### Module 2 — Discover the agent inventory
- Defender portal → Assets → AI agents → Agents tab. Columns: platform, publish status,
  MCP servers, discovered tools, active alerts, risk level, creation time.
- Find the ContosoMart Foundry agents from Acts 9–12; open the details pane + Agent page. (Ref: SAI-INVENTORY)

### Module 3 — Assess posture & risk  *(preview)*
- Risk levels: High / Medium / Low / No known risk / Not evaluated (combined from active indicators).
- Indicators: Weak Instructions, High-usage Agent, Indirect Prompt Injection Exposure,
  Privileged Business-system Access, Active Threat (+ local-agent indicators).
- Security recommendations mapped to indicators; recommendations ≠ risk level. (Ref: SAI-RISK, SAI-INVENTORY)

### Module 4 — Detect & investigate threats  *(preview)*
- Near-real-time alerts: jailbreak, indirect prompt injection (XPIA), malicious content
  propagation, secret/credential leakage, evasion, LLM reconnaissance, suspicious user/IP.
- Alerts correlate into incidents; real-time protection audit/block events → `BehaviorInfo`.
- Only **published** Foundry agents are supported for threat detection. (Ref: SAI-DETECT)

### Module 5 — Hunt with Advanced Hunting  **[hands-on]**
- `AgentsInfo` inventory: `summarize arg_max(Timestamp, *) by AgentId` + `LifecycleStatus != "Deleted"`.
- Filter risky config: external MCP servers, privileged tools, published + broad availability.
- Correlate `AgentsInfo` ↔ `AlertInfo` / `AlertEvidence` / `CloudAppEvents` / `BehaviorInfo`.
- Note: `AIAgentsInfo` → `AgentsInfo` rename (old table retires 2026-07-01). (Ref: SAI-AGENTSINFO, SAI-AH)

### Module 6 — Govern identity & data (defense in depth) + wrap-up
- Identity: Entra Agent ID (`EntraAgentId` / `EntraBlueprintId` in `AgentsInfo`); least-privilege,
  Conditional Access, PIM for the humans and workload identities behind agents. (Ref: SAI-ENTRA, SAI-AGENTSINFO)
- Data: Purview DSPM for AI, DLP, audit, Insider Risk (Risky AI usage) over agent interactions;
  ties back to Part 1 Act 7 governance + Part 2 identity passthrough. (Ref: SAI-PURVIEW, SAI-PURVIEW-AGENTS)
- Wrap-up: the CEO's "see problems before they cost us" now covers the agents. Mandate closed.

## Story framing
- **Recap:** The multi-agent concierge is live in Teams/M365 (Act 12) — anyone can ask, and it acts.
- **Tension:** Agents now act autonomously with real tools and data. Who inventories them, scores
  their risk, catches a prompt-injection or a leaked secret, and governs their identity?
- **Mission:** Discover every ContosoMart agent, assess posture, detect threats, hunt, and govern.
- **Outcome:** A governed, continuously-monitored agent estate. The whole saga closes.

## Key grounded facts (do not drift)
- Security for AI agents is enabled automatically when you onboard to **Microsoft Agent 365**;
  the M365 connector unlocks investigation + Advanced Hunting.
- Risk **level** is computed from active **risk indicators**; **recommendations** are calculated
  separately and mapped to the indicators they address.
- Threat detection is supported only for **published** Microsoft Foundry agents (not playground).
- The `AgentsInfo` table stores multiple snapshots per agent — use `arg_max(Timestamp, *)` for latest.
- `AIAgentsInfo` is being replaced by `AgentsInfo` (old name accessible until 2026-07-01).
- Local (endpoint) agents are onboarded separately via Defender for Endpoint runtime protection.

## Story-only data
No upload files. Module 5 runs KQL against the learner's own Defender `AgentsInfo` table.

## Refresh workflow (delta)
1. Re-fetch each Sources page; diff against the module blocks.
2. Edit the matching module in `index.html` (search by module/step title) + the Sources row.
3. Bump "Last fetched"; re-open `index.html` and confirm nav, progress, copy, tabs, theme work.
</content>
</invoke>
