#!/bin/bash

set -e

nixos-rebuild switch -I nixpkgs=/etc/nixpkgs -v --fast 2>&1 | grep -v evaluating
