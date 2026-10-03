# ContosoMart Mirroring &amp; Shortcuts — Workshop Spec

Source-of-truth for [`index.html`](index.html). Follows the grounding contract in
[`../../AUTHORING.md`](../../AUTHORING.md). Continues the **ContosoMart** saga: instead of copying
partner and operational data with pipelines, bring it into OneLake **zero-copy** via shortcuts and
mirroring.

- **Audience:** technical learners new to Fabric; data pros welcome (shortcut ≈ view/symlink; mirroring ≈ managed CDC replica).
- **Scenario:** ContosoMart references a partner roastery feed (in ADLS/S3) with a shortcut, mirrors
  its operational inventory database into OneLake, then queries both alongside the medallion gold —
  one copy, every engine.
- **Format:** self-contained interactive `index.html`; **hybrid** — shortcuts hands-on, mirroring
  illustrated (needs an external Azure DB).
- **Estimated time:** ~90–110 min.
- **Prerequisites:** Fabric trial capacity (60 days), a Fabric (Free) license. (Optional) an Azure
  SQL DB to do the mirroring step live.

## Sources (verified 2026-09-13)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| F-TRIAL | Fabric trial capacity | https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial | 2026-09-13 |
| F-ONELAKE | OneLake overview | https://learn.microsoft.com/en-us/fabric/onelake/onelake-overview | 2026-09-13 |
| F-SHORTCUTS | OneLake shortcuts | https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts | 2026-09-13 |
| F-MIRRORING | Mirroring in Fabric overview | https://learn.microsoft.com/en-us/fabric/mirroring/overview | 2026-09-13 |
| F-MIRROR-SQL | Mirror Azure SQL Database | https://learn.microsoft.com/en-us/fabric/mirroring/azure-sql-database | 2026-09-13 |
| F-EXTSHARE | OneLake external data sharing | https://learn.microsoft.com/en-us/fabric/governance/external-data-sharing-overview | 2026-09-13 |
| F-DELTA | Lakehouse and Delta tables | https://learn.microsoft.com/en-us/fabric/data-engineering/lakehouse-and-delta-tables | 2026-09-13 |
| F-DIRECTLAKE | Direct Lake overview | https://learn.microsoft.com/en-us/fabric/fundamentals/direct-lake-overview | 2026-09-13 |

## Sample data (`data/`)

| File | Represents | Shape / notable quirks |
| --- | --- | --- |
| `partner-roastery-feed.csv` | Partner feed in ADLS/S3 | 4 rows; shortcut target stand-in |
| `ops-inventory-export.json` | Azure SQL inventory table snapshot | 4 rows; mirroring result stand-in |

## Module map (source of truth)

Legend: **[analogy]** = data-pro callout. **[illustrated]** = read-along (external Azure resource needed).

### Module 0 — Setup (F-TRIAL, F-ONELAKE)
- Reuse `ContosoMart-Analytics`. Concept: the silo problem; zero-copy vs ETL; one logical lake. [analogy: symlink vs file copy]

### Module 1 — Shortcut to external storage (F-SHORTCUTS)
- Upload the partner feed to `Files/external/`, create an internal OneLake shortcut; explain ADLS/S3/Dataverse targets.
  Concept: reference not copy; live updates. [analogy: DB view / symlink]

### Module 2 — Load a shortcut into bronze (F-SHORTCUTS, F-DELTA)
- Read the shortcut in a notebook and materialize a bronze Delta table (or query in place). Concept: shortcut transforms, when to copy vs reference.

### Module 3 — Mirror an operational database [illustrated] (F-MIRRORING, F-MIRROR-SQL)
- Walk through mirroring an Azure SQL DB inventory table into OneLake as Delta (near real-time, no pipelines).
  Concept: managed CDC replica; database vs metadata vs open mirroring. [analogy: read replica for analytics]

### Module 4 — One copy, multi-engine (F-DELTA, F-MIRRORING)
- Query the mirrored/shortcut data with Spark and T-SQL; join to medallion gold. Concept: no export, every engine.

### Module 5 — Serve with Direct Lake (F-DIRECTLAKE)
- Direct Lake semantic model over the mirrored + shortcut data. Concept: near-real-time BI on operational data.

### Module 6 — Govern &amp; cross-tenant share (F-EXTSHARE)
- Cross-tenant external data sharing (read-only shortcut in the consumer tenant); governance at source. Concept: federated, governed sharing.

## Refresh workflow (delta)
1. Re-fetch a source; diff against the rows above.
2. Edit the matching module block in `index.html` (search by module/step title).
3. Update the Sources row + bump "Last fetched".
4. Re-open `index.html`; confirm nav, progress, copy, tabs, theme still work.
