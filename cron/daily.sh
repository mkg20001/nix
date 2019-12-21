#!/bin/bash

set -eu
set -o pipefail

nixpkgs_need_update() {
  CURRENT_SHA=$(cat /etc/nixpkgs/sha; true)
  LATEST_SHA=$(curl -s https://api.github.com/repos/mkg20001/nixpkgs/branches/mkg-patch | jq -r .commit.sha)

  if [ ! -e /etc/nixpkgs ]; then
    return 0
  fi

  if [ "$CURRENT_SHA" != "$LATEST_SHA" ]; then
    return 0
  fi

  return 1
}

nixpkgs_update() {
  URL="https://github.com/mkg20001/nixpkgs/archive/$LATEST_SHA.tar.gz"
  SHA=$(nix-prefetch-url --unpack "$URL")

  # TODO: also include this in nix conf, possibly link as /etc/nixpkgs ?

  echo 'with (import <nixpkgs> {});
  stdenv.mkDerivation {
    pname = "nixpkgs-mkg-patched";
    version = "mkg-patch";

    src = builtins.fetchTarball {
      name = "mkg-patched-nixpkgs";
      url = "'"$URL"'";
      sha256 = "'"$SHA"'";
    };

    installPhase = "mkdir -p $out/etc && cp -r $PWD $out/etc/nixpkgs && echo '"$LATEST_SHA"' > $out/etc/nixpkgs/sha";
  }' > nixpkgs.nix

  nix-build --out-link /tmp/nixpkgs nixpkgs.nix
  rm -fv /etc/nixpkgs
  ln -sfv /tmp/nixpkgs/etc/nixpkgs /etc/nixpkgs
}

nix-channel --update

# TODO: once the future arrives, we could just do `nixpkgs=https://github.com/mkg20001/nixpkgs/archive/$LATEST_SHA.tar.gz`

if nixpkgs_need_update; then
  nixpkgs_update
fi

nixos-rebuild switch -I nixpkgs=/etc/nixpkgs -j auto -v 2>&1 | grep -v evaluating

if [[ "$(hostname)" == "mkg-portable" ]]; then
  iso2boot "/boot" "/nix/store" "/zalman/_iso/iso2boot.iso"
fi

nix-collect-garbage --delete-older-than 30d
fstrim -av
