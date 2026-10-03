# Sample data — ContosoMart Data Factory ingestion

Synthetic data for the hands-on lab. Safe to share; contains no real people or PII.
You ingest these into the **bronze** lakehouse with Dataflow Gen2 and pipeline Copy activity.

| File | Source system (simulated) | Format | Notes |
| --- | --- | --- | --- |
| `supplier-prices.csv` | Supplier price list export | CSV (6 rows) | Untrimmed whitespace in headers/values, multi-currency (CAD/USD/EUR), duplicate SKU across suppliers, an updated `effective_date` — cleaned in Dataflow Gen2 |
| `daily-sales-2026-03-01.csv` | Daily web-sales extract (day 1) | CSV (4 rows) | Date-partitioned file; used for the parameterized/incremental Copy |
| `daily-sales-2026-03-02.csv` | Daily web-sales extract (day 2) | CSV (3 rows) | Second partition to demonstrate incremental load without reprocessing day 1 |

The `sku` and `customer_ref` codes match the `ecommerce-medallion` and `realtime-intelligence`
workshops so the automated bronze loads feed the same ContosoMart medallion.
