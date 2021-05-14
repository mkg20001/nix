#!/bin/sh

set -euo pipefail

mkdir -p /cache/store
echo "trusted-substituters = " >> /etc/nix/nix.conf

# nix-env -iA cachix -f https://cachix.org/api/v1/install
if ! which cachix >/dev/null 2>/dev/null; then
  nix-env -iA nixpkgs.cachix
fi
cachix use mkg20001

sed "s|substituters = |substituters = local?root=/cache/store file:///cache/store |g" -i /etc/nix/nix.conf
