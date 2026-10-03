# Sample data — ContosoMart Medallion Lab

Synthetic data for the hands-on lab. Safe to share; contains no real people or PII.
Upload these into the **bronze** layer in Module 2 (`Files/raw/`).

| File | Source system (simulated) | Format | Deliberate quirks the silver layer fixes |
| --- | --- | --- | --- |
| `raw-sales.json` | Website order stream | JSON | Mixed date formats (`2026-01-03`, `01/04/2026`, `05-01-2026`, ISO timestamp), 4 currencies (USD/CAD/EUR/GBP), `is_test` orders, mixed-case customer refs |
| `inventory.csv` | Warehouse inventory export | CSV | 7 SKUs with on-hand qty, reorder point, unit cost, restock date |
| `crm-customers.csv` | CRM customer export | CSV | Duplicate customers (`C-0007`, `C-0044`) with variant country/email to force matching + dedupe |

Files are intentionally tiny so you can see the effect of each transform.
