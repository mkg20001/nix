#!/bin/bash

nix-build -A all default.nix -I nixpkgs=$PWD/../nixpkgs -v -j auto | cachix push mkg20001
