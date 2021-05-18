#!/bin/bash

set -euo pipefail

DEVICE="$1"
ROOT="$2"

mkdir -p etc
cd etc
if [ ! -e nixos ]; then
  git clone https://github.com/mkg20001/nix nixos
fi
cd nixos
ln -s "devices/$DEVICE" device

bash install-channels.sh
nix-channel --update -vv

nixos-generate-config --root "$ROOT"

nixos-install --root "$ROOT"
