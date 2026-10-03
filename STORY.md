# The ContosoMart Story — narrative bible

This is the single source of truth for the story that threads every Fabric workshop
together. All labs share **one company (ContosoMart)**, **one workspace
(`ContosoMart-Analytics`)** and **one OneLake**. Keep names, personas and the arc
consistent across the hub and every `workshops/*/index.html`.

> Everything here is fictional. No real people, customers or data.

---

## The company

**ContosoMart** is a fast-growing **online coffee retailer**. It started in 2019 as a
single-origin bean subscription run out of one roastery. Six years later it sells beans,
gear and subscriptions in four currencies (USD, CAD, EUR, GBP) across the web, a mobile
app, and a handful of wholesale partners — and it ships from three warehouses.

Growth outran the plumbing. Every team bolted on its own tool:

- The **storefront** writes orders as JSON to a bucket.
- The **warehouse system** exports inventory as CSV.
- **Marketing** keeps customers in a CRM and dumps a SQL export.
- **Finance** lives in spreadsheets and wants T-SQL, not Spark.
- **Operations** runs a live SQL database for stock, and a cold-store fridge streams IoT.
- A **new roastery partner** drops a feed into their own cloud storage.

Nobody owns the whole picture. Reports disagree. That is the problem the tour solves.

---

## The central challenge — "the Monday numbers war"

Every Monday, the leadership standup turns into an argument. Finance, Operations and
Marketing each bring a different number for *last week's revenue* — because each pulls
from a different silo with different date formats, currencies and duplicate customers.
Worse, a best-seller (the **Ethiopia Yirgacheffe**) just sold out during a promo because
nobody saw the reorder point cross in time.

The CEO gives one mandate: **"One set of numbers everyone trusts — and I want to see
problems before they cost us, not after."**

That mandate becomes the seven-act journey below: land and trust the data, react to it
live, automate it, open it to SQL users, fold in partners without more ETL, look ahead
with ML, and finally govern the whole estate.

---

## The cast (light personas)

Use a name only where it adds motivation to a lab — never let it block the technical
steps. Keep it light.

| Persona | Role | Cares about | Shows up in |
|---|---|---|---|
| **Maya Chen** | Head of Data (the sponsor) | One trusted source; governance | Frames each act; Lab 1 & 7 |
| **Diego Santos** | Data engineer | Pipelines that don't break | Labs 1, 3, 5 |
| **Priya Nair** | BI analyst | Reports she can trust, in Power BI | Labs 1, 4 |
| **Sam Okafor** | Ops / supply lead | Stock-outs, live signals, forecasts | Labs 2, 6 |
| **Lena Fischer** | Governance & security | Access, sensitivity, lineage | Labs 6, 7, 13 |

---

## The seven-act arc

Each lab is "the next thing the business needs." For every act: the **situation**, what
**breaks**, the **mission**, and what you **fix**.

### Act 1 · The mess — *E-commerce Medallion* (`ecommerce-medallion`)
- **Situation:** Three silos — web orders (JSON), inventory (CSV), CRM export — mixed dates, four currencies, duplicate customers.
- **What breaks:** Nobody agrees on yesterday's sales; the Yirgacheffe stock-out.
- **Mission:** Land it all in OneLake and refine bronze → silver → gold into one trusted source; serve a Direct Lake report.
- **What you fix:** A single trusted daily-sales, customer-LTV and reorder view Priya can report on.

### Act 2 · Peak season — *Real-Time Intelligence* (`realtime-intelligence`)
- **Situation:** A promo hits. Carts are being abandoned *right now* and a cold-store fridge is warming.
- **What breaks:** Yesterday's report is too slow to save today's revenue or the beans.
- **Mission:** Stream clickstream + IoT into an Eventhouse, query with KQL, build a live dashboard, fire Activator alerts.
- **What you fix:** Sam sees problems as they happen and gets alerted before they cost money.

