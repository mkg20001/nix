#!/usr/bin/env bash

STORE_PATH="$1"
OUT="$2"

set -euo pipefail

if [ -z "$OUT" ]; then
  echo "Usage: $0 <store-path> <out>" >&2
  echo "e.g: $0 /run/current-system current-system.png" >&2
  exit 2
fi

FMT=$(echo "$OUT" | sed -r "s|.+\\.([a-z0-9]+)|\1|g")

nix-store -q --graph "$STORE_PATH" | dot "-T$FMT" -o "$OUT"
