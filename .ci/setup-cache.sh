#!/bin/sh

set -euo pipefail

mkdir -p /cache/store
echo "trusted-substituters = " >> /etc/nix/nix.conf

nix-env -iA cachix -f https://cachix.org/api/v1/install
cachix use mkg20001

sed "s|substituters = |substituters = local?root=/cache/store file:///cache/store >> /etc/nix/nix.conf|g" -i /etc/nix/nix.conf
