#!/bin/bash

. common.sh

shopt -s nullglob

if [ -d "$ORIG_ROOT" ]; then
  for f in "$ORIG_ROOT/"*; do
    ENCODED=$(basename "$f")
    ORIG_PATH=$(urldecode "$ENCODED")

    echo "[break-symmetry] Restoring $ORIG_PATH..."
    mv "$ORIG_PATH" "$EDITED_ROOT/$ENCODED.$(date +%s)"
    mv "$f" "$ORIG_PATH"
  done
fi
