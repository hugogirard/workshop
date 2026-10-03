# ContosoMart Mirroring &amp; Shortcuts Lab

A hands-on Microsoft Fabric lab on **zero-copy integration**: instead of building pipelines to copy
partner and operational data, bring it into OneLake in place. Create a **shortcut** to an external
feed, see how **mirroring** replicates an operational database as Delta, then query everything with
one engine — the "one copy" promise, wired into the ContosoMart saga.

## Open the lab
Double-click [`index.html`](index.html) (opens in any browser). Check off steps as you go —
progress is saved in your browser. Use **Theme** to switch light/dark, **Reset** to clear progress.

## What you'll build
1. A reused `ContosoMart-Analytics` workspace
2. A **shortcut** to a partner roastery feed (stand-in for ADLS/S3)
3. A bronze table read from the shortcut (reference vs copy)
4. A walkthrough of **mirroring** an Azure SQL inventory table into OneLake
5. A multi-engine (Spark + T-SQL) query over mirrored + shortcut data
6. A Direct Lake report on near-real-time operational data
7. Cross-tenant **external data sharing**

> This lab is **hybrid**: shortcuts are fully hands-on; the mirroring module is *illustrated* (it
> needs a live Azure SQL DB) using a sample snapshot so you understand the result. If you have an
> Azure SQL DB, you can do the mirroring step live.

## Prerequisites
- A free [Microsoft Fabric trial capacity](https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial) (60 days) and a Fabric (Free) license.
- (Optional) an Azure SQL Database to run the mirroring step live.
- ~90–110 minutes.

> Trial reality check: Copilot/AI features aren't available in the trial; capacity is F4 or F64.

## Files
- [`index.html`](index.html) — the interactive lab
- [`spec.md`](spec.md) — grounded source-of-truth (module map + Microsoft Learn sources)
- [`data/`](data/) — partner feed (shortcut target) + operational snapshot (mirroring result)

## Sources
All steps are grounded in Microsoft Learn — see the Sources table in [`spec.md`](spec.md).
