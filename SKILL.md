---
name: fabric-workshop-builder
description: >
  Author interactive, Microsoft Learn-grounded, hands-on Microsoft Fabric workshops as
  self-contained HTML labs. USE FOR: create a Fabric workshop, new Fabric hands-on lab,
  build a lakehouse/medallion workshop, add another workshop, interactive Fabric tutorial,
  turn the Fabric deck into a lab, e-commerce/IoT/finance Fabric lab. Produces
  workshops/<slug>/{spec.md,index.html,README.md,data/} following the repo's 7-module
  arc and Fabric theme. DO NOT USE FOR: editing the PPTX deck (see ../spec.md + build/),
  non-Fabric content, or generic web apps (use web-artifacts-builder).
---

# Fabric Workshop Builder

Build a new interactive Fabric workshop that matches the deck's branding and is grounded
in Microsoft Learn. Read [`AUTHORING.md`](AUTHORING.md) first — it holds the folder layout,
the 7-module pattern, the interactive component catalog, the theme tokens, the grounding
rules, and the canonical source list. This skill is the *how-to*; `AUTHORING.md` is the
*contract*.

## When to use
The user wants a new hands-on Fabric lab (any scenario), another workshop alongside
`workshops/ecommerce-medallion/`, or to convert a deck section into an interactive lab.

## Inputs to confirm with the user
1. **Scenario** — the real-world use case (e-commerce, IoT/real-time, finance, etc.).
2. **Depth** — real hands-on (Fabric trial) vs illustrated walkthrough. Default: hands-on.
3. **Extra modules** — anything beyond the bronze→silver→gold spine (e.g. Real-Time Intelligence).

## Workflow

1. **Pick the slug** — lowercase-kebab, e.g. `iot-realtime`. Create `workshops/<slug>/`.

2. **Research + write `spec.md`** — copy [`templates/workshop-spec-template.md`](templates/workshop-spec-template.md).
   - Reuse the canonical sources in `AUTHORING.md` §6; add scenario-specific Learn pages.
   - **Fetch every URL** to confirm it resolves; record the date in the Sources table.
   - Fill the module map (the 7-module arc, §2) with the concrete steps for this scenario.

3. **Generate sample data** — put tiny synthetic files in `data/` that the silver layer
   will visibly clean (mixed date formats, multi-currency, test rows, duplicate customers,
   etc.). Copy [`templates/data-readme-template.md`](templates/data-readme-template.md) → `data/README.md`.
   No real PII.

4. **Build `index.html`** — copy [`templates/workshop.template.html`](templates/workshop.template.html).
   - Replace every `{{TOKEN}}` (title, subtitle, intro, slug for the `STORAGE_KEY`).
   - Duplicate the `<section class="module">` block once per module; give each step a
     unique `data-step` id (e.g. `m3-s2`) so progress tracking works.
   - Use the callout styles (`verify` / `pro` / `note`) and language `tabs` per `AUTHORING.md` §3.
   - Link each module header to its Learn source(s). No claim without a doc link.
   - Keep it self-contained: no CDN, no build step, no network to open.

5. **Write `README.md`** — prerequisites, how to open the lab, trial reality checks
   (see `AUTHORING.md` §7), and the doc sources.

6. **Verify (Definition of Done, `AUTHORING.md` §8)** — open `index.html` in a browser:
   sidebar nav + scroll-spy, progress bar persists across reload, copy buttons, PySpark/T-SQL
   tabs, and theme toggle all work; console is clean. Validate `data/` parses. Spot-check links.

## Guardrails
- Match the Fabric theme tokens; do not invent a new palette or pull external assets.
- Respect trial limits: no Copilot/AI-dependent steps; 60-day F4/F64; OneDrive needed for uploads.
- Keep code snippets runnable against the sample data; call out any name the learner must match.
- Reference `workshops/ecommerce-medallion/` as the worked example when in doubt.
