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

  echo "{ name = \"$OUT_NAME\"; root = ./$OUT_NAME; }" >> "$PKGS/default.nix"
}

rm -rf "$PKGS"
mkdir "$PKGS"

echo "[" >> "$PKGS/default.nix"

gen_pkg nodemon nodemon

echo "]" >> "$PKGS/default.nix"
