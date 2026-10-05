---
name: fabric-workshop-updater
description: >
  Keep the ContosoMart workshop saga current with the official Microsoft docs. USE FOR:
  update the labs, refresh the workshops, what new Fabric/Foundry/Defender capabilities
  should we add, propose a new act, add a module to the saga, the docs changed — refresh
  the affected labs, update the deck/PPT for a new act. Scans Microsoft Learn (Fabric,
  Azure AI Foundry, Defender for AI), reports coverage gaps, proposes new acts that fit
  STORY.md, and — only after approval — builds the module (via fabric-workshop-builder)
  and rebuilds the ContosoMart-Journey + per-act prelab decks. DO NOT USE FOR: authoring
  a brand-new workshop from a user scenario (use fabric-workshop-builder directly),
  non-ContosoMart content, or generic web apps (use web-artifacts-builder).
---

# Fabric Workshop Updater

Refresh and extend the ContosoMart saga so it stays in lock-step with the official
Microsoft docs. This skill is the **research → propose → approve → build** orchestrator
that sits on top of [`fabric-workshop-builder`](../../SKILL.md): it decides *what* should
change, then reuses the builder to do the module authoring and the deck toolchain to
rebuild the slides.

Read these first — they are the contract and the narrative this skill must preserve:
- [`AUTHORING.md`](../../AUTHORING.md) — folder layout, 7-module arc, components, theme,
  grounding rules, and the canonical source tables (§6) this skill diffs against.
- [`STORY.md`](../../STORY.md) — the 13-act ContosoMart bible (personas, arc, story rules).
- [`SKILL.md`](../../SKILL.md) — `fabric-workshop-builder`, invoked to create each module.

## When to use
The user wants to "update the labs" / "refresh the workshops" / "add a new act" — i.e.
check the official docs for new capabilities (or changes to covered ones) and fold them
into the saga and the decks, rather than authoring an unrelated one-off workshop.

## Default behavior (confirm once at the start)
1. **Propose first, then build on approval** — never author or edit decks before the user
   approves the proposed acts/refreshes.
2. One capability → one act. New acts extend the saga and **must** carry the narrative
   (recap → what breaks → mission → outcome) in the ContosoMart voice.
3. Decks a new act touches: the new `<slug>-Prelab.pptx`, the master
   `ContosoMart-Journey.pptx`, and `Microsoft-Fabric-Deep-Dive.pptx` **only** if the act
   introduces a new *core Fabric* capability worth a product-education slide.

## Scope of the scan
Three doc families, keyed off the canonical bases already used in `AUTHORING.md` §6:

| Family | Canonical base | "What's new" signal (verify before use) |
| --- | --- | --- |
| Microsoft Fabric | `learn.microsoft.com/en-us/fabric/` | `fabric/fundamentals/whats-new` + `fabric/release-plan/` |
| Azure AI Foundry | `learn.microsoft.com/en-us/azure/foundry/` | `azure/foundry/whats-new` (confirm exact path) |
| Defender for AI | `learn.microsoft.com/en-us/defender-xdr/security-for-ai/` | `defender-xdr/whats-new` + the `security-for-ai/` index |

## Workflow

### Phase 1 — Research (read-only)
1. Establish the baseline: the 13 acts in [`STORY.md`](../../STORY.md) and the dated source
   tables in [`AUTHORING.md`](../../AUTHORING.md) §6 (Fabric / Foundry / Defender).
2. For each family, fetch the "What's new" / release-plan page **and** the relevant feature
   pages. Verify every URL resolves; capture the publish/update date.
