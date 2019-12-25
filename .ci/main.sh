#!/bin/sh

set -euo pipefail

mkdir /root/.ssh
echo "$ID_RSA" > /root/.ssh/id_rsa

sh .ci/setup-cache.sh
sh .ci/setup-repo.sh

bash .ci/rebuild.sh
bash .ci/rebase.sh

nix copy --to file:///cache/store --all -v
