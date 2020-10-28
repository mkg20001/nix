#!/bin/sh

set -euxo pipefail

USER=maciej

u() {
 su "$USER" -c "$*"
}

mv /etc/nixos /etc/nixos.bak || /bin/true
git clone https://github.com/mkg20001/nix /etc/nixos
cd /etc/nixos
bash install-channels.sh
cd /home

u git clone https://github.com/mkg20001/dotfiles /tmp/d
u mv -v /tmp/d/.git "/home/$USER/.git"
cd /home/$USER
u git reset --hard HEAD
u mkdir .p .atom
pushd .maint.d/sync
u npm i
popd

echo "----"
echo "run"
echo "bash /home/$USER/.bin/_dotfiles sync import"
echo "----"

