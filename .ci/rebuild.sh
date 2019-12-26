#!/bin/sh

set -euo pipefail

nix -v -j auto build -f default.nix all -I nixpkgs=$PWD/../nixpkgs --extra-substituters file:///cache/store | cachix push mkg20001
pushd pkgs
nix -v -j auto build -f default.nix -I nixpkgs=$PWD/../nixpkgs --extra-substituters file:///cache/store | cachix push mkg20001
popd
