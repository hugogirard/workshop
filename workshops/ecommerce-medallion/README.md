# ContosoMart Medallion Lab

A hands-on Microsoft Fabric lab: take an online coffee retailer's messy raw data —
web orders (JSON), warehouse inventory (CSV), and CRM customers (SQL export) — and build a
**bronze → silver → gold** medallion lakehouse, then serve a **Direct Lake** Power BI report.

## Get the lab files
Clone the GitHub repository so you have this lab and the `data/` files you upload in Module 2:

```bash
git clone https://github.com/hugogirard/workshop.git
cd workshop/workshops/ecommerce-medallion
```

## Open the lab
Double-click [`index.html`](index.html) (opens in any browser). Check off steps as you go —
progress is saved in your browser. Use **Theme** to switch light/dark, **Reset** to clear progress.

## What you'll build
1. A Fabric trial + workspace
2. A schema-enabled lakehouse (`bronze` / `silver` / `gold`)
3. Bronze raw tables from the sample files
4. Silver: standardized dates, USD amounts, test rows removed, deduped customers
5. Gold: daily sales, customer lifetime value, inventory reorder status
6. A Direct Lake semantic model + Power BI report
7. OneLake security (row/column) + Delta optimization (V-Order, VACUUM)

## Prerequisites
- A free [Microsoft Fabric trial capacity](https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial) (60 days) and a Fabric (Free) license.
- **OneDrive** configured for your account (the file-upload path needs it).
- **Git** (to clone this repo) or download the repo as a ZIP from GitHub.
- ~100–120 minutes.

> Trial reality check: Copilot/AI features aren't available in the trial; capacity is F4 or F64; OneLake storage is capped at 1 TB.

## Files
- [`index.html`](index.html) — the interactive lab
- [`spec.md`](spec.md) — grounded source-of-truth (module map + Microsoft Learn sources)
- [`data/`](data/) — synthetic sample data you upload in Module 2

## Sources
All steps are grounded in Microsoft Learn — see the Sources table in [`spec.md`](spec.md).
