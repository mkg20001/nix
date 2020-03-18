#!/usr/bin/env bash

# Usage: $0 <package>

PKG="$1"

set -euo pipefail

if [ -z "$PKG" ]; then
  echo "Usage: $0 <package>" >&2
  exit 2
fi

CONF="$HOME/.config/nix-edit-package"

if [ -e "$CONF" ]; then
  source "$CONF"
fi

if [ -d pkgs ]; then
  NIXPKGS_ROOT="$PWD"
elif [ -z "$NIXPKGS_ROOT" ]; then
  echo "No nixpkgs root found" >&2
  exit 1
fi

cd "$NIXPKGS_ROOT/pkgs"

BASE=$(find -iname "$PKG")

if [ -e "$BASE/default.nix" ]; then
  ${EDITOR:"nano"} "$BASE/default.nix"
else
  # TODO: EDITOR=echo, turn ro into writable path
  if [ -e "$NIXPKGS_ROOT/pkgs/default.nix" ]; then
    nix edit -f "$NIXPKGS_ROOT/pkgs" "$PKG"
  else
    nix edit -f "$NIXPKGS_ROOT" "$PKG"
  fi
fi
