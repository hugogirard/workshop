# ContosoMart Governance &amp; Data Mesh — Workshop Spec

Source-of-truth for [`index.html`](index.html). Follows the grounding contract in
[`../../AUTHORING.md`](../../AUTHORING.md). **Capstone** of the ContosoMart saga: make everything you
built discoverable, governed, and organized as a federated data mesh.

- **Audience:** technical learners + data/BI leads; analogies to catalogs, RBAC, data contracts.
- **Scenario:** ContosoMart organizes its estate (medallion gold, clickstream, finance warehouse, ML
  forecast, mirrored inventory) into business **domains**, publishes **data products**, discovers &
  **endorses** them in the OneLake Catalog, applies **sensitivity labels**, and reviews **lineage** —
  federated governance, data as a product.
- **Format:** self-contained interactive `index.html`; **hybrid** — hands-on where possible, admin
  steps illustrated.
- **Estimated time:** ~80–100 min.
- **Prerequisites:** Fabric trial capacity (60 days), a Fabric (Free) license. (Admin steps need
  Fabric admin / domain admin rights.)

## Sources (verified 2026-09-13)

| Ref | Page | URL | Last fetched |
| --- | --- | --- | --- |
| F-TRIAL | Fabric trial capacity | https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial | 2026-09-13 |
| F-OVERVIEW | What is Microsoft Fabric | https://learn.microsoft.com/en-us/fabric/fundamentals/microsoft-fabric-overview | 2026-09-13 |
| F-DOMAINS | Domains (data mesh) | https://learn.microsoft.com/en-us/fabric/governance/domains | 2026-09-13 |
| F-CATALOG | OneLake catalog overview | https://learn.microsoft.com/en-us/fabric/governance/onelake-catalog-overview | 2026-09-13 |
| F-ENDORSE | Endorsement (certify / promote) | https://learn.microsoft.com/en-us/fabric/governance/endorsement-overview | 2026-09-13 |
| F-INFOPROT | Information protection / sensitivity labels | https://learn.microsoft.com/en-us/fabric/governance/information-protection | 2026-09-13 |
| F-LINEAGE | Lineage in Fabric | https://learn.microsoft.com/en-us/fabric/governance/lineage | 2026-09-13 |
| F-EXTSHARE | OneLake external data sharing | https://learn.microsoft.com/en-us/fabric/governance/external-data-sharing-overview | 2026-09-13 |
| F-ROLES | Workspace roles | https://learn.microsoft.com/en-us/fabric/fundamentals/roles-workspaces | 2026-09-13 |

## Sample data (`data/`)

| File | Represents | Shape / notable quirks |
| --- | --- | --- |
| `domain-catalog.csv` | Target data-mesh map | 6 rows; domain/subdomain → data product → owner → endorsement |

## Module map (source of truth)

Legend: **[illustrated]** = read-along (admin rights needed). **[analogy]** = data-pro callout.

### Module 0 — Setup (F-TRIAL, F-OVERVIEW)
- Reuse `ContosoMart-Analytics`. Concept: from centralized IT to federated data mesh; why govern. [analogy: catalog + data contracts]

### Module 1 — Design domains (F-DOMAINS)
- Use `domain-catalog.csv` to plan Sales/Marketing/Finance/Operations domains + subdomains. Concept: domains group by business area.

### Module 2 — Create domains &amp; assign workspaces [illustrated] (F-DOMAINS)
- Admin portal: create domains, set domain admins/contributors, assign workspaces. Concept: federated governance, delegated settings. [analogy: RBAC delegation]

### Module 3 — Publish &amp; discover data products (F-CATALOG)
- OneLake Catalog: browse by domain/type/endorsement; add descriptions/owners; treat gold tables as products. Concept: discoverability, data as a product.

### Module 4 — Endorse: promote &amp; certify (F-ENDORSE)
- Promote/Certify the ContosoMart data products; who can certify. Concept: trust signals, quality gates. [analogy: signed/approved release]

### Module 5 — Protect: sensitivity labels &amp; DLP [illustrated] (F-INFOPROT)
- Apply sensitivity labels (e.g. Confidential on finance); inheritance; DLP. Concept: information protection travels with data.

### Module 6 — Lineage, sharing &amp; wrap-up (F-LINEAGE, F-EXTSHARE, F-ROLES)
- View end-to-end lineage across the saga; note cross-tenant sharing + workspace roles. Concept: transparency + federated governance. Tour recap.

## Refresh workflow (delta)
1. Re-fetch a source; diff against the rows above.
2. Edit the matching module block in `index.html` (search by module/step title).
3. Update the Sources row + bump "Last fetched".
4. Re-open `index.html`; confirm nav, progress, copy, tabs, theme still work.
