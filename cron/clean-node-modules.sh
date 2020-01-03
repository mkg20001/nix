#!/bin/bash

set -eo pipefail

if [ -z "$1" ]; then
  CMD=$(readlink -f "$0")

  find /home -iname node_modules -mtime +14 -prune -exec bash $CMD {} \;
else
  if [ -z "$(echo "$1" | tr "/" "
" | grep "^\\.")" ]; then
    echo " -- RM $1 -- " >&2
    rm -rf "$1"
  else
    echo "keep $1"
  fi
fi
