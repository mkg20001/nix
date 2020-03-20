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

# tmp
nix-store --realise /nix/store/43ak31a4saxl8cjilrxv0l3jad3qipvf-nix-2.4pre7307_c1f1e6f.drv | cachix push mkg20001

#bash .ci/rebuild.sh
bash .ci/rebase.sh

nix-build -A iso -I nixpkgs=$PWD/../nixpkgs
cp -v result/iso/* mkg.iso

# nix copy --to file:///cache/store --all -v

nix-env -iA nixpkgs.openssh
(echo rm mkg.iso | sftp -o StrictHostKeyChecking=no -b /dev/stdin sftp://dpl@argon.mkg20001.io:13701/../../var/www/tmp) || /bin/true
echo put mkg.iso | sftp -o StrictHostKeyChecking=no -b /dev/stdin sftp://dpl@argon.mkg20001.io:13701/../../var/www/tmp
