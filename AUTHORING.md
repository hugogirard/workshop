# Fabric Workshop Authoring Conventions

Shared conventions for every interactive, hands-on Microsoft Fabric workshop in this
repo. The [`SKILL.md`](SKILL.md) orchestrates the authoring flow; this file is the
design + grounding contract that each workshop must follow. Templates live in
[`templates/`](templates/).

---

## 1. Folder layout (one folder per workshop)

```
workshops/<workshop-slug>/
  spec.md        source-of-truth: audience, sources table, module map, grounding, refresh
  index.html     the self-contained interactive lab (all CSS/JS inline, no build step)
  README.md      quick start, prerequisites, how to open
  data/          synthetic sample data the learner uploads into Fabric
    *.json / *.csv
```

- `<workshop-slug>` is lowercase-kebab (e.g. `ecommerce-medallion`, `iot-realtime`).
- Never require a server, bundler, or network to open `index.html`.
- Keep sample data tiny (tens of rows) and human-inspectable.

## 2. The 7-module pattern

Every Fabric lakehouse workshop uses these phases. Rename the scenario, keep the arc.

| # | Module | Goal | Primary workload |
| - | --- | --- | --- |
| 0 | Setup | Start a Fabric trial, create the workspace(s) | Admin / portal |
| 1 | Lakehouses | Create bronze / silver / gold storage | Data Engineering |
| 2 | Ingest → Bronze | Land raw source data unchanged | Data Factory / upload / shortcuts |
| 3 | Bronze → Silver | Cleanse, standardize, dedupe | Spark notebook (PySpark) |
| 4 | Silver → Gold | Curate business tables / aggregates | Spark or Warehouse (T-SQL) |
| 5 | Serve & Visualize | Semantic model + report | Direct Lake + Power BI |
| 6 | Govern & Optimize | Security, V-Order, VACUUM, lineage | OneLake security + Delta |

- Bronze keeps source format; silver + gold are Delta. (grounded in the medallion doc)
- A workshop MAY add scenario-specific modules (e.g. Real-Time Intelligence), but the
  bronze→silver→gold spine stays.

## 3. Interactive component catalog

`index.html` must implement all of these (the template already wires them up):

- **Sticky sidebar nav + scroll-spy** — one entry per module, highlights the section in view.
- **Progress tracking** — a checkbox on every step; a top progress bar shows `% complete`;
  state persists in `localStorage` under a per-workshop key.
