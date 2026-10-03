# ContosoMart Data Factory Ingestion Lab

A hands-on Microsoft Fabric lab: <strong>automate</strong> the bronze ingestion that the
[`ecommerce-medallion`](../ecommerce-medallion/) lab did by hand. Clean a supplier price list with
<strong>Dataflow Gen2</strong>, land date-partitioned daily sales with a pipeline <strong>Copy
activity</strong>, make it <strong>incremental</strong>, then <strong>orchestrate</strong> and
<strong>monitor</strong> the whole flow.

## Open the lab
Double-click [`index.html`](index.html) (opens in any browser). Check off steps as you go —
progress is saved in your browser. Use **Theme** to switch light/dark, **Reset** to clear progress.

## What you'll build
1. A reused `ContosoMart-Analytics` workspace + `lh_contosomart` lakehouse
2. A **Dataflow Gen2** that cleans `supplier-prices.csv` into `bronze.supplier_prices`
3. A **pipeline Copy activity** landing daily sales into `bronze.daily_sales`
4. A **parameterized, incremental** copy (day 2 without reprocessing day 1)
5. An **orchestration**: Dataflow → Copy → silver Notebook, on a schedule
6. **Monitoring**: run history, retries, and failure alerts

## Prerequisites
- A free [Microsoft Fabric trial capacity](https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial) (60 days) and a Fabric (Free) license.
- **OneDrive** configured for your account (Dataflow Gen2 / upload path needs it).
- ~100–120 minutes.

> Trial reality check: Copilot/AI features aren't available in the trial; capacity is F4 or F64. This
> lab avoids Copilot-dependent steps.

## Files
- [`index.html`](index.html) — the interactive lab
- [`spec.md`](spec.md) — grounded source-of-truth (module map + Microsoft Learn sources)
- [`data/`](data/) — supplier price list + date-partitioned daily sales extracts

## Sources
All steps are grounded in Microsoft Learn — see the Sources table in [`spec.md`](spec.md).
