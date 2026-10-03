# Sample data — ContosoMart Data Warehouse (T-SQL)

Synthetic data for the hands-on lab. Safe to share; contains no real people or PII.
You load these into a **Fabric Warehouse** with `COPY INTO` in Module 2 and model them as a
**star schema** in Module 3.

| File | Represents | Format | Notes |
| --- | --- | --- | --- |
| `fact_orders.csv` | Order line facts (finance view) | CSV (7 rows) | `amount_usd` already in USD; foreign keys to product/customer/date; matches the medallion gold grain |
| `dim_product.csv` | Product dimension | CSV (5 rows) | `unit_cost_usd` for margin math; `category`, `supplier_id` |
| `dim_customer.csv` | Customer dimension | CSV (5 rows) | `country`, `segment` for slicing; keys reuse the CRM `C-00xx` codes |

Keys (`product_key`, `customer_key`, `order_date_key`) reuse the ContosoMart codes from the
`ecommerce-medallion` gold layer, so the finance warehouse aligns with the lakehouse.
