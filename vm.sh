#!/bin/bash

nix run vm -v -j auto -f $PWD/../nixpkgsv/nixos --arg configuration "$PWD"/vm.nix -c run-mkg-vm-vm
