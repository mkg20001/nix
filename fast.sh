#!/bin/bash

set -e

if [ ! -z "$PR_NIXPKGS" ]; then
  NIXPKGS="/home/maciej/Projekte/nixpkgs"
fi

if [ -z "$NIXPKGS" ]; then
  NIXPKGS="/etc/nixpkgs"
fi

nixos-rebuild switch -I "nixpkgs=$NIXPKGS" -v --fast --show-trace "$@" 2>&1 | grep -v evaluating
