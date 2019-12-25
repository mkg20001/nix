#!/bin/sh

bash .ci/setup-cache.sh
bash .ci/setup-repo.sh

bash .ci/rebuild.sh
bash .ci/rebase.sh

nix copy --to file:///cache/store --all -v
