#!/bin/bash

set -e

mkdir etc
cd etc
git clone https://github.com/mkg20001/nix nixos
cd nixos
ln -s devices/$DEVICE device
T=$(mktemp -d)

echo 'nixos-install --root /mnt -I nixpkgs=/etc/nixpkgs' > "$T/nixos-rebuild"
chmod +x "$T/nixos-rebuild"

export PATH="$T:$PATH"

bash cron/daily.sh
