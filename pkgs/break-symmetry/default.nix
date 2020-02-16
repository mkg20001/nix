{ stdenv
,
}:

stdenv.mkDerivation {
  pname = "break-symmetry";
  version = "0.0.1";

  src = ./src;

  installPhase = ''
    chmod +x *.sh
    patchShebangs *.sh
    sed "s|. common.sh|source $out/lib/common.sh|g" -i *

    install -D bin.sh $out/bin/break-symmetry
    install -D hook.sh $out/libexec/break-symmetry-hook
    install -D common.sh $out/lib/common.sh
  '';
}
