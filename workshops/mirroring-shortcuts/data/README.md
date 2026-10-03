# Sample data — ContosoMart Mirroring &amp; Shortcuts

Synthetic data for the hands-on lab. Safe to share; contains no real people or PII.
These stand in for *external* systems so you can practice zero-copy integration without owning
those systems.

| File | Stands in for | Format | Used how |
| --- | --- | --- | --- |
| `partner-roastery-feed.csv` | A partner supplier feed in ADLS Gen2 / Amazon S3 | CSV (4 rows) | Upload to a OneLake `Files/external/` folder, then create a **shortcut** to it (hands-on stand-in for an S3/ADLS shortcut) |
| `ops-inventory-export.json` | A row snapshot of an operational **Azure SQL DB** inventory table | JSON (4 rows) | Illustrates what a **mirrored** operational table looks like once it lands in OneLake as Delta (mirroring itself needs a live Azure SQL DB) |

> Mirroring a live database requires an external Azure SQL DB / Cosmos DB / Snowflake, which a
> trial user may not have. This lab is **hybrid**: shortcuts are fully hands-on; mirroring steps are
> illustrated with `note` callouts and this sample snapshot so you understand the result.
