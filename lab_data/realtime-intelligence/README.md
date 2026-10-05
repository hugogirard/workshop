# Sample data — ContosoMart Real-Time Intelligence

Synthetic data for the hands-on lab. Safe to share; contains no real people or PII.
You stream these into an **Eventhouse / KQL database** in Modules 2–3.

| File | Source system (simulated) | Format | Notes |
| --- | --- | --- | --- |
| `clickstream-events.json` | Storefront web/mobile clickstream | JSON array (15 events) | Sessions of `page_view → add_to_cart → purchase`/`cart_abandon`; mixed-case `customer_ref` (matches ContosoMart CRM `C-0007`, `C-0044`…); multi-geo; `value_cad` in CAD |
| `warehouse-sensors.csv` | Cold/dry-store IoT temperature sensors | CSV (10 rows) | `SENS-01` shows a cold-store excursion (temp rising 3.9 → 8.5 °C after a door-open) to trigger an Activator alert |

## Live sender (`sender/`)

`sender/send_events.py` streams these rows into a Fabric **Eventstream Custom endpoint**
(Event Hubs protocol), then generates an endless synthetic stream so a Real-Time Dashboard
keeps moving. The JSON field names match the `Clickstream` / `Sensors` KQL table columns, so
Fabric auto-maps the schema once events arrive. See [`sender/README.md`](sender/README.md).

Keep files small and human-inspectable so learners can watch each transform and alert fire.
These reuse the same `customer_ref` codes as the `ecommerce-medallion` workshop so the real-time
clickstream can later be joined to the CRM/gold tables from that lab.
