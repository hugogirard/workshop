# ContosoMart Real-Time Intelligence Lab

A hands-on Microsoft Fabric lab: take ContosoMart's **data in motion** — storefront clickstream
(JSON) and cold-store IoT sensors (CSV) — and build an **Eventhouse / KQL** pipeline, a
**Real-Time dashboard**, and **Activator** alerts that fire on cart-abandon spikes and cold-store
temperature excursions. This is the *real-time* companion to the batch
[`ecommerce-medallion`](../ecommerce-medallion/) lab.

## Open the lab
Double-click [`index.html`](index.html) (opens in any browser). Check off steps as you go —
progress is saved in your browser. Use **Theme** to switch light/dark, **Reset** to clear progress.

## What you'll build
1. A Fabric trial + the `ContosoMart-Analytics` workspace (reused from the medallion lab)
2. An **Eventhouse** with a KQL database (`eh_contoso_rti`)
3. An **Eventstream** landing live clickstream into a KQL table
4. **KQL** queries: session funnels, windowed cart-abandon rate, sensor excursions
5. A **Real-Time dashboard** with auto-refreshing tiles
6. **Activator** rules that alert on abandonment spikes and cold-store temperature
7. **OneLake availability** so the same events are readable by Spark / T-SQL / Direct Lake

## Prerequisites
- A free [Microsoft Fabric trial capacity](https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial) (60 days) and a Fabric (Free) license.
- No external Azure resources needed — events are pushed from the KQL editor / an eventstream sample source.
- ~100–120 minutes.

> Trial reality check: Copilot/AI features aren't available in the trial; capacity is F4 or F64. This
> lab avoids Copilot-dependent steps.

## Files
- [`index.html`](index.html) — the interactive lab
- [`spec.md`](spec.md) — grounded source-of-truth (module map + Microsoft Learn sources)
- [`data/`](data/) — synthetic clickstream + sensor data you stream in Modules 2–3

## Sources
All steps are grounded in Microsoft Learn — see the Sources table in [`spec.md`](spec.md).
