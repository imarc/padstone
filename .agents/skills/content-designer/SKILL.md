---
name: content-designer
description: Build or edit Padstone pages using the Content Designer matrix field (contentDesigner) and its block types. Trigger on "build a page", "add a section", "lay out this content", or any request that mentions Content Designer, sections, or its block names (Two Column, Rich Text, Media, Callout, Card, Logo Grid, Related Resources, Testimonial Slider, Shared Section).
---

# Content Designer

Padstone's page layout is a Matrix field, `contentDesigner`, on the `pages` section's page-building entry types. Its value is an ordered list of blocks; each block is its own entry type (Two Column Section, Rich Text, Media Section, ...). Building a page means picking the right block per piece of content, in order, and writing them through Craft MCP's entry tools.

## Procedure

1. **Get ground truth field shapes first.** Call `describe_entry_schema` for the target section + entry type (e.g. `pages` / `contentDesignerPage`) before writing anything. It expands `contentDesigner`'s block types into their actual sub-fields, live from the schema. This document only tells you *when* to reach for a block — never trust it for field names or shapes; if it and the schema call disagree, the schema call is right and this file is stale.
2. **Pick blocks by visual**, using the quick picker, then the catalog for details. One block per distinct piece of content.
3. **Build the payload** per Craft MCP's Matrix format (`craft://guides/content-writing` resource / `docs/content-writing.md`): blocks keyed `new1`, `new2`, ... in the `contentDesigner` field, each `{ type, fields }`. [`kitchen-sink.json`](kitchen-sink.json) is a working `create_entry` payload using every block and column type — copy block shapes from it rather than composing them from scratch.
4. **Images:** reuse existing assets (`list_assets`) or upload new ones with the `craft-assets` skill, then reference them as `{ "volume": "images", "filename": "..." }`.
5. **Write via `create_entry`/`update_entry`**, review the draft link, `publish_entry` when approved. Sending `contentDesigner` through `update_entry` replaces the whole field — include every block you want to keep, or edit one block by passing its own id.

**Visual reference:** the `/kitchen-sink` page renders every block and column variant, each headed with its block name. Open it (or `describe_entry_schema … example=kitchen-sink`) when unsure what a block looks like or how its payload is shaped.

## Quick picker

| Visual you want | Block |
|---|---|
| Paragraphs of copy, full width (may include inline images) | Rich Text |
| Copy beside an image / video / quote / button | Two Column Section |
| Two text columns side by side | Two Column Section (2× Rich Text, No Media) |
| One big image or video, full width | Media Section |
| Centered headline + blurb + 1–2 buttons (end-of-page ask) | Callout Section |
| Grid of 3-across cards (image on top, title, blurb) | Card Section |
| Row of client / partner logos | Logo Grid |
| "Read next" row of 3 articles/resources | Related Resources |
| One featured customer quote, full width | Testimonial Slider with 1 slide |
| Carousel of several quotes | Testimonial Slider with 2+ slides |
| Quote beside a photo | Two Column Section (Testimonial + Image) |
| Same section reused on many pages | Shared Section |

Every block except Shared Section has the same heading fields: optional **eyebrow** (small accent-colored label), **headline**, and plain-text **subheadline**. Items inside blocks (cards) use their **title** instead. Most blocks render these left-aligned above the content, plus an optional **CTA link** as a primary button underneath (Callout and Testimonial Slider lay them out their own way; see below). **Background** (`Default` white or `Accent` = brand-color full-bleed band, white text) is only offered on Two Column, Rich Text, Media Section and Callout — don't combine Accent with an eyebrow, which is accent-colored and disappears.

Links (`ctaLink`, card links) show their **label** as the button/link text; if the label is blank it falls back to the bare URL or the linked entry's title, so set a label for URL links.

## Block catalog (top-level `contentDesigner` blocks)

### Two Column Section (`twoColumnSection`)

