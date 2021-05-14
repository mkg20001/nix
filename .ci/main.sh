#!/bin/sh

set -euo pipefail

mkdir /root/.ssh
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
echo "$ID_RSA" > /root/.ssh/id_rsa
chmod 400 /root/.ssh/id_rsa
sed "s|sandbox = false|sandbox = true|g" -i /etc/nix/nix.conf

echo "https://nix.ssd-solar.dev/dev/solaros solaros" >> /root/.nix-channels
nix-channel --update -vv

sh .ci/setup-repo.sh
sh .ci/tag.sh

#bash .ci/rebuild.sh
bash .ci/rebase.sh

nix-build --option build-use-sandbox true -A iso -I nixpkgs=$PWD/../nixpkgs
cp -v result/iso/* mkg.iso

# nix copy --to file:///cache/store --all -v

if ! which sftp >/dev/null 2>/dev/null; then
  nix-env -iA nixpkgs.openssh
fi
(echo rm mkg.iso | sftp -o StrictHostKeyChecking=no -b /dev/stdin sftp://dpl@argon.mkg20001.io:13701/../../var/www/tmp) || /bin/true
echo put mkg.iso | sftp -o StrictHostKeyChecking=no -b /dev/stdin sftp://dpl@argon.mkg20001.io:13701/../../var/www/tmp
