#!/bin/bash

FILE="$1"

if [ -z "$FILE" ]; then
  echo "Usage: $0 <file>" >&2
  exit 2
fi

. common.sh

mkdir -p "$EDITED_ROOT"
mkdir -p "$ORIG_ROOT"

REAL_PATH=$(readlink -f "$FILE")
FILE_PATH="$FILE" # TODO: realpath without resolving symlinks

if [[ "$REAL_PATH" != "/nix/store/"* ]]; then
  echo "Not a store path, not doing anything" >&2
else
  ORIG_PATH="$ORIG_ROOT/$(urlencode "$FILE_PATH")"
  mv "$FILE_PATH" "$ORIG_PATH"
  cp -L "$ORIG_PATH" "$FILE_PATH"
  echo "Copied!" >&2
fi