### Act 3 · No more manual uploads — *Data Factory Ingestion* (`data-factory-ingestion`)
- **Situation:** The medallion works, but someone re-uploads files by hand every morning.
- **What breaks:** Manual ingestion is slow, error-prone and doesn't scale.
- **Mission:** Clean a supplier price list with Dataflow Gen2, land daily sales with an incremental pipeline, orchestrate on a schedule.
- **What you fix:** Bronze fills itself, reliably, every day — Diego stops babysitting uploads.

### Act 4 · Finance wants in — *Data Warehouse (T-SQL)* (`warehouse-tsql`)
- **Situation:** Finance needs a governed star schema they can query in plain T-SQL.
- **What breaks:** Finance can't (and won't) use Spark; they need SQL and a warehouse contract.
- **Mission:** Stand up a Warehouse with `COPY INTO`, model a star, join it back to lakehouse gold in one cross-database query.
- **What you fix:** Priya and finance get a SQL-native star that reads the *same* OneLake data.

### Act 5 · Partners & the ops DB — *Mirroring & Shortcuts* (`mirroring-shortcuts`)
- **Situation:** A new roastery partner's feed and the live operational inventory DB need analyzing.
- **What breaks:** Building yet another brittle ETL pipeline for each new source doesn't scale.
- **Mission:** Bring both into OneLake **zero-copy** — a shortcut and database mirroring — then query it all with one engine.
- **What you fix:** New data lands with no copy and no pipeline; Diego adds sources in minutes.

### Act 6 · Look ahead — *Data Science & ML* (`data-science-ml`)
- **Situation:** Reporting the past isn't enough; the stock-out could have been predicted.
- **What breaks:** No forward view of demand, so purchasing is reactive.
- **Mission:** Train a demand forecast, track it with MLflow, batch-score with `PREDICT`, write predictions back to gold.
- **What you fix:** Sam gets a next-week demand forecast in the same report, driving proactive reorders.

### Act 7 · Govern the sprawl — *Governance & Data Mesh* (`governance-datamesh`)
- **Situation:** The estate now spans six workloads and dozens of items.
- **What breaks:** Nobody knows who owns what, which data to trust, or what's sensitive.
- **Mission:** Organize into domains and data products, endorse them in the OneLake Catalog, apply sensitivity labels, trace lineage end to end.
- **What you fix:** Lena and Maya get a governed, discoverable, trusted data mesh — the CEO's mandate delivered.

---

## Part 2 · ContosoMart goes agentic (Azure AI Foundry)

Part 1 ended with one governed, trusted estate in Fabric. But trust still meant *someone
who can write SQL, DAX or KQL*. Part 2 answers the CEO's follow-up: **"Now let anyone just
ask — and let the systems act on the answers."** These five acts put agents on top of the
same OneLake, using the Fabric data agent as the bridge into Azure AI Foundry.

> New prerequisite: these labs need an Azure subscription, and the Fabric data agent needs a
> paid F2+ (or P1+) capacity — the free trial can't run them. Keep the ContosoMart estate.

### Act 8 · Ask in plain English — *Fabric data agent* (`foundry-fabric-data-agent`)
- **Situation:** Priya and Sam still queue every ad-hoc question behind whoever can write the query.
- **What breaks:** Insight is bottlenecked on a few people; the estate is trusted but not *accessible*.
- **Mission:** Build and publish a Fabric data agent over gold, the warehouse star, the semantic model and the KQL eventhouse; add instructions and example queries; ask in plain English.
- **What you fix:** Anyone can ask ContosoMart's data a question and get a governed, read-only, cited answer.

### Act 9 · Your first Foundry agent — *Foundry Agent Service* (`foundry-first-agent`)
- **Situation:** The business wants an assistant that reasons and acts, not just one that queries Fabric.
- **What breaks:** A data agent alone can't plan, call tools, or publish to Teams/M365.
- **Mission:** Create a Foundry project, deploy a model, build a prompt agent, and test it in the playground.
- **What you fix:** Maya has a managed, governed agent runtime to build ContosoMart's assistant on.

