# ContosoMart Data Science &amp; ML Lab

A hands-on Microsoft Fabric lab: turn ContosoMart's curated medallion data into a **demand
forecast**. Explore with **Data Wrangler**, engineer features, train and track a model with
**MLflow**, register it, batch-score with **PREDICT**, and write `gold.demand_forecast` for a
**Direct Lake** report — moving the saga from *descriptive* to *predictive*.

## Open the lab
Double-click [`index.html`](index.html) (opens in any browser). Check off steps as you go —
progress is saved in your browser. Use **Theme** to switch light/dark, **Reset** to clear progress.

## What you'll build
1. A reused `ContosoMart-Analytics` workspace
2. EDA on weekly demand history with Data Wrangler
3. Engineered features (promo lift, sessions, lag)
4. A trained regressor tracked in an **MLflow experiment**
5. A **registered model** + batch predictions via `PREDICT`
6. A `gold.demand_forecast` table + Direct Lake report
7. A scheduled scoring notebook (operationalized)

## Prerequisites
- A free [Microsoft Fabric trial capacity](https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial) (60 days) and a Fabric (Free) license.
- ~100–120 minutes.

> Trial reality check: Copilot/AI features aren't available in the trial; capacity is F4 or F64. This
> lab uses open-source ML libraries (scikit-learn) + built-in MLflow — no Copilot needed.

## Files
- [`index.html`](index.html) — the interactive lab
- [`spec.md`](spec.md) — grounded source-of-truth (module map + Microsoft Learn sources)
- [`data/`](data/) — demand history (training) + next-week features (scoring)

## Sources
All steps are grounded in Microsoft Learn — see the Sources table in [`spec.md`](spec.md).
