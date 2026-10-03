# Fabric &amp; Foundry Workshops

Interactive, Microsoft Learn-grounded, hands-on workshops in three parts: **Part 1 — Microsoft
Fabric** (build the data estate), **Part 2 — Azure AI Foundry** (put agents on top), and **Part 3 —
Microsoft Defender** (secure and govern the agents). Companion labs to `../Microsoft-Fabric-Deep-Dive.pptx`.
Each workshop is a single self-contained `index.html` you open in any browser (no server, no build
step). The hub's intro page has a narrated, play/pause animation that walks the whole thirteen-act
story end to end.

## What's here

| Path | Purpose |
| --- | --- |
| [`index.html`](index.html) | **Landing page** — the tour hub linking all workshops (open this first) |
| [`SKILL.md`](SKILL.md) | The `fabric-workshop-builder` skill — how to author a new workshop |
| [`AUTHORING.md`](AUTHORING.md) | Conventions: 7-module arc, interactive components, theme tokens, grounding rules, canonical sources |
| [`templates/`](templates/) | Reusable HTML shell + spec/data-readme templates to copy |
| [`workshops/`](workshops/) | The workshops themselves (one folder each) |

## Available workshops

A connected **ContosoMart** saga — one fictional online coffee retailer, one `ContosoMart-Analytics`
workspace and `lh_contosomart` lakehouse — toured across Fabric and then Azure AI Foundry. Suggested order:

### Part 1 — Microsoft Fabric (build the data estate)

| # | Workshop | Scenario | Open |
| - | --- | --- | --- |
| 1 | [ecommerce-medallion](workshops/ecommerce-medallion/) | Build a bronze→silver→gold lakehouse and serve a Direct Lake report | [`index.html`](workshops/ecommerce-medallion/index.html) |
| 2 | [realtime-intelligence](workshops/realtime-intelligence/) | Stream storefront clickstream + IoT into an Eventhouse; KQL, Real-Time dashboard, Activator alerts | [`index.html`](workshops/realtime-intelligence/index.html) |
| 3 | [data-factory-ingestion](workshops/data-factory-ingestion/) | Automate bronze loads with Dataflow Gen2 + incremental pipelines, orchestrated and monitored | [`index.html`](workshops/data-factory-ingestion/index.html) |
| 4 | [warehouse-tsql](workshops/warehouse-tsql/) | A dedicated T-SQL Warehouse: `COPY INTO`, star schema, cross-database query, Direct Lake | [`index.html`](workshops/warehouse-tsql/index.html) |
| 5 | [mirroring-shortcuts](workshops/mirroring-shortcuts/) | Zero-copy integration: shortcuts to external storage + mirroring an operational database | [`index.html`](workshops/mirroring-shortcuts/index.html) |
| 6 | [data-science-ml](workshops/data-science-ml/) | Train a demand forecast with MLflow, batch-score with PREDICT, write predictions to gold | [`index.html`](workshops/data-science-ml/index.html) |
| 7 | [governance-datamesh](workshops/governance-datamesh/) | Capstone: domains, data products, OneLake Catalog, endorsement, sensitivity labels, lineage | [`index.html`](workshops/governance-datamesh/index.html) |

### Part 2 — Azure AI Foundry (make it agentic)

| # | Workshop | Scenario | Open |
| - | --- | --- | --- |
| 8 | [foundry-fabric-data-agent](workshops/foundry-fabric-data-agent/) | Build &amp; publish a Fabric data agent over the estate — plain-English, governed, read-only Q&amp;A | [`index.html`](workshops/foundry-fabric-data-agent/index.html) |
| 9 | [foundry-first-agent](workshops/foundry-first-agent/) | Create a Foundry project, deploy a model, build + test a prompt agent | [`index.html`](workshops/foundry-first-agent/index.html) |
| 10 | [foundry-fabric-tool](workshops/foundry-fabric-tool/) | Attach the Fabric data agent as a tool with identity passthrough — grounded answers | [`index.html`](workshops/foundry-fabric-tool/index.html) |
| 11 | [foundry-iq-knowledge](workshops/foundry-iq-knowledge/) | Add a Foundry IQ knowledge base (Azure AI Search) for cited, document-grounded answers | [`index.html`](workshops/foundry-iq-knowledge/index.html) |
| 12 | [foundry-multi-agent](workshops/foundry-multi-agent/) | Capstone: a multi-agent concierge routes to Fabric-numbers and IQ-knowledge specialists | [`index.html`](workshops/foundry-multi-agent/index.html) |

### Part 3 — Microsoft Defender (secure & govern the agents)

| # | Workshop | Scenario | Open |
| - | --- | --- | --- |
| 13 | [defender-ai-agents](workshops/defender-ai-agents/) | Finale: discover, assess, detect, hunt &amp; govern the agents with Microsoft Defender for AI agents | [`index.html`](workshops/defender-ai-agents/index.html) |

> Each lab is standalone, but they share the ContosoMart names and build on each other's tables and
> agents. Some steps in Part 1 (workshops 5 and 7) are *illustrated* where they need an external Azure
> resource or tenant-admin rights the trial can't provide.