### Act 10 · Give it the numbers — *Connect Fabric to Foundry* (`foundry-fabric-tool`)
- **Situation:** The Foundry agent is smart but ungrounded — it makes up numbers.
- **What breaks:** An assistant that guesses revenue is worse than none.
- **Mission:** Create the Microsoft Fabric connection, attach the Fabric data agent as a tool, and ground answers in real OneLake data via identity passthrough.
- **What you fix:** The Foundry agent answers ContosoMart questions with the *same* trusted numbers Priya reports on.

### Act 11 · Ground it in knowledge — *Foundry IQ* (`foundry-iq-knowledge`)
- **Situation:** "What's our returns policy?" and "which supplier contract covers Yirgacheffe?" aren't in any table.
- **What breaks:** Numbers alone can't answer document questions.
- **Mission:** Provision a Foundry IQ knowledge base over ContosoMart docs (policies, contracts, runbooks) and connect it for citation-backed retrieval.
- **What you fix:** The assistant answers from both the numbers (Fabric) and the documents (Foundry IQ).

### Act 12 · Agents that talk to each other — *Multi-agent* (`foundry-multi-agent`)
- **Situation:** One assistant now juggles numbers *and* policy — and it's getting muddled.
- **What breaks:** A single overloaded agent is hard to trust, debug and extend.
- **Mission:** Build a ContosoMart concierge that routes to specialists — the Fabric data agent for numbers, a Foundry IQ agent for policy — using Foundry workflows / A2A.
- **What you fix:** A clean multi-agent solution where focused agents collaborate; Maya gets the CEO's "just ask, and act" assistant.

---

## Part 3 · ContosoMart secures the agents (Microsoft Defender)

Part 2 ended with a multi-agent assistant anyone can just ask — and it *acts*: it invokes tools,
reads OneLake data, and answers across Teams and M365. That power is exactly the problem Part 3
solves. The CEO's mandate had two halves — "one set of numbers everyone trusts" (delivered in
Part 1) and "see problems before they cost us" (delivered for the *data* in Act 2). Part 3 extends
that second half to the *agents themselves*, using Microsoft Defender for AI agents as the security
plane over everything built so far.

> New prerequisite: these labs need **Microsoft Defender XDR** with **Microsoft Agent 365**
> onboarding and the **Microsoft 365 connector** — mostly a guided/illustrated tour, with a
> hands-on Advanced Hunting module. Most security-for-AI features are in **preview**.

### Act 13 · Secure the agents — *Defender for AI agents* (`defender-ai-agents`)
- **Situation:** The concierge and its specialists are live and autonomous; new agents keep getting built.
- **What breaks:** No inventory, no posture, no threat detection — a prompt injection or a leaked secret would go unseen, and nobody owns the agent estate.
- **Mission:** Discover every ContosoMart agent, assess its posture (risk levels, indicators, recommendations), detect near-real-time threats, hunt the `AgentsInfo` table with KQL, and govern identity (Entra Agent ID) and data (Purview).
- **What you fix:** Lena and the SecOps team get a governed, continuously-monitored agent estate — the saga closes: trusted, agentic and secure.

---

## Authoring rules for the story

1. **One estate.** Reuse `ContosoMart-Analytics` and `lh_contosomart`; every lab reads/writes the *same* OneLake.
2. **Recap → Tension → Mission → Outcome.** Open each lab with where the story is and what still hurts; close with a bridge to the next act.
3. **Ground the "why."** Every module explains *what it is*, *why in Fabric*, and *what it solves* — with a diagram — before the steps, and links to Microsoft Learn (see each `spec.md` Sources table).
4. **Coffee, lightly.** Keep the coffee flavor in the copy (beans, roastery, cold-store), not in the color palette — stay on the Fabric theme tokens.
