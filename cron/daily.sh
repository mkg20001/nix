#!/bin/bash

set -e

nix-channel --update
nixos-rebuild switch -v 2>&1 | grep -v evaluating
nix-collect-garbage
fstrim -av
