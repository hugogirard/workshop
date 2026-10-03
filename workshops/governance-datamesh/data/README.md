# Sample data — ContosoMart Governance &amp; Data Mesh

Reference data for the capstone lab. Safe to share; contains no real people or PII.
Unlike the other labs you don't ingest this — it's a **planning worksheet** you use as you set up
domains, assign data products, and endorse items.

| File | Represents | Format | Used how |
| --- | --- | --- | --- |
| `domain-catalog.csv` | The target data-mesh map for ContosoMart | CSV (6 rows) | A blueprint: which domain/subdomain each ContosoMart data product (from the earlier labs) belongs to, its owner role, and target endorsement — you reproduce this in Fabric |

Every `data_product` row maps to something you built earlier in the tour (medallion gold, the
Eventhouse clickstream, the finance warehouse view, the ML forecast, the mirrored inventory), so this
lab governs the whole ContosoMart estate.

> Domains, endorsement, sensitivity labels and default-domain settings need **Fabric admin /
> domain admin** rights that a trial user may not have. Steps that require admin are marked
> *illustrated* (read-along) in the lab.
