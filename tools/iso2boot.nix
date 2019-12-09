{ stdenv
, grub2_full
, grub2_efi
, xorriso
, mtools
, makeWrapper
, ... }:
stdenv.mkDerivation {
  pname = "iso2boot";
  version = "0.0.1";

  src = ./iso2boot;

  buildInputs = [
    grub2_full
    grub2_efi
    xorriso
    mtools # mmd
  ];

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    sed "s|@@GEFI@@|${grub2_efi}|g" -i iso2boot.sh
    sed "s|@@GRUB@@|${grub2_full}|g" -i iso2boot.sh
    install -D iso2boot.sh $out/iso2boot
    wrapProgram $out/iso2boot $out/bin/iso2boot
    '';
}
