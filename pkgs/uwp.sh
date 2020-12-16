#!/bin/sh

set -euo pipefail

OUT_FOLDER="/var/uwp"

mkdir -p "$OUT_FOLDER"

URL=$(curl -s https://universal-bypass.org/install | grep -o "https://github.com/Sainan/Universal-Bypass/releases/download/[0-9.]*/Universal.Bypass.for.Chromium-based.browsers.zip")

if [ -e "$OUT_FOLDER/ver" ] && [[ "$(cat "$OUT_FOLDER/ver")" == "$URL" ]]; then
  echo up-to-date
  exit 0
fi

TMP=$(mktemp --suffix=.zip)

wget "$URL" -O "$TMP"

cd "$OUT_FOLDER"
rm -rf ext
mkdir ext
cd ext
unzip "$TMP"
rm "$TMP"

echo "$URL" > "$OUT_FOLDER/ver"
