#!/bin/bash

set -e

GRUB_PC="@@GRUB@@"
GRUB_EFI="@@GEFI@@"

export PATH="@@XORRISO@@/bin:@@MTOOLS@@/bin:$PATH"

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
    findCopyAndReplace "$srcfile" "$file" "$store_dir" "$out_dir"
  done
}

main() {
  local boot_dir="$1"
  local store_dir_location="$2"
  local store_dir=0
  store_dir=$(dirname "$(dirname "$store_dir_location")")
  local outfile="$3"

  TMP=$(mktemp -d)

  mkdir -p "${TMP}/"{scratch,image}

  cat <<'EOF' >${TMP}/scratch/grub.cfg

search --set=root --file /iso2boot

insmod all_video

set default="0"
set timeout=30

EOF

  # NOTE: there are two drive searches, drive1 (boot) and drive2 (store). remove them, since we are already where we should be.
  cat "$boot_dir/grub/grub.cfg" | grep -v search | sed "s|\$drive1|\$root|" >> "${TMP}/scratch/grub.cfg"

  # copy all the boot files
  storeCopy "${TMP}/scratch/grub.cfg" "$store_dir" "${TMP}/image"

  GRAFT=(
    "boot/grub/grub.cfg=${TMP}/scratch/grub.cfg"
    "boot/grub/background.png=${boot_dir}/grub/background.png"
    "boot/grub/converted-font.pf2=${boot_dir}/grub/converted-font.pf2"
  )

  ${GRUB_EFI}/bin/grub-mkstandalone \
    --format=x86_64-efi \
    --output=${TMP}/scratch/bootx64.efi \
    --locales="" \
    --fonts="" \
    "${GRAFT[@]}"

  (cd ${TMP}/scratch && \
      dd if=/dev/zero of=efiboot.img bs=1M count=10 && \
      mkfs.vfat efiboot.img && \
      mmd -i efiboot.img efi efi/boot && \
      mcopy -i efiboot.img ./bootx64.efi ::efi/boot/
  )

  ${GRUB_PC}/bin/grub-mkstandalone \
      --format=i386-pc \
      --output=${TMP}/scratch/core.img \
      --install-modules="linux normal iso9660 biosdisk memdisk search tar ls font vbe gfxterm png test all_video" \
      --modules="linux normal iso9660 biosdisk search font vbe gfxterm png test all_video" \
      --locales="" \
      --fonts="" \
      "${GRAFT[@]}"

  cat \
      ${GRUB_PC}/lib/grub/i386-pc/cdboot.img \
      ${TMP}/scratch/core.img \
  > ${TMP}/scratch/bios.img

  xorriso \
      -as mkisofs \
      -iso-level 3 \
      -J -r \
      -full-iso9660-filenames \
      -volid "ISO2BOOT" \
      -eltorito-boot \
          boot/grub/bios.img \
          -no-emul-boot \
          -boot-load-size 4 \
          -boot-info-table \
          --eltorito-catalog boot/grub/boot.cat \
      --grub2-boot-info \
      --grub2-mbr ${GRUB_PC}/lib/grub/i386-pc/boot_hybrid.img \
      -eltorito-alt-boot \
          -e EFI/efiboot.img \
          -no-emul-boot \
      -append_partition 2 0xef ${TMP}/scratch/efiboot.img \
      -output "$outfile" \
      -graft-points \
          "${TMP}/image" \
          /boot/grub/bios.img=${TMP}/scratch/bios.img \
          /EFI/efiboot.img=${TMP}/scratch/efiboot.img
}

# main "$r/boot" "$r/nix/store" "$PWD/iso2boot.iso"
main "$@"
