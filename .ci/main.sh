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

if ! which sftp >/dev/null 2>/dev/null; then
  nix-env -iA nixpkgs.openssh
fi

nix-build --option build-use-sandbox true -A iso -I nixpkgs=$PWD/../nixpkgs
cp -v result/iso/* mkg.iso
(echo rm mkg.iso | sftp -o StrictHostKeyChecking=no -b /dev/stdin sftp://dpl@argon.mkg20001.io:13701/../../var/www/tmp) || true
echo put mkg.iso | sftp -o StrictHostKeyChecking=no -b /dev/stdin sftp://dpl@argon.mkg20001.io:13701/../../var/www/tmp

nix-build --option build-use-sandbox true -A vme -I nixpkgs=$PWD/../nixpkgs
cp -v result/*.ova mkg.ova
(echo rm mkg.ova | sftp -o StrictHostKeyChecking=no -b /dev/stdin sftp://dpl@argon.mkg20001.io:13701/../../var/www/tmp) || true
echo put mkg.ova | sftp -o StrictHostKeyChecking=no -b /dev/stdin sftp://dpl@argon.mkg20001.io:13701/../../var/www/tmp

# nix copy --to file:///cache/store --all -v

