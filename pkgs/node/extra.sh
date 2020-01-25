#!/bin/bash

set -euo pipefail

# ndb

# yes... takes the lockfile, downloads pkg, gets rev
REV=$(curl -s $(cat pkgs/ndb/package-lock.json | jq -r ".dependencies[\"puppeteer-core\"].resolved") | tar xOz package/package.json | jq -r .puppeteer.chromium_revision)
URL="https://storage.googleapis.com/chromium-browser-snapshots/Linux_x64/$REV/chrome-linux.zip"

HASH=$(nix-prefetch-url "$URL")

echo '{
  "rev": "'"$REV"'",
  "url": "'"$URL"'",
  "hash": "'"$HASH"'"
}' > pkgs/ndb/chromium.json
