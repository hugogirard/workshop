# ContosoMart Data Warehouse (T-SQL) — Workshop Spec

Source-of-truth for [`index.html`](index.html). Follows the grounding contract in
[`../../AUTHORING.md`](../../AUTHORING.md). Continues the **ContosoMart** saga: the finance team wants
a governed, T-SQL-first **Warehouse** (star schema) alongside the Spark lakehouse — this lab is the
one for SQL/Oracle folks.

- **Audience:** data pros comfortable with T-SQL / Oracle / dedicated SQL pools; also newcomers.
- **Scenario:** ContosoMart Finance builds a dedicated Fabric Warehouse, loads facts/dimensions with
  `COPY INTO`, models a star schema, writes T-SQL views, runs a cross-database query against the
  lakehouse SQL endpoint, and serves Power BI.
- **Format:** self-contained interactive `index.html`; hands-on lab on a Fabric trial.
- **Estimated time:** ~100–120 min.
- **Prerequisites:** Fabric trial capacity (60 days), a Fabric (Free) license.

## Sources (verified 2026-09-13)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| F-TRIAL | Fabric trial capacity | https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial | 2026-09-13 |
| F-WAREHOUSE | What is Fabric Data Warehouse | https://learn.microsoft.com/en-us/fabric/data-warehouse/data-warehousing | 2026-09-13 |
| F-WH-CREATE | Create a warehouse | https://learn.microsoft.com/en-us/fabric/data-warehouse/create-warehouse | 2026-09-13 |
| F-WH-INGEST | Ingest data into the warehouse | https://learn.microsoft.com/en-us/fabric/data-warehouse/ingest-data | 2026-09-13 |
| F-COPYINTO | COPY INTO (Transact-SQL) | https://learn.microsoft.com/en-us/sql/t-sql/statements/copy-into-transact-sql?view=fabric | 2026-09-13 |
| F-WH-TABLES | Tables in the warehouse | https://learn.microsoft.com/en-us/fabric/data-warehouse/tables | 2026-09-13 |
| F-WH-QUERY | Query the warehouse (cross-database) | https://learn.microsoft.com/en-us/fabric/data-warehouse/query-warehouse | 2026-09-13 |
| F-DGUIDE | Decision guide: warehouse vs lakehouse | https://learn.microsoft.com/en-us/fabric/fundamentals/decision-guide-lakehouse-warehouse | 2026-09-13 |
| F-DIRECTLAKE | Direct Lake overview | https://learn.microsoft.com/en-us/fabric/fundamentals/direct-lake-overview | 2026-09-13 |

## Sample data (`data/`)

| File | Represents | Shape / notable quirks |
| --- | --- | --- |
| `fact_orders.csv` | Order line facts | 7 rows; USD amounts; FKs to product/customer/date |
| `dim_product.csv` | Product dimension | 5 rows; unit_cost_usd, category, supplier |
| `dim_customer.csv` | Customer dimension | 5 rows; country, segment; CRM keys reused |

## Module map (source of truth)

Legend: **[tabs]** = T-SQL + lakehouse-Spark equivalent. **[analogy]** = data-pro callout.

### Module 0 — Setup (F-TRIAL, F-WAREHOUSE, F-DGUIDE)
- Reuse `ContosoMart-Analytics`. Concept: warehouse vs lakehouse (when to pick each); Delta storage
  under both; separated compute/storage. [analogy: dedicated SQL pool, reborn SaaS]

### Module 1 — Create the Warehouse (F-WH-CREATE, F-WH-TABLES)
- Create warehouse `wh_contoso_finance`; create typed tables (fact + 2 dims). Concept: full T-SQL DDL/DML,
  multi-table ACID. [analogy: CREATE TABLE like any RDBMS]

### Module 2 — Ingest with COPY INTO (F-WH-INGEST, F-COPYINTO)
- `COPY INTO` the three CSVs from OneLake/upload into the tables. Concept: high-throughput bulk load. [analogy: bcp/COPY]

### Module 3 — Star schema &amp; T-SQL transforms (F-WH-TABLES) [tabs]
- Model the star; build a `vw_sales` view joining fact+dims with margin. Concept: dims/facts, views,
  encapsulated business logic.

### Module 4 — Cross-database query (F-WH-QUERY) [tabs]
- Three-part-name query joining the warehouse to the lakehouse SQL analytics endpoint (gold). Concept:
  query across items, zero copy. [analogy: cross-DB three-part naming]

### Module 5 — Serve with Direct Lake (F-DIRECTLAKE)
- Build a Direct Lake semantic model over the warehouse; a finance report. Concept: no import, fast.

### Module 6 — Govern &amp; optimize (F-WAREHOUSE, F-WH-QUERY)
- Object/column security (GRANT, RLS), statistics, and result-set reuse; separation of compute/storage.
  Concept: governance &amp; performance without knobs.

## Refresh workflow (delta)
1. Re-fetch a source; diff against the rows above.
2. Edit the matching module block in `index.html` (search by module/step title).
3. Update the Sources row + bump "Last fetched".
4. Re-open `index.html`; confirm nav, progress, copy, tabs, theme still work.
