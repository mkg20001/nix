#!/bin/sh

set -euo pipefail

nix-build -j 6 -A vme
