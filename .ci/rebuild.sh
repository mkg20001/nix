#!/bin/sh

set -euo pipefail

nix -v -j auto build -f default.nix all -I nixpkgs=$PWD/../nixpkgs | cachix push mkg20001
nix build -A all default.nix -I nixpkgs=$PWD/../nixpkgs -v -j auto | cachix push mkg20001
pushd pkgs
nix -v -j auto build -f default.nix -I nixpkgs=$PWD/../nixpkgs | cachix push mkg20001
popd
