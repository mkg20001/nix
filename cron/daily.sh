#!/bin/bash

set -eu
set -o pipefail

nixpkgs_need_update() {
  CURRENT_SHA=$(cat /nixpkgs.sha; true)
  LATEST_SHA=$(curl -s https://api.github.com/repos/mkg20001/nixpkgs/branches/mkg-patch | jq -r .commit.sha)

  if [ ! -e /nixpkgs ]; then
    return 0
  fi

  if [ "$CURRENT_SHA" != "$LATEST_SHA" ]; then
    return 0
  fi

  return 1
}

nixpkgs_update() {
  URL="https://github.com/mkg20001/nixpkgs/archive/mkg-patch.tar.gz"
  SHA=$(nix-prefetch-url --unpack "$URL")

  nix-build --out-link /nixpkgs -E '(builtins.fetchTarball {
    name = "mkg-patched-nixpkgs"
    url = "'"$URL"'";
    sha256 = "'"$SHA"'";
  })'

  echo "$LATEST_SHA" > /nixpkgs.sha
}

nix-channel --update

if nixpkgs_need_update; then
  nixpkgs_update
fi

nixos-rebuild switch -v 2>&1 | grep -v evaluating

if [[ "$(hostname)" == "mkg-portable" ]]; then
  iso2boot "/boot" "/nix/store" "/zalman/_iso/iso2boot.iso"
fi

nix-collect-garbage
fstrim -av
