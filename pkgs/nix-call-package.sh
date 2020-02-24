#!/usr/bin/env bash

EXPR="(import <nixpkgs> {}).callPackage $PATH {}"

nix-build -j auto -E "$EXPR" "$@"
