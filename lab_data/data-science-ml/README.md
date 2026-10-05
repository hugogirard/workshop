# Sample data — ContosoMart Data Science &amp; ML

Synthetic data for the hands-on lab. Safe to share; contains no real people or PII.
You train a demand-forecast model on the history and score next week's features.

| File | Represents | Format | Notes |
| --- | --- | --- | --- |
| `sku-demand-history.csv` | Weekly demand history per SKU | CSV (24 rows) | Features: `avg_price_cad`, `promo_flag`, `web_sessions`, `prev_week_units`; label `units_sold`. Promo weeks show a demand lift the model should learn |
| `score-next-week.csv` | Next week's feature row per SKU | CSV (3 rows) | No label — used for batch `PREDICT` scoring in Module 4 |

The `sku` codes reuse the ContosoMart catalog from the `ecommerce-medallion` gold layer, so the
predictions can be written back to a `gold.demand_forecast` table and joined to the rest of the saga.
