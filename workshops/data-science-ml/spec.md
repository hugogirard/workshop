# ContosoMart Data Science &amp; ML — Workshop Spec

Source-of-truth for [`index.html`](index.html). Follows the grounding contract in
[`../../AUTHORING.md`](../../AUTHORING.md). Continues the **ContosoMart** saga: turn the curated
medallion data into a **demand forecast** and write predictions back to gold — descriptive → predictive.

- **Audience:** technical learners new to Fabric; data pros welcome (notebook + MLflow ≈ tracked experiments).
- **Scenario:** ContosoMart trains a weekly SKU demand-forecast model in a Fabric notebook, tracks it
  with MLflow, registers it, batch-scores next week with `PREDICT`, and writes `gold.demand_forecast`
  for Power BI.
- **Format:** self-contained interactive `index.html`; hands-on lab on a Fabric trial.
- **Estimated time:** ~100–120 min.
- **Prerequisites:** Fabric trial capacity (60 days), a Fabric (Free) license.

## Sources (verified 2026-09-13)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| F-TRIAL | Fabric trial capacity | https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial | 2026-09-13 |
| F-DATASCI | Explore Data Science in Fabric | https://learn.microsoft.com/en-us/fabric/data-science/data-science-overview | 2026-09-13 |
| F-WRANGLER | Data Wrangler | https://learn.microsoft.com/en-us/fabric/data-science/data-wrangler | 2026-09-13 |
| F-MLEXP | Machine learning experiments (MLflow) | https://learn.microsoft.com/en-us/fabric/data-science/machine-learning-experiment | 2026-09-13 |
| F-MLMODEL | Machine learning model registry | https://learn.microsoft.com/en-us/fabric/data-science/machine-learning-model | 2026-09-13 |
| F-PREDICT | Score models with PREDICT | https://learn.microsoft.com/en-us/fabric/data-science/model-scoring-predict | 2026-09-13 |
| F-NOTEBOOK | Use notebooks | https://learn.microsoft.com/en-us/fabric/data-engineering/how-to-use-notebook | 2026-09-13 |
| F-DIRECTLAKE | Direct Lake overview | https://learn.microsoft.com/en-us/fabric/fundamentals/direct-lake-overview | 2026-09-13 |

## Sample data (`data/`)

| File | Represents | Shape / notable quirks |
| --- | --- | --- |
| `sku-demand-history.csv` | Weekly demand history | 24 rows; features + `units_sold` label; promo lift |
| `score-next-week.csv` | Next-week features | 3 rows; unlabeled scoring input |

## Module map (source of truth)

Legend: **[analogy]** = data-pro callout. Language is **PySpark/Python** throughout.

### Module 0 — Setup (F-TRIAL, F-DATASCI)
- Reuse `ContosoMart-Analytics`. Concept: the data science process; DS works on the same OneLake as BI. [analogy: no data hand-off]

### Module 1 — Explore with Data Wrangler (F-WRANGLER, F-NOTEBOOK)
- Load history into a notebook; use Data Wrangler to inspect + generate cleaning code. Concept: fast EDA, generated repeatable code.

### Module 2 — Feature engineering (F-DATASCI, F-NOTEBOOK)
- Build features (promo lift, sessions, lag). Concept: features drive model quality.

### Module 3 — Train &amp; track with MLflow (F-MLEXP)
- Train a regressor; log params/metrics/model to an MLflow experiment; compare runs. Concept: reproducible experiments. [analogy: version control for models]

### Module 4 — Register &amp; batch score with PREDICT (F-MLMODEL, F-PREDICT)
- Register the best model; score `score-next-week.csv` with the scalable `PREDICT` function. Concept: model registry + batch inference.

### Module 5 — Write predictions to gold &amp; serve (F-DIRECTLAKE)
- Write `gold.demand_forecast`; Direct Lake report; predictions enrich BI (descriptive → predictive). Concept: operationalize.

### Module 6 — Operationalize &amp; govern (F-NOTEBOOK, F-DATASCI)
- Schedule the scoring notebook; note semantic link, model governance, retraining. Concept: ML in production.

## Refresh workflow (delta)
1. Re-fetch a source; diff against the rows above.
2. Edit the matching module block in `index.html` (search by module/step title).
3. Update the Sources row + bump "Last fetched".
4. Re-open `index.html`; confirm nav, progress, copy, tabs, theme still work.
