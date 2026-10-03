# ContosoMart Governance &amp; Data Mesh Lab

The **capstone** of the ContosoMart Fabric tour: make everything you built — medallion gold, the
Eventhouse clickstream, the finance warehouse, the ML forecast, the mirrored inventory —
**discoverable, governed, and organized as a data mesh**. Design **domains**, publish **data
products**, discover and **endorse** them in the OneLake Catalog, apply **sensitivity labels**, and
review **lineage**.

## Open the lab
Double-click [`index.html`](index.html) (opens in any browser). Check off steps as you go —
progress is saved in your browser. Use **Theme** to switch light/dark, **Reset** to clear progress.

## What you'll do
1. Reuse the `ContosoMart-Analytics` workspace
2. Design Sales / Marketing / Finance / Operations domains from the catalog blueprint
3. Create domains and assign workspaces (admin)
4. Discover data products in the OneLake Catalog
5. Promote &amp; certify the ContosoMart data products
6. Apply sensitivity labels + DLP (admin)
7. Review end-to-end lineage and recap the whole tour

> This lab is **hybrid**: designing, discovering and endorsing are hands-on; creating domains and
> applying sensitivity labels need **Fabric admin / domain admin** rights, so those steps are
> *illustrated* (read-along) if you don't have them.

## Prerequisites
- A free [Microsoft Fabric trial capacity](https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial) (60 days) and a Fabric (Free) license.
- Fabric admin / domain admin rights for the domain + label steps (optional; otherwise read-along).
- ~80–100 minutes.

> Trial reality check: Copilot/AI features aren't available in the trial; capacity is F4 or F64.

## Files
- [`index.html`](index.html) — the interactive lab
- [`spec.md`](spec.md) — grounded source-of-truth (module map + Microsoft Learn sources)
- [`data/`](data/) — the domain/data-product blueprint you reproduce in Fabric

## Sources
All steps are grounded in Microsoft Learn — see the Sources table in [`spec.md`](spec.md).
