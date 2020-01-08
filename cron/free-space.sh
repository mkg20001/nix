#!/bin/bash

GB=$((1024 * 1024))
GB5=$(($GB * 5))

is_running_full() {
  if [ $(df $1 --output=avail | tail -n 1) -lt $2 ]; then
    $3
  fi
}

is_running_full /nix/store $GB "nix-store --optimise -vv"
is_running_full /home $GB cron-clean-node-modules
is_running_full /nix/store $GB nix-collect-garbage
