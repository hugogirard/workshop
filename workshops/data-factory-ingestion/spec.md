# ContosoMart Data Factory Ingestion — Workshop Spec

Source-of-truth for [`index.html`](index.html). Follows the grounding contract in
[`../../AUTHORING.md`](../../AUTHORING.md). Continues the **ContosoMart** saga: the
`ecommerce-medallion` lab uploaded bronze files by hand — here we <em>automate</em> the ingest with
Data Factory (Dataflow Gen2 + pipelines) so bronze refreshes on a schedule.

- **Audience:** technical learners new to Fabric; data pros welcome (Power Query ≈ visual ELT; pipelines ≈ SSIS/ADF).
- **Scenario:** ContosoMart automates loading a supplier price list and date-partitioned daily
  sales extracts into the bronze lakehouse, cleans the price list with Dataflow Gen2, then
  orchestrates an incremental pipeline that also runs the silver notebook.
- **Format:** self-contained interactive `index.html`; hands-on lab on a Fabric trial.
- **Estimated time:** ~100–120 min.
- **Prerequisites:** Fabric trial capacity (60 days), a Fabric (Free) license, OneDrive configured
  (Dataflow Gen2 / upload paths need it).

## Sources (verified 2026-09-13)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| F-TRIAL | Fabric trial capacity | https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial | 2026-09-13 |
| F-DATAFACTORY | What is Data Factory | https://learn.microsoft.com/en-us/fabric/data-factory/data-factory-overview | 2026-09-13 |
| F-DATAFLOW | Dataflow Gen2 overview | https://learn.microsoft.com/en-us/fabric/data-factory/dataflows-gen2-overview | 2026-09-13 |
| F-PIPELINE | Data pipeline runs | https://learn.microsoft.com/en-us/fabric/data-factory/pipeline-runs | 2026-09-13 |
| F-COPYACT | Copy activity overview | https://learn.microsoft.com/en-us/fabric/data-factory/copy-data-activity | 2026-09-13 |
| F-COPYJOB | What is Copy job | https://learn.microsoft.com/en-us/fabric/data-factory/what-is-copy-job | 2026-09-13 |
| F-CONNECTORS | Connector overview (170+) | https://learn.microsoft.com/en-us/fabric/data-factory/connector-overview | 2026-09-13 |
| F-LAKEHOUSE | What is a lakehouse | https://learn.microsoft.com/en-us/fabric/data-engineering/lakehouse-overview | 2026-09-13 |
| F-NOTEBOOK | Use notebooks | https://learn.microsoft.com/en-us/fabric/data-engineering/how-to-use-notebook | 2026-09-13 |

## Sample data (`data/`)

| File | Represents | Shape / notable quirks |
| --- | --- | --- |
| `supplier-prices.csv` | Supplier price list | 6 rows; whitespace, multi-currency, duplicate SKU, updated effective_date (cleaned in Dataflow Gen2) |
| `daily-sales-2026-03-01.csv` | Daily sales extract (day 1) | 4 rows; date-partitioned for parameterized copy |
| `daily-sales-2026-03-02.csv` | Daily sales extract (day 2) | 3 rows; second partition for incremental load |

## Module map (source of truth)

Legend: **[analogy]** = data-pro callout. This workshop's language tabs show **Power Query (M)**
and **pipeline expression** where relevant.

### Module 0 — Setup (F-TRIAL, F-DATAFACTORY)
- Reuse `ContosoMart-Analytics`. Concept: data integration (ETL/ELT), 170+ connectors, why automate
  the manual bronze upload. [analogy: ADF/SSIS reborn as SaaS]

### Module 1 — Lakehouse target (F-LAKEHOUSE)
- Confirm/reuse `lh_contosomart` with a `bronze` schema as the ingestion destination. Concept:
  pick a sink; pipelines/dataflows write to lakehouse tables.

### Module 2 — Ingest → Bronze with Dataflow Gen2 (F-DATAFLOW)
- Build a Dataflow Gen2 over `supplier-prices.csv`: trim, fix types, standardize currency, set the
  lakehouse `bronze.supplier_prices` as data destination. Concept: low-code Power Query ELT (300+ transforms).

### Module 3 — Copy activity in a pipeline (F-COPYACT, F-COPYJOB, F-CONNECTORS)
- Build a pipeline with a Copy activity to land `daily-sales-2026-03-01.csv` into
  `bronze.daily_sales`. Concept: scalable data movement, source/sink, 170+ connectors. [analogy: bcp/COPY at scale]

### Module 4 — Parameterize &amp; go incremental (F-PIPELINE, F-COPYACT)
- Parameterize the file name by date; use a pipeline parameter/expression so day 2 loads without
  reprocessing day 1. Concept: incremental/CDC-style loads, idempotent ingest.

### Module 5 — Orchestrate (F-PIPELINE, F-NOTEBOOK)
- Chain Dataflow → Copy → Notebook (the silver cleanse) with success dependencies; add a schedule.
  Concept: control flow, dependencies, scheduling/triggers.

### Module 6 — Monitor &amp; govern (F-PIPELINE)
- Use run history / monitoring, retries, and alerts on failure. Concept: observability &amp; reliability.

## Refresh workflow (delta)
1. Re-fetch a source; diff against the rows above.
2. Edit the matching module block in `index.html` (search by module/step title).
3. Update the Sources row + bump "Last fetched".
4. Re-open `index.html`; confirm nav, progress, copy, tabs, theme still work.
