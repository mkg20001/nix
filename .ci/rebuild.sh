#!/bin/sh

set -euo pipefail

nix -v -j auto build -f default.nix all -I nixpkgs=$PWD/../nixpkgs --extra-substituters file:///cache/store?trusted=1 --trusted-substituters file:///cache/store?trusted=1
nix-build -A all -I nixpkgs=$PWD/../nixpkgs | cachix push mkg20001
pushd pkgs
nix -v -j auto build -f default.nix -I nixpkgs=$PWD/../../nixpkgs --extra-substituters file:///cache/store?trusted=1 --trusted-substituters file:///cache/store?trusted=1
nix-build -I nixpkgs=$PWD/../../nixpkgs | cachix push mkg20001
popd
