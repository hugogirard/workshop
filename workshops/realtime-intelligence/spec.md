# ContosoMart Real-Time Intelligence — Workshop Spec

Source-of-truth for [`index.html`](index.html). Follows the grounding contract in
[`../../AUTHORING.md`](../../AUTHORING.md). Continues the **ContosoMart** saga from the
`ecommerce-medallion` workshop — this lab adds *data in motion* (storefront clickstream +
warehouse IoT) alongside the batch medallion lakehouse.

- **Audience:** technical learners new to Fabric; data pros welcome (KQL ≈ SQL-for-logs analogy).
- **Scenario:** ContosoMart streams live storefront clickstream and cold-store sensor telemetry,
  queries it with KQL, visualizes it on a Real-Time dashboard, and fires Activator alerts on
  cart-abandonment spikes and cold-store temperature excursions.
- **Format:** self-contained interactive `index.html`; hands-on lab on a Fabric trial.
- **Estimated time:** ~100–120 min.
- **Prerequisites:** Fabric trial capacity (60 days), a Fabric (Free) license. No external Azure
  resources required — you push sample events from the KQL editor / an eventstream sample source.

## Sources (verified 2026-09-13)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| F-TRIAL | Fabric trial capacity | https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial | 2026-09-13 |
| F-WORKSPACE | Create a workspace | https://learn.microsoft.com/en-us/fabric/fundamentals/create-workspaces | 2026-09-13 |
| F-RTI | What is Real-Time Intelligence | https://learn.microsoft.com/en-us/fabric/real-time-intelligence/overview | 2026-09-13 |
| F-EVENTHOUSE | Eventhouse overview | https://learn.microsoft.com/en-us/fabric/real-time-intelligence/eventhouse | 2026-09-13 |
| F-KQLDB | Create a KQL database | https://learn.microsoft.com/en-us/fabric/real-time-intelligence/create-database | 2026-09-13 |
| F-EVENTSTREAM | Fabric Eventstreams overview | https://learn.microsoft.com/en-us/fabric/real-time-intelligence/event-streams/overview | 2026-09-13 |
| F-KQL | Kusto Query Language (KQL) overview | https://learn.microsoft.com/en-us/kusto/query/ | 2026-09-13 |
| F-RTDASH | Create a Real-Time dashboard | https://learn.microsoft.com/en-us/fabric/real-time-intelligence/dashboard-real-time-create | 2026-09-13 |
| F-ACTIVATOR | What is Fabric Activator | https://learn.microsoft.com/en-us/fabric/real-time-intelligence/data-activator/activator-introduction | 2026-09-13 |
| F-REALTIMEHUB | What is the Real-Time hub | https://learn.microsoft.com/en-us/fabric/real-time-hub/real-time-hub-overview | 2026-09-13 |
| F-ONELOGICAL | OneLake availability (one logical copy) | https://learn.microsoft.com/en-us/fabric/real-time-intelligence/one-logical-copy | 2026-09-13 |
| F-DIRECTLAKE | Direct Lake overview | https://learn.microsoft.com/en-us/fabric/fundamentals/direct-lake-overview | 2026-09-13 |

## Sample data (`data/`)

| File | Represents | Shape / notable quirks |
| --- | --- | --- |
| `clickstream-events.json` | Storefront clickstream | 15 events; session funnels; mixed-case `customer_ref` reused from the CRM in `ecommerce-medallion`; CAD values |
| `warehouse-sensors.csv` | Cold/dry-store IoT sensors | 10 rows; `SENS-01` cold-store temperature excursion after a door-open to trip an alert |

## Module map (source of truth)

Legend: **[analogy]** = data-pro callout. This workshop uses **KQL** (not PySpark/T-SQL) as the
primary language, so language tabs show **KQL** and (where relevant) the **T-SQL** equivalent in
the KQL queryset.

### Module 0 — Setup (F-TRIAL, F-WORKSPACE, F-RTI)
- Reuse the `ContosoMart-Analytics` workspace (or start the 60-day trial). Concept: Real-Time
  Intelligence responds to events *as they happen* vs the scheduled batch medallion. [analogy: OLTP triggers vs nightly ETL]

### Module 1 — Eventhouse & KQL database (F-EVENTHOUSE, F-KQLDB)
- Create Eventhouse `eh_contoso_rti`; it auto-creates a KQL database. Concept: time-series store,
  data auto-organized by arrival time. [analogy: a purpose-built append-only log warehouse]

### Module 2 — Ingest → Eventstream (bronze-in-motion) (F-EVENTSTREAM, F-REALTIMEHUB)
- Create Eventstream `es_clickstream`; use a sample/custom source to land `clickstream-events`
  into a KQL table; note Real-Time hub as the catalog of streams. Concept: no-code stream ingest.

### Module 3 — Shape & query with KQL (silver-in-motion) (F-KQL, F-EVENTHOUSE)
- KQL: parse/normalize `customer_ref`, compute session funnels, 5-min windowed cart-abandon rate,
  detect the sensor temperature excursion. Concept: KQL summarize/bin over streaming data. [analogy: GROUP BY + window functions]

### Module 4 — Real-Time dashboard (gold-in-motion) (F-RTDASH)
- Build a Real-Time dashboard: live purchases, abandon-rate tile, cold-store temp line, auto-refresh.
  Concept: seconds from ingest to insight.

### Module 5 — Act with Activator (F-ACTIVATOR)
- Create Activator rules: alert when 5-min cart-abandon rate > threshold, and when cold-store temp
  > 6 °C for 10 min. Concept: turn insight into action (email / Teams / pipeline). [analogy: DB trigger for the real world]

### Module 6 — Connect to OneLake & govern (F-ONELOGICAL, F-DIRECTLAKE)
- Turn on OneLake availability (one logical copy in Delta) so Spark/T-SQL/Power BI read the same
  events; note Direct Lake + joining to the medallion gold `customer_ltv`. RBAC / wrap-up.

## Refresh workflow (delta)
1. Re-fetch a source; diff against the rows above.
2. Edit the matching module block in `index.html` (search by module/step title).
3. Update the Sources row + bump "Last fetched".
4. Re-open `index.html`; confirm nav, progress, copy, tabs, theme still work.
