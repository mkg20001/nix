{ stdenv
, grub2_full
, xorriso
, ... }:
stdenv.mkDerivation {
  pname = "iso2boot";
  version = "0.0.1";

  src = ./iso2boot;

  buildInputs = [
    grub2_full
    xorriso
  ];

  installPhase = ''
    sed "s|@@GRUB@@|${grub2_full}|g" -i iso2boot.sh
    install -D iso2boot.sh $out/bin/iso2boot
    '';
}
