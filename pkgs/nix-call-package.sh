#!/usr/bin/env bash

# Usage: $0 <package>

PKG="$1"

set -euo pipefail

if [ -z "$PKG" ]; then
  echo "Usage: $0 <package>" >&2
  exit 2
fi

EXPR="((import <nixpkgs> {}).callPackage $PKG {})"

shift
nix-build -j auto -E "$EXPR" "$@"