```
 EYEBROW
 Headline
 ┌──────────────────┐  ┌──────────────────┐
 │ column 1         │  │ column 2         │
 └──────────────────┘  └──────────────────┘
 [ CTA ]
```

**Use when:** Two pieces of content should sit side by side at equal (50/50) width — copy + image, copy + video, copy + button, quote + photo, text + text.

**Intent:** Gives a claim visual support without a dedicated block for every combination. The generic workhorse for anything that isn't full-width.

**Notes:** Requires **exactly 2** column sub-blocks (see Column types). CMS order = left-to-right order; columns stack on mobile. Supports Background.

### Rich Text (`richText`)

```
 EYEBROW
 Headline
 ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
 ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
 [ CTA ]
```

**Use when:** A full-width, single-column run of copy — intro, explanation, policy text. The rich text editor accepts inline images, so a long article-style section with a picture mid-flow fits here too.

**Intent:** Explanation that needs no visual companion and shouldn't compete for width.

**Notes:** Supports Background (Accent makes a strong brand-color text band). Distinct from `richTextNoMedia`, which is a *column* used inside Two Column.

### Media Section (`mediaSection`)

```
 Headline
 ┌──────────────────────────────────────┐
 │            image (full width)        │
 └──────────────────────────────────────┘
```

**Use when:** One image should span the full content width, or one video should stand alone.

**Intent:** Gives one visual room to be looked at on its own — reach for it when the image or video *is* the point of the section.

**Notes:** Holds **exactly 1** `image` or `video`. Image renders edge-to-edge of the container at natural aspect ratio (tall images get very tall). Supports Background.

### Callout Section (`calloutSection`)

```
             EYEBROW
         Centered Headline
     short centered blurb text
      [ Solid ]   ( Outline )
```

**Use when:** A centered, narrow banner-style prompt driving to one or two actions — typically near the end of a page.

**Intent:** Highlights a next step after the reader has seen supporting material.

**Notes:** Eyebrow / headline / subheadline + short plain body + up to 2 links (first solid button, second outline). Everything centered in ~half the page width. Supports Background. No bottom CTA-link chrome — the buttons are the content.

### Card Section (`cardSection`)

```
 Headline
 ┌────────┐ ┌────────┐ ┌────────┐
 │ image  │ │ Title  │ │ Title  │
 │ Title  │ │ blurb  │ │ blurb  │
 │ blurb  │ └────────┘ └────────┘
 └────────┘
```

**Use when:** Several parallel, comparably-weighted items — services, features, offerings — shown as white shadowed cards, **3 per row** (wraps for more).

**Intent:** Lets a visitor scan and pick the one relevant option instead of reading linearly.

**Notes:** `cards` holds `imageCard` entries (title, optional image, blurb, link). Image sits on top of the card; cards without an image are just title + blurb and are shorter, so mixed rows look ragged — give all cards images or none. A card link renders as an arrow text link at the bottom of the card. **A card linked to an entry fills any blank title, image or blurb from that entry** (title, featured image, abstract) — to feature existing pages/resources, just set the link. Optional section CTA link renders below the grid. No Background option.

### Logo Grid (`logoGridSection`)

```
 Headline
      [logo]   [logo]   [logo]   [logo]
            [logo]   [logo]
```

**Use when:** A set of client / partner / press logos with no per-logo copy.

**Intent:** Credibility through association rather than an explicit claim.

**Notes:** `logos` asset field is required; headline optional. Logos render in centered, wrapping rows, each scaled to fit a ~230×120px box — works with any logo aspect ratio. No Background option.

### Related Resources (`relatedResourcesSection`)

```
 Headline
 ┌────────┐ ┌────────┐ ┌────────┐
 │ image? │ │ Title  │ │ Title  │
 │ Title  │ │ abstr. │ │ abstr. │
 │ abstr. │ └────────┘ └────────┘
 └────────┘
```

