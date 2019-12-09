#!/bin/bash

set -e

findCopyAndReplace() {
  local src="$1"
  local file="$2"
  local store_dir="$3"
  local out_dir="$4"

  for path in $(cat "$src" | grep -o "/nix/store/.*/$file" | sort | uniq); do
    outname=$(echo "$path" | sed "s|/|_|g")
    cp -v "$store_dir$path" "$out_dir/$outname"
    sed "s|(.*$path|(\$root)/$outname|g" -i "$1"
  done
}

storeCopy() {
  local srcfile="$1"
  local store_dir="$2"
  local out_dir="$3"

  for file in bzImage initrd; do
    findAndReplace "$srcfile" "$file" "$store_dir" "$out_dir"
  done
}

main() {
  local boot_dir="$1"
  local store_dir="$2"
  local outfile="$3"

  TMP=$(mktemp -d)

  mkdir -p "${TMP}/{scratch,image}"

  cp "$boot_dir/grub/grub.cfg" "${TMP}/scratch/grub.cfg"

  storeCopy "${TMP}/scratch/grub.cfg" "$store_dir" "${TMP}/image"

  
}
