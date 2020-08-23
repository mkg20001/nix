#!/bin/sh

set -euo pipefail

LATEST_SHA=$(curl -s https://api.github.com/repos/mkg20001/nixpkgs/branches/mkg-patch-a | jq -r .commit.sha)
URL="https://github.com/mkg20001/nixpkgs/archive/$LATEST_SHA.tar.gz"
nix-channel --add "$URL" nixpkgs