**Use when:** A "keep reading" row of up to 3 related resources/articles, same card styling as Card Section.

**Intent:** Keeps visitors moving after the current page, reducing drop-off.

**Notes:** Always capped at 3 cards. Manually picked `cards` (labeled "Resources") come first; remaining slots backfill from `resourceTypes` (category filter), newest first, showing entry title + abstract (+ featured image if set). Prefer `resourceTypes` unless the exact set matters. Standard eyebrow / headline / subheadline; no CTA link or Background.

### Testimonial Slider (`testimonialSliderSection`)

1 slide:
```
 EYEBROW
 Headline
 subheadline
      “ Quote text spanning most of the width…
        (o) Name
            Job title
```
2+ slides:
```
 ❝                    ┌──────────────────┐
 EYEBROW              │ quote…   (fades) │
 Headline             │ Name / title     │
 subheadline          │                  │
                      └──────────────────┘
                      (<)              (>)
```

**Use when:** Customer quotes in their own full-width section — 1 slide for a single featured quote, 2+ for a carousel.

**Intent:** Third-party validation where a claim lands better in someone else's voice.

**Notes:** Eyebrow / headline / subheadline; no CTA or Background. With 1 slide, the heading sits above a large indented quote. With 2+, a big accent quote mark and the heading sit in a left column; slides scroll on the right with prev/next arrows. Headshot shows as a small circle beside the name when provided.

### Shared Section (`sharedSection`)

**Use when:** Content already built once in the Shared Blocks section should appear here.

**Intent:** Keeps recurring content (a promo, shared CTA, policy notice) consistent and centrally editable.

**Notes:** Relation to one or more `sharedBlocks` entries. Each shared block has its own `contentDesigner`, whose blocks render inline here exactly as if placed on the page — visually seamless. Look up existing shared blocks before rebuilding content.

## Column types (Two Column's `subBlocks`, exactly 2) and Media Section's single item

### Rich Text, No Media (`richTextNoMedia`)

**Use when:** The text half of a pairing, or both halves of a two-text-column layout. Plain rich text, no images.

### Call to Action (`callToAction`)

**Use when:** A short line of copy with a solid button beneath it, as one column. **Has no headline of its own** — the section headline is the only heading.

### Image (`image`)

**Use when:** A single image filling its column width.

### Video (`video`)

**Use when:** A YouTube video as one column (or as Media Section's single item). Paste a normal YouTube link (`watch?v=`, `youtu.be`, `shorts`); it's converted to an embed. Shows a cover image with a play button: the optional `image` if set, otherwise YouTube's own thumbnail — so only upload a cover when the thumbnail isn't good enough.

### Testimonial (`testimonial`)

**Use when:** A single quote as one column — accent quote mark, quote text, name + job title, optional circular headshot. Pair with an Image column for a "photo + quote" row.

## Card sub-type

`imageCard` — title (optional), image, blurb, link. One card = one `imageCard` entry. Used by `cardSection`'s `cards` and `relatedResourcesSection`'s `cards`. In both, a card linked to an entry uses its own title/image/blurb when set and falls back to the entry's title/featured image/abstract when blank.

## Rendering caveats

- **Eyebrow on Accent background is invisible** (accent-colored text on the accent band). Skip the eyebrow when using Accent.
- **Related Resources backfill** only counts entries in the `resources` section tagged with the chosen `resourceTypes`; if fewer exist, the row shows fewer than 3 cards.

## Keeping this current

The block list here mirrors `config/project/fields/contentDesigner--*.yaml` (top-level blocks) and `config/project/fields/subBlocks--*.yaml` / `mediaSubBlocks--*.yaml` (column types); visual descriptions mirror `templates/_blocks/` and `templates/_columns/`. When a block type or its template changes, update this catalog's **Use when**/**Notes**, ASCII sketches and caveats — never copy field shapes in here, that's what `describe_entry_schema` is for.
