# ContosoMart Data Warehouse (T-SQL) Lab

A hands-on Microsoft Fabric lab for the **SQL crowd**: ContosoMart Finance builds a dedicated
**Warehouse**, bulk-loads facts/dimensions with `COPY INTO`, models a **star schema**, writes T-SQL
views, runs a **cross-database query** against the medallion lakehouse, and serves a **Direct Lake**
finance report. Companion to the Spark-first [`ecommerce-medallion`](../ecommerce-medallion/) lab.

## Open the lab
Double-click [`index.html`](index.html) (opens in any browser). Check off steps as you go —
progress is saved in your browser. Use **Theme** to switch light/dark, **Reset** to clear progress.

## What you'll build
1. A reused `ContosoMart-Analytics` workspace
2. A Warehouse `wh_contoso_finance` with typed fact + dimension tables
3. Bulk load via `COPY INTO` from CSV
4. A star schema + a `vw_sales` T-SQL view with margin
5. A cross-database query joining the warehouse to the lakehouse gold
6. A Direct Lake semantic model + finance report
7. Object/row security and warehouse optimization

## Prerequisites
- A free [Microsoft Fabric trial capacity](https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial) (60 days) and a Fabric (Free) license.
- ~100–120 minutes.

> Trial reality check: Copilot/AI features aren't available in the trial; capacity is F4 or F64. This
> lab avoids Copilot-dependent steps.

## Files
- [`index.html`](index.html) — the interactive lab
- [`spec.md`](spec.md) — grounded source-of-truth (module map + Microsoft Learn sources)
- [`data/`](data/) — fact + dimension CSVs you `COPY INTO` the warehouse

## Sources
All steps are grounded in Microsoft Learn — see the Sources table in [`spec.md`](spec.md).
