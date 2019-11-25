#!/bin/bash

set -e

nix-channel --update
nixos-rebuild switch
nix-collect-garbage
fstrim -av
