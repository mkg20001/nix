#!/bin/sh

set -euo pipefail

mkdir /root/.ssh
echo "$ID_RSA" > /root/.ssh/id_rsa

sh .ci/setup-cache.sh
sh .ci/setup-repo.sh

sh .ci/rebuild.sh
sh .ci/rebase.sh

nix copy --to file:///cache/store --all -v
