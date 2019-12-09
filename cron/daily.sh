#!/bin/bash

set -e

nix-channel --update
nixos-rebuild switch -v 2>&1 | grep -v evaluating

if [[ "$(hostname)" == "mkg-portable" ]]; then
  iso2boot "/boot" "/nix/store" "/zalman/_iso/iso2boot.iso"
fi

nix-collect-garbage
fstrim -av
