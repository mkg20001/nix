{ stdenv
, makeWrapper
, patchelf
, lib

, name
, deps
}:

with lib;

stdenv.mkDerivation {
  inherit name;

  dontUnpack = true;

  rpath = makeLibraryPath deps + ":" + makeSearchPathOutput "lib" "lib64" deps;
  binpath = makeBinPath deps;

  nativeBuildInputs = [
    makeWrapper
  ];

  buildInputs = [
    patchelf
  ];

  installPhase = ''
    mkdir -p $out/bin/
    echo "
      elf=\"\$1\"
      if [ -z \"\$elf\" ]; then
        echo \"Usage: ${name} <binary>\" >&2
        exit 2
      fi

      export PATH="${patchelf}/bin:$PATH"

      set -euo pipefail

      #wrapProgram \"\$elf\" \
      #--prefix LD_LIBRARY_PATH : '$rpath' \
      #--prefix PATH            : '$binpath'

      patchelf --set-rpath '$rpath' \"\$elf\"
      patchelf --set-interpreter '$(cat $NIX_CC/nix-support/dynamic-linker)' \"\$elf\"
    " > $out/bin/${name}
    chmod +x $out/bin/${name}
  '';
}
