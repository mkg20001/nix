#!/bin/sh

set -euo pipefail

nix-build -A all default.nix -I nixpkgs=$PWD/../nixpkgs -v -j auto | cachix push mkg20001
pushd pkgs
nix-build default.nix -I nixpkgs=$PWD/../../nixpkgs -v -j auto | cachix push mkg20001
popd
