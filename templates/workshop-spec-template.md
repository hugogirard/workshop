# <Workshop Title> — Spec

Source-of-truth for `workshops/<slug>/index.html`. Follows the repo grounding contract in
[`../../AUTHORING.md`](../../AUTHORING.md). When a source page changes, update the affected
module block in `index.html` and the matching row below, then bump "Last fetched".

- **Audience:** <who this is for; note any data-pro analogies used>
- **Scenario:** <one-line real-world use case>
- **Format:** self-contained interactive `index.html`; real hands-on lab on a Fabric trial.
- **Estimated time:** <total, e.g. 90–120 min>
- **Prerequisites:** Fabric trial capacity (60 days), a Fabric (Free) license, OneDrive configured for uploads.

## Sources (canonical URLs — verify each before publishing)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| <REF> | <page title> | <https://learn.microsoft.com/...> | <YYYY-MM-DD> |

## Sample data (`data/`)

| File | Represents | Shape / notable quirks |
| --- | --- | --- |
| <file> | <bronze source> | <rows; messy fields that justify silver transforms> |

## Module map (source of truth)

Legend: **[tabs]** = PySpark + T-SQL tabs. **[analogy]** = data-pro callout.

### Module 0 — Setup
- <steps> (Ref: <REF>)

### Module 1 — Lakehouses
- <steps> (Ref: <REF>)

### Module 2 — Ingest → Bronze
- <steps> (Ref: <REF>)

### Module 3 — Bronze → Silver
- <steps> (Ref: <REF>)

### Module 4 — Silver → Gold  [tabs]
- <steps> (Ref: <REF>)

### Module 5 — Serve & Visualize
- <steps> (Ref: <REF>)

### Module 6 — Govern & Optimize
- <steps> (Ref: <REF>)

## Refresh workflow (delta)
1. Re-fetch a source page; diff against the rows above.
2. Edit the matching module block in `index.html` (search by module/step title).
3. Update the Sources row + bump "Last fetched".
4. Re-open `index.html`; confirm nav, progress, copy, tabs, theme still work.