3. Produce two sets:
   - **New capabilities** not covered by any existing act.
   - **Changed docs** for capabilities an existing act already teaches (feature renamed,
     GA'd out of preview, UI/steps changed, source moved, "Last fetched" now stale).
4. Do **not** invent features. If a page doesn't confirm a claim, drop it or mark `[verify]`.

### Phase 2 — Propose (gap report)
Present a single Markdown report with two sections.

**A. Proposed new acts** — one block each:
- Working title and `lowercase-kebab` slug.
- **Saga fit**: which Part (1 Fabric / 2 Foundry / 3 Defender), the proposed act number,
  and **insert vs append** (see Act-numbering below).
- **Narrative** in ContosoMart voice: recap of the prior act → what breaks now → the
  mission → the outcome that bridges to the next act. Name the personas it touches.
- Primary **workload/feature** and 2–4 dated Learn sources (Ref | Page | URL | date).
- A **sample-data sketch** (files + the deliberate quirks the silver layer will clean).
- Prerequisites / trial reality checks (free trial vs F2+ vs Defender XDR).
- **Decks affected** (always Journey + new prelab; Deep-Dive only if core Fabric).

**B. Stale-module refresh list** — table of `act | module | what changed | source(s) to
re-fetch | fields/steps to touch`.

Then **ask** which proposed acts to build and which stale modules to refresh. Stop here
until the user answers.

### Phase 3 — Build the approved acts (reuse the builder)
For each approved act:
1. **Append the act to [`STORY.md`](../../STORY.md)** — situation, what breaks, mission,
   what you fix, personas — consistent with the existing voice and the shared workspace
   (`ContosoMart-Analytics`) / lakehouse (`lh_contosomart`).
2. **Create the module** by following [`fabric-workshop-builder`](../../SKILL.md): produces
   `workshops/<slug>/{spec.md,index.html,README.md,data/}` on the 7-module arc, grounded in
   the dated sources, passing the §8 Definition of Done. Reuse `AUTHORING.md` §6 refs; add
   scenario-specific pages and verify them.
3. **Create the per-act prelab deck config** — copy
   [`../../../build/prelab/_template.deck.json`](../../../build/prelab/_template.deck.json)
   to `build/prelab/<slug>.deck.json` and fill every field from the new `spec.md`
   (sources, module map, prerequisites) and `STORY.md` (persona, situation, breaks,
   mission, outcome). No slide claim without a `spec.md`/`STORY.md` source. If an official
   diagram is used, place the PNG in `build/media/` and set `architecture.image`; otherwise
   leave it `""` to fall back to the flow diagram.
4. **Add the act to the master journey deck** — edit
   [`../../../build/prelab/contosomart-journey.deck.json`](../../../build/prelab/contosomart-journey.deck.json):
   append `{ n, title, workshop, breaks, fix }` to the correct `parts[].acts[]`, and bump
   every act-count string (`estTime`, `mapTitle` "…thirteen acts", `mandateSub`, any
   per-part `intro` count) to the new total.
5. **If a new core Fabric capability** — add/adjust the matching slide block in
   [`../../../build/build.js`](../../../build/build.js) and its row in
   [`../../../spec.md`](../../../spec.md); otherwise skip the Deep-Dive deck.
6. **Rebuild the affected decks** (see Build commands).
7. **Link the module from the hub** — add a module card/link in
   [`index.html`](../../index.html) under the correct Part, using the Part color
   (`--fab-*` / foundry / defender) already in that file.

### Phase 4 — Refresh approved stale modules
For each: update the affected module in `workshops/<slug>/index.html`, update the matching
row(s) in its `spec.md` Sources table, bump **Last fetched**, and — if the pre-lab framing
changed — update `build/prelab/<slug>.deck.json` and rebuild that prelab deck. If a change
also affects the Deep-Dive, update `build.js` + `spec.md` and rebuild it.

### Phase 5 — Verify (Definition of Done)
- Run the `AUTHORING.md` §8 checklist for every new/changed module; open each `index.html`
  in a browser (nav, progress persistence, copy, tabs, theme; clean console).
- Confirm every new/updated Learn URL resolves and is dated.
- Open the rebuilt decks: the new act appears in `ContosoMart-Journey.pptx`, the new
  `<slug>-Prelab.pptx` exists, and (if touched) `Microsoft-Fabric-Deep-Dive.pptx` reflects
  the change.
- Confirm the hub [`index.html`](../../index.html) lists and links the new module.

## Build commands (deck toolchain, run from `build/`)
```powershell
cd ../build    # the build/ folder sits beside workshop/ in the parent fabric/ folder
npm install    # first time only (pptxgenjs)
node prelab.js <slug>               # -> ../<slug>-Prelab.pptx
node prelab.js contosomart-journey  # -> ../ContosoMart-Journey.pptx
node build.js                       # -> ../Microsoft-Fabric-Deep-Dive.pptx (core Fabric only)
```

## Act-numbering rule
New **Fabric/Foundry** capabilities usually belong *inside* their Part and may renumber the
following acts (Part 1 = acts 1–7, Part 2 = 8–12, Part 3 = 13). New **Defender/edge**
topics usually **append** at the end. Always propose a position and get the user to confirm
**insert vs append** before renumbering `STORY.md` and the journey deck's `acts[]` + count
strings — renumbering is the main source of drift, so do it deliberately and in one pass.

## Guardrails
- **Propose before you build.** No `STORY.md`, module, or deck edits until the user approves.
- **Grounding is strict** (`AUTHORING.md` §5): every claim maps to a dated Learn link; fetch
  and verify each URL; no product claim without a source; flag preview features in `note`
  callouts.
- **Preserve the saga**: one company, one workspace, one lakehouse, consistent personas and
  voice (`STORY.md`). New acts recap and bridge; they don't restart the story.
- **Keep source-of-truth vs generated straight**: edit `spec.md`, `build.js`, the
  `*.deck.json` files and `STORY.md`; never hand-edit the generated `.pptx` files — rebuild.
- **Match the theme**: reuse the existing `--fab-*` tokens and Part colors; no new palette,
  no CDNs, no external assets.
- Respect trial limits (`AUTHORING.md` §7) and the Part 2/Part 3 prerequisite reality checks.
