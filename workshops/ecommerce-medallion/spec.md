# ContosoMart E-Commerce Medallion — Workshop Spec

Source-of-truth for [`index.html`](index.html). Follows the grounding contract in
[`../../AUTHORING.md`](../../AUTHORING.md). Built from the e-commerce medallion example in the
Fabric deck (see `../../../spec.md`, slides 27–34).

- **Audience:** technical learners new to Fabric; data pros welcome (T-SQL / Spark analogies).
- **Scenario:** ContosoMart, an online coffee retailer, unifies raw web sales, warehouse
  inventory, and CRM customer data into a medallion lakehouse and serves a Power BI report.
- **Format:** self-contained interactive `index.html`; real hands-on lab on a Fabric trial.
- **Estimated time:** ~100–120 min.
- **Prerequisites:** Fabric trial capacity (60 days), a Fabric (Free) license, OneDrive
  configured for the account (Dataflow/upload path needs it).

## Sources (verified 2026-09-12)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| F-TRIAL | Fabric trial capacity | https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial | 2026-09-12 |
| F-WORKSPACE | Create a workspace | https://learn.microsoft.com/en-us/fabric/fundamentals/create-workspaces | 2026-09-12 |
| F-MEDALLION | Implement medallion lakehouse architecture | https://learn.microsoft.com/en-us/fabric/onelake/onelake-medallion-lakehouse-architecture | 2026-09-12 |
| F-LAKEHOUSE-TUT | Create your first lakehouse | https://learn.microsoft.com/en-us/fabric/data-engineering/tutorial-build-lakehouse | 2026-09-12 |
| F-LAKEHOUSE | What is a lakehouse | https://learn.microsoft.com/en-us/fabric/data-engineering/lakehouse-overview | 2026-09-12 |
| F-INGEST | Ingest data into the lakehouse | https://learn.microsoft.com/en-us/fabric/data-engineering/tutorial-lakehouse-data-ingestion | 2026-09-12 |
| F-NOTEBOOK | Use notebooks | https://learn.microsoft.com/en-us/fabric/data-engineering/how-to-use-notebook | 2026-09-12 |
| F-DELTA | Lakehouse and Delta tables | https://learn.microsoft.com/en-us/fabric/data-engineering/lakehouse-and-delta-tables | 2026-09-12 |
| F-SHORTCUTS | OneLake shortcuts | https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts | 2026-09-12 |
| F-DIRECTLAKE | Direct Lake overview | https://learn.microsoft.com/en-us/fabric/fundamentals/direct-lake-overview | 2026-09-12 |
| F-SECURITY | OneLake data security overview | https://learn.microsoft.com/en-us/fabric/onelake/security/get-started-security | 2026-09-12 |
| F-RLSCLS | Table, column, and row-level security | https://learn.microsoft.com/en-us/fabric/onelake/security/table-column-row-security | 2026-09-12 |
| F-VORDER | Delta optimization and V-Order | https://learn.microsoft.com/en-us/fabric/data-engineering/delta-optimization-and-v-order | 2026-09-12 |
| F-VACUUM | Delta Lake VACUUM | https://learn.microsoft.com/en-us/fabric/data-engineering/delta-lake-vacuum | 2026-09-12 |

## Sample data (`data/`)

| File | Represents | Shape / notable quirks |
| --- | --- | --- |
| `raw-sales.json` | Website order stream | 20 orders; mixed date formats (`2026-01-03`, `01/04/2026`, ISO ts), multi-currency (USD/CAD/EUR/GBP), `is_test` rows, mixed-case customer refs |
| `inventory.csv` | Warehouse inventory export | 7 SKUs; on-hand qty, reorder point, unit cost, restock date |
| `crm-customers.csv` | CRM customer export | 8 rows incl. duplicate customers (`C-0007`, `C-0044`) with variant country/email to force matching/dedupe |

## Module map (source of truth)

Legend: **[tabs]** = PySpark + T-SQL. **[analogy]** = data-pro callout.

### Module 0 — Setup (F-TRIAL, F-WORKSPACE)
- Start the 60-day Fabric trial from Account manager (F4/F64). [analogy: it's a sandbox subscription]
- Create workspace `ContosoMart-Analytics`; note trial limits (no Copilot, 1 TB, OneDrive needed).

### Module 1 — Lakehouses (F-LAKEHOUSE, F-LAKEHOUSE-TUT, F-MEDALLION)
- Create a schema-enabled lakehouse `lh_contosomart` with `bronze` / `silver` / `gold` schemas
  (keeps every snippet runnable in one trial). Note layer-per-lakehouse/workspace as the
  recommended production pattern for governance (F-MEDALLION).
- Explain Tables vs Files areas. [analogy: schema vs staging]

### Module 2 — Ingest → Bronze (F-INGEST, F-LAKEHOUSE-TUT, F-SHORTCUTS)
- Upload `data/` files into `lh_contosomart/Files/raw/`.
- Load raw into `bronze.*` Delta tables as-is (no cleansing). Mention shortcuts as the zero-copy alternative.

### Module 3 — Bronze → Silver (F-NOTEBOOK, F-DELTA, F-MEDALLION)
- PySpark notebook: standardize dates → `date`, convert currency → USD, drop `is_test` rows,
  dedupe + match customers across CRM systems; write Delta tables to the `silver` schema.

### Module 4 — Silver → Gold  [tabs] (F-MEDALLION, F-DELTA)
- Build gold business tables: daily sales, customer lifetime value (CLV), inventory reorder flags.
- Show the same aggregate in PySpark and in T-SQL (SQL analytics endpoint).

### Module 5 — Serve & Visualize (F-DIRECTLAKE, F-LAKEHOUSE-TUT)
- Create a Direct Lake semantic model over gold; auto-create / build a Power BI report.
- Explain Direct Lake (no import/copy; framing). [analogy: gold layer is the ideal Direct Lake source]

### Module 6 — Govern & Optimize (F-SECURITY, F-RLSCLS, F-VORDER, F-VACUUM)
- OneLake security role: hide `unit_cost_usd` (CLS) and filter to a region (RLS) for a Viewer.
- Optimize: V-Order + `OPTIMIZE`; retention with `VACUUM` (7-day min). Lineage / wrap-up.

## Refresh workflow (delta)
1. Re-fetch a source; diff against the rows above.
2. Edit the matching module block in `index.html` (search by module/step title).
3. Update the Sources row + bump "Last fetched".
4. Re-open `index.html`; confirm nav, progress, copy, tabs, theme still work.
