#!/bin/sh

set -euo pipefail

sh .ci/setup-cache.sh
sh .ci/setup-repo.sh

sh .ci/rebuild.sh
sh .ci/rebase.sh

nix copy --to file:///cache/store --all -v