> **Part 2 prerequisites:** an **Azure subscription** and the **Foundry User** RBAC role, plus a paid
> **F2+ (or P1+)** Fabric capacity for the Fabric data agent (Act 8) — the free Fabric trial can't run
> these labs. Several Foundry features used here are in **preview**.

> **Part 3 prerequisites:** **Microsoft Defender XDR** with **Microsoft Agent 365** onboarding, the
> **Microsoft 365 connector**, and **Security Administrator** rights — mostly a *guided/illustrated tour*.
> The hands-on Advanced Hunting module (Act 13, Module 5) needs access to a Defender tenant with the
> `AgentsInfo` table. Most security-for-AI features are in **preview**.

## Deploy the workshop to Azure

The workshop is **not** run locally — it's hosted in Azure. After the deploy, learners open a public URL;
the container serves the hub + all 13 workshops. Two one-time steps from the repo root.

### 1. Provision the Azure infrastructure (pre-step)

Parts 2–3 need live Azure resources (a **Microsoft Fabric capacity**, an **Azure AI Foundry** resource +
project, and a **model deployment**). The Bicep lives in [`infra/`](infra/) and deploys with the Azure
Developer CLI.

> **Required role:** you must be **Owner** on the target subscription — or, at minimum, **Contributor**
> *and* **User Access Administrator**. `Contributor` alone can create the resources but **not** the role
> assignments the template needs, which fails with
> `Unauthorized: Unable to authorize with Azure Active Directory` *after* the resource group is created.

> **Tenant must be onboarded to Microsoft Fabric.** The Fabric capacity deploy also fails with
> `Unauthorized: Unable to authorize with Azure Active Directory` (portal message: *"The default location
> can't be detected because the tenant or user wasn't recognized by Microsoft Fabric. Sign up for
> Microsoft Fabric and try again."*) when the tenant has never been registered with Fabric. Fix it once:
> sign in at [app.fabric.microsoft.com](https://app.fabric.microsoft.com) and start a **Fabric trial**
> (or any Fabric/Power BI license) to register the tenant, then re-run `azd provision`.

```bash
az login
azd auth login
az account set --subscription <SUBSCRIPTION_ID>

# First time per subscription — register the providers
az provider register --namespace Microsoft.Fabric
az provider register --namespace Microsoft.CognitiveServices

azd provision          # tear down later with: azd down --purge
```

See [`infra/README.md`](infra/README.md) for the full prerequisites and the role-assignment command.

### 2. Build & host the workshop container (Azure Container Instances)

The repo ships a [`Dockerfile`](Dockerfile) that serves the hub + every workshop with nginx on port 8080.
`azd provision` now does this for you: a **postprovision** hook ([`deployment/scripts/deploy-container.ps1`](deployment/scripts/deploy-container.ps1)
/ [`.sh`](deployment/scripts/deploy-container.sh)) builds the image with **ACR Tasks** (`az acr build` — no
local Docker) and runs it as a public **Container Instance** behind a **Caddy** sidecar that terminates
HTTPS with an automatic Let's Encrypt certificate. The public URL is written to the azd
environment as `WORKSHOP_URL`:

```bash
azd env get-value WORKSHOP_URL
```

If you need to (re)build and deploy it by hand, the hook runs the equivalent of:

```bash
# Build the image directly in ACR
az acr build --registry <ACR_NAME> --image fabric-workshop:latest .

# Run it as a public Container Instance
az container create \
  --resource-group <RESOURCE_GROUP> \
  --name fabric-workshop \
  --image <ACR_NAME>.azurecr.io/fabric-workshop:latest \
  --registry-login-server <ACR_NAME>.azurecr.io \
  --ports 80 \
  --dns-name-label contosomart-<AZURE_ENV_NAME> \
  --os-type Linux
```

Learners then open the ACI URL, e.g. `http://contosomart-<env>.<region>.azurecontainer.io/`.

## Run a workshop
Open the **hosted URL** from the Container Instance deploy (above) — `azd env get-value WORKSHOP_URL`,
e.g. `http://contosomart-<env>.<region>.azurecontainer.io/` — and start from the hub page. Progress (step
checkboxes) is saved in each learner's browser via `localStorage`; use **Reset** to clear it. Toggle
light/dark with **Theme**. The hub's intro page has a play/pause **animation** that narrates all thirteen
acts end to end. For Part 1 hands-on steps you need a free
[Fabric trial](https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial); Part 2 additionally
needs the Azure resources from the deploy above (paid F2+ capacity, Foundry, model).

## Add a new workshop
Follow [`SKILL.md`](SKILL.md): pick a slug, copy the templates, ground the `spec.md` against
Microsoft Learn (verify every URL), author the modules, generate sample data, and run the
Definition-of-Done checks in [`AUTHORING.md`](AUTHORING.md) §8. Use
`workshops/ecommerce-medallion/` as the worked example.

> This `SKILL.md` lives in the repo so it's versioned with the deck. To have it auto-discovered
> everywhere, copy the `workshop/` folder into your skills directory (e.g. `~/.copilot/skills/`).
