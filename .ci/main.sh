#!/bin/sh

set -euo pipefail

mkdir /root/.ssh
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
echo "$ID_RSA" > /root/.ssh/id_rsa
chmod 400 /root/.ssh/id_rsa
sed "s|sandbox = false|sandbox = true|g" -i /etc/nix/nix.conf

sh .ci/setup-cache.sh
sh .ci/setup-repo.sh
sh .ci/tag.sh

bash .ci/rebuild.sh
bash .ci/rebase.sh

nix-build -A machines.iso -I nixpkgs=$PWD/../nixpkgs

# nix copy --to file:///cache/store --all -v
