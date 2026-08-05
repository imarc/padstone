---
name: content-designer
description: Build or edit Padstone pages using the Content Designer matrix field (contentDesigner) and its block types. Trigger on "build a page", "add a section", "lay out this content", or any request that mentions Content Designer, sections, or its block names (Two Column, Rich Text, Media, Callout, Card, Logo Grid, Related Resources, Testimonial Slider, Shared Section).
---

# Content Designer

Padstone's page layout is a Matrix field, `contentDesigner`, on the `pages` section's page-building entry types. Its value is an ordered list of blocks; each block is its own entry type (Two Column Section, Rich Text, Media Section, ...). Building a page means picking the right block per piece of content, in order, and writing them through Craft MCP's entry tools.

## Procedure

1. **Get ground truth field shapes first.** Call `describe_entry_schema` for the target section + entry type (e.g. `pages` / `basicPage`) before writing anything. It expands `contentDesigner`'s block types into their actual sub-fields, live from the schema. This document only tells you *when* to reach for a block — never trust it for field names or shapes; if it and the schema call disagree, the schema call is right and this file is stale.
2. **Pick blocks by intent**, using the catalog below, one block per distinct piece of content.
3. **Build the payload** per Craft MCP's Matrix format (`craft://guides/content-writing` resource / `docs/content-writing.md`): blocks keyed `new1`, `new2`, ... in the `contentDesigner` field, each `{ type, fields }`.
4. **Write via `create_entry`/`update_entry`**, review the draft link, `publish_entry` when approved.

## Block catalog (top-level `contentDesigner` blocks)

### Two Column Section (`twoColumnSection`)

**Use when:** A section split into two side-by-side columns, each holding one piece of content — text, image, video, CTA, or testimonial.

**Intent:** Gives a claim visual support without a dedicated block for every combination — pair copy with an image, a quote with a stat, a CTA with a video. The generic workhorse for anything that isn't full-width.

**Notes:** Requires **exactly 2** sub-blocks, chosen from the column types below. Optional eyebrow/headline/subheadline + CTA link above the columns.

### Rich Text (`richText`)

**Use when:** A full-width, single-column block of rich text with an optional call-to-action link.

**Intent:** For explanation that needs no visual companion and shouldn't compete for width — an intro paragraph, policy text, context the reader needs before moving on.

**Notes:** Full-width rich text + optional CTA link. Distinct from `richTextNoMedia`, which is a *column* used inside Two Column, not a standalone block.

### Media Section (`mediaSection`)

**Use when:** A full-width block built around a single image or video, with an optional heading and CTA.

**Intent:** Gives one visual room to be looked at on its own, without sharing space or attention with adjacent copy — reach for it when the image or video itself is the point of the section, not supporting material next to it.

**Notes:** `mediaSubBlocks` holds **exactly 1** entry: `image` or `video`.

### Callout Section (`calloutSection`)

**Use when:** A banner-style, full-width prompt driving to one or two actions.

**Intent:** Highlights a next step that drives engagement — typically an action for visitors to take after reading relevant supporting material.

**Notes:** Headline + short no-media body + up to 2 CTA links (first renders solid, rest outline).

### Card Section (`cardSection`)

**Use when:** A grid of self-contained cards, each with its own image, headline, copy, and link.

**Intent:** Presents several parallel, comparably-weighted options at once — services, features, offerings — so a visitor can scan and pick the one relevant to them instead of reading linearly.

**Notes:** `cards` field holds any number of `imageCard` entries.

### Logo Grid (`logoGridSection`)

**Use when:** A grid of logo images with no per-logo copy.

**Intent:** Establishes credibility through association — who else trusts, uses, or partners with the business (clients, partners, integrations, press) — rather than making an explicit claim.

**Notes:** `logos` (image asset field) is required; no headline needed.

### Related Resources (`relatedResourcesSection`)

**Use when:** A list of related content, either hand-picked or auto-pulled by category.

**Intent:** Keeps visitors moving through the site after they finish the current page — offers a next thing to read related to what they just engaged with, reducing drop-off.

**Notes:** `cards` (labeled "Resources") is an optional manual override; if fewer than 3 are picked, it backfills from `resourceTypes` (a category filter) by newest. Prefer setting `resourceTypes` over hand-picking unless the exact set matters.

### Testimonial Slider (`testimonialSliderSection`)

**Use when:** One or more customer quotes, rendered as a static block with 1 slide or a carousel with more.

**Intent:** Builds trust through third-party validation — used where a claim lands better in someone else's voice than as the business's own assertion about itself.

**Notes:** `testimonialSlides` holds `testimonial` entries.

### Shared Section (`sharedSection`)

**Use when:** A relation to a block already built once in the Shared Blocks section.

**Intent:** Keeps a recurring piece of content (a promo, a shared CTA, a policy notice) consistent and centrally editable — update it once and it updates everywhere it's included, instead of duplicating and drifting.

**Notes:** Relation to an existing entry in the `sharedBlocks` section — don't rebuild content that already exists as a shared block; look it up first.

## Column types (used inside Two Column's `subBlocks`, exactly 2 required)

### Rich Text, No Media (`richTextNoMedia`)

**Use when:** The text half of a text+image/video/CTA pairing.

### Call to Action (`callToAction`)

**Use when:** A headline + short copy + button as one of the two columns — e.g. paired with an `image` column for a feature callout.

### Image (`image`)

**Use when:** A single image as one of the two columns.

### Video (`video`)

**Use when:** A YouTube-embed as one of the two columns.

### Testimonial (`testimonial`)

**Use when:** A single quote as one of the two columns.

## Card sub-type

`imageCard` — headline, image, content, CTA link. One card = one `imageCard` entry. Used by `cardSection`'s `cards` field and `relatedResourcesSection`'s `cards` field.

## Keeping this current

The block list here mirrors `config/project/fields/contentDesigner--*.yaml` (top-level blocks) and `config/project/fields/subBlocks--*.yaml` / `mediaSubBlocks--*.yaml` (column types). When a block type is added, removed, or renamed in the project config, update this catalog's **Use when**/**Notes** — never copy field shapes in here, that's what `describe_entry_schema` is for.