- **Collapsible step cards** — each step is a `<details>`-style card with an est-time badge.
- **Copy-to-clipboard code blocks** — every code snippet has a Copy button.
- **Language tabs** — where a step offers PySpark *and* T-SQL, show tabbed code.
- **Callouts** — three styles:
  - `verify` (green) — "Expected result" / how to confirm the step worked.
  - `pro` (teal) — "For data pros" analogy (mirror the deck's analogy callouts).
  - `note` (amber) — caveats, trial limits, gotchas.
- **Theme toggle** — light/dark, persisted; default follows `prefers-color-scheme`.
- **Doc links** — every module header links to its Microsoft Learn source(s).
- **Teach the *why* (required)** — a workshop must build understanding, not just clicks:
  - Each module opens with a 1–2 sentence **concept / "why this matters"** intro (the `.lead`
    line): what the Fabric capability is, the problem it solves, where it fits the saga.
  - Each step leads with its **intent** ("what we're doing and why"), not just commands.
  - Use `pro` for the concept analogy and `note` for trade-offs / when-to-use-this-vs-that.
  - Each module header carries a **"Learn more"** links row: 2–4 Microsoft Learn links
    (a concept/overview page + the specific feature page; optional one deep-dive), all from
    the `spec.md` Sources table (grounded, fetched, dated).
  - The hero/intro ties the lab to its Fabric pillar and (for the ContosoMart saga) to the
    prior workshop.

## 4. Theme tokens (Fabric-branded, matches the deck)

Use CSS variables. Palette mirrors `build/build.js` `COL` so HTML and PPTX stay consistent.

```
--fab-navy:  #10314B   --fab-teal:  #117865   --fab-cyan:  #0E7C86
--fab-blue:  #1E6FB0   --fab-bronze:#B87333   --fab-gold:  #C9A227
--fab-accent:#27C1A6
```

Bronze/silver/gold layer chips use `--fab-bronze`, `#8A97A0` (silver), `--fab-gold`.
Provide a `[data-theme="dark"]` block. Fonts: `Segoe UI` stack; monospace `Consolas`.
Do not pull in external fonts, CDNs, or frameworks.

## 5. Grounding rules (strict — Microsoft Learn)

1. Every workshop `spec.md` has a **Sources** table (Ref | Page | URL | Last fetched).
2. No step makes a product claim without a doc link backing it. Prefer linking the
   module header to the canonical page and inline-linking specific features.
3. Reuse the deck's canonical sources where they apply (see `../../spec.md`, S1–S5).
4. **Verify every URL resolves before publishing** (fetch it). Record the fetch date.
5. Code snippets are illustrative teaching code — keep them runnable against the sample
   data, and note any name (workspace, lakehouse, table) the learner must match.
6. On a docs delta: update the affected module in `index.html` + the `spec.md` row, and
   bump "Last fetched".

## 6. Canonical Fabric sources (reuse across workshops)

| Ref | Page | URL |
| --- | --- | --- |
| F-OVERVIEW | What is Microsoft Fabric | https://learn.microsoft.com/en-us/fabric/fundamentals/microsoft-fabric-overview |
| F-ONELAKE | OneLake overview | https://learn.microsoft.com/en-us/fabric/onelake/onelake-overview |
| F-MEDALLION | Medallion lakehouse architecture | https://learn.microsoft.com/en-us/fabric/onelake/onelake-medallion-lakehouse-architecture |
| F-TRIAL | Fabric trial capacity | https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial |
| F-WORKSPACE | Create a workspace | https://learn.microsoft.com/en-us/fabric/fundamentals/create-workspaces |
| F-LAKEHOUSE-TUT | Create your first lakehouse | https://learn.microsoft.com/en-us/fabric/data-engineering/tutorial-build-lakehouse |
| F-LAKEHOUSE | What is a lakehouse | https://learn.microsoft.com/en-us/fabric/data-engineering/lakehouse-overview |
| F-INGEST | Ingest data into the lakehouse | https://learn.microsoft.com/en-us/fabric/data-engineering/tutorial-lakehouse-data-ingestion |
| F-NOTEBOOK | Use notebooks | https://learn.microsoft.com/en-us/fabric/data-engineering/how-to-use-notebook |
| F-DELTA | Lakehouse and Delta tables | https://learn.microsoft.com/en-us/fabric/data-engineering/lakehouse-and-delta-tables |
| F-SHORTCUTS | OneLake shortcuts | https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts |
| F-DIRECTLAKE | Direct Lake overview | https://learn.microsoft.com/en-us/fabric/fundamentals/direct-lake-overview |
| F-SECURITY | OneLake data security overview | https://learn.microsoft.com/en-us/fabric/onelake/security/get-started-security |
| F-ROLES | Create and manage OneLake security roles | https://learn.microsoft.com/en-us/fabric/onelake/security/create-manage-roles |
| F-RLSCLS | Table, column, and row-level security | https://learn.microsoft.com/en-us/fabric/onelake/security/table-column-row-security |
| F-VORDER | Delta optimization and V-Order | https://learn.microsoft.com/en-us/fabric/data-engineering/delta-optimization-and-v-order |
| F-VACUUM | Delta Lake VACUUM | https://learn.microsoft.com/en-us/fabric/data-engineering/delta-lake-vacuum |
| F-MLV | Materialized lake views | https://learn.microsoft.com/en-us/fabric/data-engineering/materialized-lake-views/overview-materialized-lake-view |
| F-RTI | What is Real-Time Intelligence | https://learn.microsoft.com/en-us/fabric/real-time-intelligence/overview |
| F-EVENTHOUSE | Eventhouse overview | https://learn.microsoft.com/en-us/fabric/real-time-intelligence/eventhouse |
| F-KQLDB | Create a KQL database | https://learn.microsoft.com/en-us/fabric/real-time-intelligence/create-database |
| F-EVENTSTREAM | Fabric Eventstreams overview | https://learn.microsoft.com/en-us/fabric/real-time-intelligence/event-streams/overview |
| F-KQL | Kusto Query Language (KQL) overview | https://learn.microsoft.com/en-us/kusto/query/ |
| F-RTDASH | Create a Real-Time dashboard | https://learn.microsoft.com/en-us/fabric/real-time-intelligence/dashboard-real-time-create |
| F-ACTIVATOR | What is Fabric Activator | https://learn.microsoft.com/en-us/fabric/real-time-intelligence/data-activator/activator-introduction |
| F-REALTIMEHUB | What is the Real-Time hub | https://learn.microsoft.com/en-us/fabric/real-time-hub/real-time-hub-overview |
| F-DATAFACTORY | What is Data Factory | https://learn.microsoft.com/en-us/fabric/data-factory/data-factory-overview |
| F-DATAFLOW | Dataflow Gen2 overview | https://learn.microsoft.com/en-us/fabric/data-factory/dataflows-gen2-overview |
| F-PIPELINE | Data pipelines overview | https://learn.microsoft.com/en-us/fabric/data-factory/pipeline-runs |
| F-COPYACT | Copy activity overview | https://learn.microsoft.com/en-us/fabric/data-factory/copy-data-activity |
| F-COPYJOB | What is Copy job | https://learn.microsoft.com/en-us/fabric/data-factory/what-is-copy-job |
| F-CONNECTORS | Data Factory connector overview | https://learn.microsoft.com/en-us/fabric/data-factory/connector-overview |
| F-WAREHOUSE | What is Fabric Data Warehouse | https://learn.microsoft.com/en-us/fabric/data-warehouse/data-warehousing |
| F-WH-CREATE | Create a warehouse | https://learn.microsoft.com/en-us/fabric/data-warehouse/create-warehouse |
| F-WH-INGEST | Ingest data into the warehouse | https://learn.microsoft.com/en-us/fabric/data-warehouse/ingest-data |
| F-COPYINTO | COPY INTO (Transact-SQL) | https://learn.microsoft.com/en-us/sql/t-sql/statements/copy-into-transact-sql?view=fabric |
| F-WH-TABLES | Tables in the warehouse | https://learn.microsoft.com/en-us/fabric/data-warehouse/tables |
| F-WH-QUERY | Query the warehouse (cross-database) | https://learn.microsoft.com/en-us/fabric/data-warehouse/query-warehouse |
| F-DGUIDE-WHLH | Decision guide: warehouse vs lakehouse | https://learn.microsoft.com/en-us/fabric/fundamentals/decision-guide-lakehouse-warehouse |
| F-MIRRORING | Mirroring in Fabric overview | https://learn.microsoft.com/en-us/fabric/mirroring/overview |
| F-MIRROR-SQL | Mirror Azure SQL Database | https://learn.microsoft.com/en-us/fabric/mirroring/azure-sql-database |
| F-EXTSHARE | OneLake external data sharing | https://learn.microsoft.com/en-us/fabric/governance/external-data-sharing-overview |
| F-DATASCI | Explore Data Science in Fabric | https://learn.microsoft.com/en-us/fabric/data-science/data-science-overview |
| F-WRANGLER | Data Wrangler | https://learn.microsoft.com/en-us/fabric/data-science/data-wrangler |
| F-MLEXP | Machine learning experiments (MLflow) | https://learn.microsoft.com/en-us/fabric/data-science/machine-learning-experiment |
| F-MLMODEL | Machine learning model registry | https://learn.microsoft.com/en-us/fabric/data-science/machine-learning-model |
| F-PREDICT | Score models with PREDICT | https://learn.microsoft.com/en-us/fabric/data-science/model-scoring-predict |
| F-DOMAINS | Domains (data mesh) | https://learn.microsoft.com/en-us/fabric/governance/domains |
| F-CATALOG | OneLake catalog overview | https://learn.microsoft.com/en-us/fabric/governance/onelake-catalog-overview |
| F-INFOPROT | Information protection / sensitivity labels | https://learn.microsoft.com/en-us/fabric/governance/information-protection |
| F-ENDORSE | Endorsement (certify / promote) | https://learn.microsoft.com/en-us/fabric/governance/endorsement-overview |
| F-LINEAGE | Lineage in Fabric | https://learn.microsoft.com/en-us/fabric/governance/lineage |

> Last verified 2026-09-12 (medallion set); Real-Time/Factory/Warehouse/Mirroring/Data
> Science/Governance set added & verified 2026-09-13. Re-fetch and update the date when
> authoring a new workshop.

### Part 2 — Azure AI Foundry (agentic labs)

Part 2 continues the ContosoMart story: put agents on top of the Part 1 data estate. The
Fabric data agent is the bridge — it exposes governed OneLake data as conversational Q&A,
and Foundry agents consume it via the Microsoft Fabric tool with identity passthrough.
Canonical base for Foundry docs is `learn.microsoft.com/en-us/azure/foundry/` (the new
Microsoft Foundry portal), not the classic `/azure/ai-foundry/` paths.

| Ref | Page | URL |
| --- | --- | --- |
| A-DATAAGENT | Fabric data agent (concept) | https://learn.microsoft.com/en-us/fabric/data-science/concept-data-agent |
| A-DATAAGENT-CREATE | Create a Fabric data agent | https://learn.microsoft.com/en-us/fabric/data-science/how-to-create-data-agent |
| A-DATAAGENT-SHARE | Share and manage a Fabric data agent | https://learn.microsoft.com/en-us/fabric/data-science/data-agent-sharing |
| A-DATAAGENT-TENANT | Fabric data agent tenant settings | https://learn.microsoft.com/en-us/fabric/data-science/data-agent-tenant-settings |
| A-FOUNDRY | What is Microsoft Foundry | https://learn.microsoft.com/en-us/azure/foundry/what-is-foundry |
| A-AGENTS | What is Foundry Agent Service | https://learn.microsoft.com/en-us/azure/foundry/agents/overview |
| A-PROMPT-QS | Quickstart: create a prompt agent | https://learn.microsoft.com/en-us/azure/foundry/agents/quickstarts/prompt-agent |
| A-MODELS | Foundry Models overview | https://learn.microsoft.com/en-us/azure/foundry/concepts/foundry-models-overview |
| A-TOOLBOX | What is Toolbox in Foundry | https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/toolbox-overview |
| A-FABRIC-TOOL | Use the Microsoft Fabric data agent with Foundry agents | https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/tools/fabric |
| A-FABRIC-IQ | Fabric IQ tool (reason over Fabric data) | https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/tools/fabric-iq |
| A-RBAC | Azure RBAC in Foundry | https://learn.microsoft.com/en-us/azure/foundry/concepts/rbac-foundry |
| A-AGENT-ID | Agent identity | https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/agent-identity |
| A-IQ | What is Foundry IQ | https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/what-is-foundry-iq |
| A-IQ-CONNECT | Connect a Foundry IQ knowledge base to agents | https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/foundry-iq-connect |
| A-IQ-QS | Quickstart: Foundry IQ knowledge base on a hosted agent | https://learn.microsoft.com/en-us/azure/foundry/agents/quickstarts/quickstart-foundry-iq-hosted-agent |
| A-IQ-FAQ | Foundry IQ FAQ | https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/foundry-iq-faq |
| A-WORKFLOW | Build a workflow in Foundry | https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/workflow |
| A-A2A | Enable an incoming A2A endpoint | https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/enable-agent-to-agent-endpoint |
| A-AF | Microsoft Agent Framework workflows | https://learn.microsoft.com/en-us/agent-framework/workflows/orchestrations/ |
| A-OBS | Trace agents (observability) | https://learn.microsoft.com/en-us/azure/foundry/observability/concepts/trace-agent-concept |

> Last verified 2026-09-14 (Foundry Part 2 set). Foundry agents and the Fabric tool need an
> Azure subscription; the Fabric data agent needs a paid F2+ (or P1+) capacity and is **not**
> available on the free Fabric trial. Several items are in preview — flag them in `note` callouts.

**Part 2 prerequisite reality checks**
- Fabric data agent: paid **F2 or higher** (or Power BI Premium **P1+**) capacity with Fabric enabled; at least one data source with data (lakehouse/warehouse/semantic model/KQL DB); read access to sources. Not on the trial.
- The Fabric tool uses **identity passthrough (On-Behalf-Of)** — each end user needs access to the data agent and its underlying sources. Service-principal auth isn't supported.
- Keep the data agent and its data sources on capacities in the **same region**.
- Foundry: an Azure subscription; assign users at least the **Foundry User** RBAC role.
- Foundry data agent + Foundry project must be in the **same tenant**.

### Part 3 — Microsoft Defender (security for AI agents)

Part 3 closes the ContosoMart story: secure and govern the Part 2 agents. Microsoft Defender for AI
agents (in Microsoft Defender XDR, built on **Microsoft Agent 365**) discovers agents, scores their
posture, detects threats in near-real-time, and enables Advanced Hunting; Entra and Purview add
identity and data governance. Canonical base is `learn.microsoft.com/en-us/defender-xdr/security-for-ai/`.

| Ref | Page | URL |
| --- | --- | --- |
| SAI-GETSTARTED | Enable security for AI agents using Microsoft Defender | https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/get-started-defender-security-for-ai |
| SAI-INVENTORY | Discover AI agents and assess security posture | https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-inventory |
| SAI-RISK | AI agent posture risk (Preview) | https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-risk-assessment |
| SAI-DETECT | Detect and investigate threats to AI agents (Preview) | https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-detection-protection |
| SAI-AGENTSINFO | AgentsInfo table (advanced hunting schema) | https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-agentsinfo-table |
| SAI-AH | Proactively hunt with Advanced Hunting | https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-overview |
| SAI-AGENT365 | Microsoft Agent 365 overview | https://learn.microsoft.com/en-us/microsoft-agent-365/overview |
| SAI-PURVIEW | Microsoft Purview data security & compliance for AI apps | https://learn.microsoft.com/en-us/purview/ai-microsoft-purview |
| SAI-PURVIEW-AGENTS | Use Microsoft Purview for AI agents | https://learn.microsoft.com/en-us/purview/ai-agents |
| SAI-ENTRA | Secure Generative AI with Microsoft Entra | https://learn.microsoft.com/en-us/entra/architecture/secure-generative-ai |

> Last verified 2026-09-14 (Defender Part 3 set). Security for AI agents needs **Microsoft Defender
> XDR** with **Microsoft Agent 365** onboarding, the **Microsoft 365 connector**, and **Security
> Administrator** rights. Most features are **preview** — flag them in `note` callouts.

**Part 3 prerequisite reality checks**
- Security for AI agents is enabled automatically when you onboard to **Microsoft Agent 365**; the M365 connector unlocks investigation + Advanced Hunting.
- Threat detection is supported only for **published** Microsoft Foundry agents (not playground).
- Local (endpoint) agents are onboarded **separately** via Defender for Endpoint runtime protection.
- The `AgentsInfo` table stores multiple snapshots per agent — use `arg_max(Timestamp, *)` for latest. `AIAgentsInfo` is being replaced by `AgentsInfo` (old name accessible until 2026-07-01).
- The lab is mostly a **guided/illustrated tour**; only the Advanced Hunting module is hands-on.

## 7. Trial reality checks (from F-TRIAL)

- The trial is **60 days**, configured as an **F4 or F64** capacity (some tenants can
  increase F4 → F64). Not "F64 guaranteed."
- Copilot and AI experiences are **not** available in the trial — don't script steps that
  depend on them.
- Storage limit is **1 TB** in OneLake; up to **3 SQL databases**.
- The Dataflow Gen2 upload path relies on **OneDrive** being configured for the account.

## 8. Authoring checklist (Definition of Done)

- [ ] `spec.md` written with Sources table + module map, every URL fetched & dated.
- [ ] `index.html` implements all §3 components and the §4 theme.
- [ ] Every module header links to its Learn source; no unfounded claims.
- [ ] Every module has a concept/"why it matters" intro **and** a "Learn more" links row; `pro`/`note`
      callouts explain the analogy and the trade-offs (teach the *why*, not just the clicks).
- [ ] Sample data in `data/` is valid (JSON parses, CSV headers correct) and referenced by the steps.
- [ ] `README.md` lists prerequisites and how to open the lab.
- [ ] Opened `index.html` in a browser: nav, progress persistence, copy, tabs, theme all work; clean console.
