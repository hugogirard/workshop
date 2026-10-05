# Data — Act 8 (Fabric data agent)

This lab **reuses the ContosoMart estate from Part 1** — there are no new upload files. The data
agent reads *tables* (not standalone files), so everything below already exists as Delta tables
from Acts 1–6.

## Sources the agent uses

| Source | Item | Tables |
|---|---|---|
| Lakehouse (gold) | `lh_contosomart` | `daily_sales`, `customer_ltv`, `inventory_reorder`, `demand_forecast` |
| Warehouse (star) | `wh_contosomart` | `fact_orders`, `dim_customer`, `dim_product` |
| Semantic model | ContosoMart sales model | governed measures (revenue, margin, LTV) |
| KQL DB (Eventhouse) | ContosoMart events | `clickstream`, `warehouse_sensors` |

> If you didn't complete Part 1, create these tables from that lab's `data/` files first —
> the data agent can't answer over raw CSV/JSON files, only over tables.

## Sample questions to test

- "What were total sales last week?" → warehouse / gold
- "Who are our top 10 customers by lifetime value?" → semantic model / `customer_ltv`
- "Which SKUs are below their reorder point right now?" → `inventory_reorder`
- "How many carts were abandoned yesterday?" → KQL `clickstream` (add a time filter)
- "Is any cold-store sensor above 6 °C in the last hour?" → KQL `warehouse_sensors`

All questions are answered **read-only** and capped (currently 25 rows × 25 columns).
