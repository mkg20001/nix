#!/bin/bash

set -euo pipefail

FOLDER="$HOME/.jd2"
FILE="$FOLDER/JDownloader.jar"

ORIG_FILE="@out@/JDownloader.jar"

if [ ! -d "$FOLDER" ] || [ ! -e "$FILE" ]; then
  mkdir -p "$FOLDER"
  cp "$ORIG_FILE" "$FILE"
fi

chmod +w "$FILE"
cd "$FOLDER"
exec @java@ -jar "$FILE"
