# Cold-Store Operations Runbook — Warehouse Refrigeration

> Fictional sample document for the Foundry IQ workshop. No real people, customers or data.

**Doc ID:** OPS-COLD-007 · **Owner:** Operations (Sam Okafor) · **Applies to:** all three warehouses

## 1. Purpose
How to respond when a cold-store fridge (which streams IoT sensor data into the Eventhouse from
Act 2) reports an out-of-range temperature.

## 2. Temperature thresholds
- **Target range:** 2 °C to 6 °C.
- **Warning:** sustained &gt; 6 °C for 10 minutes.
- **Critical:** &gt; 8 °C for 5 minutes, or any reading &gt; 10 °C.

## 3. Response steps
1. **Warning** — the on-call ops lead is alerted (Activator rule from Act 2). Verify the reading
   in the Real-Time dashboard; check the door sensor for a stuck-open door.
2. **Critical** — move perishable stock to the backup unit; log the incident; notify the site manager.
3. If the reading exceeds 10 °C for **more than 30 minutes**, treat affected perishables as
   **spoiled** and remove them from sellable inventory.

## 4. Spoilage &amp; inventory
Spoiled cold-store items are **non-returnable to customers** (see POL-RET-032, Section 7) and must
be written off in the inventory system within 24 hours.

## 5. Escalation contacts
- On-call ops lead → Site manager → Head of Operations.
- Refrigeration vendor SLA: 4-hour response for critical faults.

## 6. Preventive checks
Weekly: verify sensor calibration; monthly: test the backup unit under load.
