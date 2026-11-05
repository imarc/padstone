---
name: craft-assets
description: Find or upload images and files (Craft assets) for Padstone content — logos, card images, photos, video covers, testimonial headshots. Use whenever content needs an image that isn't already in the CMS, or when a Craft MCP payload needs an asset reference. Craft MCP can list assets but cannot upload; this skill uploads through Craft's GraphQL API.
---

# Craft Assets

Craft MCP can **find** assets (`list_volumes`, `list_asset_folders`, `list_assets`, `get_asset`) but has **no upload tool**. Upload through Craft's GraphQL API with a token, then reference the asset from MCP entry payloads.

## 1. Look before uploading

Call `list_assets` (filter by `volume`, `filename`, `kind: image`) — reuse an existing asset rather than uploading a duplicate. Volumes: `images` (general imagery, logos, headshots) and `resources` (downloadable files for Resources).

## 2. Upload

- Endpoint: `${PRIMARY_SITE_URL}actions/graphql/api` (no `/api` route is configured).
- Token: `GRAPHQL_TOKEN` in the project's `.env`. Read it from there; never print it or write it into files or payloads you show.
- Mutation per volume: `save_images_Asset`, `save_resources_Asset`. `_file` takes **either** `url` (server downloads it) **or** `fileData` (base64 data URI), plus `filename`. Set `title` and, on `images`, `altText`.

From a public URL:

```bash
TOKEN=$(grep '^GRAPHQL_TOKEN=' .env | cut -d= -f2- | tr -d '"')
curl -s "${PRIMARY_SITE_URL}actions/graphql/api" \
  -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/json' \
  -d '{"query":"mutation { save_images_Asset(_file: {url: \"https://example.com/photo.jpg\", filename: \"team-photo.jpg\"}, title: \"Team photo\", altText: \"The team outside the office\") { id filename url } }"}'
```

From a local file (base64 via a variable, so large files don't break shell quoting):

```bash
python3 - <<'EOF' > /tmp/upload.json
import base64, json, mimetypes, sys
path = 'logo.png'
mime = mimetypes.guess_type(path)[0] or 'application/octet-stream'
data = f"data:{mime};base64," + base64.b64encode(open(path, 'rb').read()).decode()
q = 'mutation($f: FileInput) { save_images_Asset(_file: $f, title: "Acme logo", altText: "Acme") { id filename url } }'
json.dump({'query': q, 'variables': {'f': {'fileData': data, 'filename': path}}}, sys.stdout)
EOF
curl -s "${PRIMARY_SITE_URL}actions/graphql/api" \
  -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/json' -d @/tmp/upload.json
```

The response returns the new asset's `id` and `filename`. Uploads land in the volume root; pass `newFolderId` (from `list_asset_folders`) to file it elsewhere. To replace a file's metadata later, call the same mutation with `id` and without `_file`.

## 3. Reference from Craft MCP

Asset fields in `create_entry`/`update_entry` take the asset's natural key — `{ "volume": "images", "filename": "team-photo.jpg" }` (add `"path": "sub/folder"` if not in the root). Confirm the exact shape with `describe_entry_schema`, which lists the input per field.

## Image guidance

- Logos: transparent PNG or SVG, tightly cropped; Logo Grid fits each into a ~230×120 box.
- Card and column images: landscape, at least 1200px wide.
- Headshots: square; shown as a small circle.
- Always set meaningful `altText` unless the image is purely decorative.
- Don't hotlink or upload images you don't have rights to use; placeholder services (e.g. placehold.co) are fine for drafts and demos.
