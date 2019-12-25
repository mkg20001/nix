#!/bin/bash

set -euo pipefail

PKGS="$PWD/pkgs"

gen_pkg() {
  OUT_NAME="$1"
  shift

  OUT="$PKGS/$OUT_NAME"
  mkdir "$OUT"
  pushd "$OUT"

  echo '{
    "name": "stub",
    "version": "0.0.1",
    "description": "Stub Package",
    "main": "index.js",
    "license": "MIT"
  }' > package.json

  echo "*" > .npmignore

  npm i --package-lock-only $*

  VERSION=$(cat package.json | jq -r ".dependencies[\"$OUT_NAME\"]" | sed "s|^.||g")

  echo "  { name = \"$OUT_NAME\"; version = \"$VERSION\"; root = ./$OUT_NAME; }" >> "$PKGS/default.nix"

  popd
}

rm -rf "$PKGS"
mkdir "$PKGS"

echo "[" >> "$PKGS/default.nix"

. pkgs.sh

echo "]" >> "$PKGS/default.nix"
