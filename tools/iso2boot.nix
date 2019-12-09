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
    replaceInPlace iso2boot.sh --replace "@@GRUB@@" "${grub2_full}"
    install -D iso2boot.sh $out/bin/iso2boot
    '';
}
