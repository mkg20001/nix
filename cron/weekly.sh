#!/bin/bash

set -e

nix-store --optimise -vv
fstrim -av
