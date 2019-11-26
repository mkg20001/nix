#!/bin/bash

# TODO: possibly integrate into nix building flow?

list=$(find -mindepth 2 -iname "*.nix" | sort -V | tr "\n" " ")

echo "{
  imports = [ $list ];
}
" > merge.nix
