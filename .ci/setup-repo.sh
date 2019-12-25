#!/bin/sh

set -euo pipefail

nix-env -iA nixpkgs.git nixpkgs.bash
if [ ! -e /cache/nixpkgs ]; then
  git clone https://github.com/mkg20001/nixpkgs /cache/nixpkgs -b mkg-patch
  ln -s /cache/nixpkgs ../nixpkgs
fi

git -C ../nixpkgs rebase --abort || true
git -C ../nixpkgs fetch origin
git -C ../nixpkgs checkout origin/mkg-patch
git -C ../nixpkgs reset --hard origin/mkg-patch
git -C ../nixpkgs clean -dxf

git config --global user.email "mkg20001@gmail.com"
git config --global user.name "Maciej Krüger"
