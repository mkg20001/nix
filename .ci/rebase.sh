#!/bin/sh

set -euo pipefail

# todo: if
git -C ../nixpkgs remote add upstream https://github.com/nixos/nixpkgs || true

git -C ../nixpkgs fetch upstream
git -C ../nixpkgs checkout origin/mkg-patch-a
git -C ../nixpkgs reset --hard origin/mkg-patch
git -C ../nixpkgs rebase upstream/master
git -C ../nixpkgs branch -D mkg-patch-a
git -C ../nixpkgs checkout -b mkg-patch-a

bash .ci/rebuild.sh

# if success

git -C ../nixpkgs push -f origin mkg-patch-a
