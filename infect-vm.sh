#!/usr/bin/env bash

# 3 terminals with sudo bash
# gparted
# apt install htop && htop
# gparted format partitions

# setxkbmap <keyboard>

set -euxo pipefail

if [ ! -e /nix/.ro-store ]; then
  mkdir -p /nix/.ro-store
  mkdir -p /nix/.rw-store
fi

if [ ! -e /nix/.ro-store/nix-path-registration ]; then
  echo '$ mount $SQUASH /nix/.ro-store'
fi

mount -t tmpfs null -o mode=0755 /nix/.rw-store
mkdir -p /nix/store
mkdir -p /nix/.rw-store/work
mkdir -p /nix/.rw-store/store

mount overlay -t overlay -o lowerdir=/nix/.ro-store,upperdir=/nix/.rw-store/store,workdir=/nix/.rw-store/work /nix/store

nix-store --load-db < /nix/store/nix-path-registration

touch /etc/NIXOS

cd /nix/store
CMD=$(find -iname switch-to-configuration | sed "s|bin/switch-to-configuration|activate|g")
"$CMD"

# ln -sf devices/$1 device
# bash install-channels.sh
# nix-channel --update -vv
# nixos-install --root /os

echo '$ source /etc/profile'
echo 'for install:'
echo '$ bootstrap DEVICE ROOT'
