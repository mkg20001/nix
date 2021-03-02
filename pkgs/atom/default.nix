{ stdenv
, atom
, callPackage
, recreatePackage
, lib
}:

with lib;

let
  wakafix = callPackage ./wakafix.nix {};

  snipStart = ''mkdir -p "$ATOM_HOME"'';
  snip = ''
${snipStart}

WA_DIR="$ATOM_HOME/packages/wakatime/lib"
WA_LIB="$WA_DIR/wakatime.coffee"
WA_BIN="$WA_DIR/wakatime-cli/wakatime-cli"

if [ -x "$WA_BIN" ]; then
  "${wakafix}/bin/wakafix" "$WA_BIN"
  sed "s|currentVersion = stderr.trim()|currentVersion = stdout.trim()|g" -i "$WA_LIB"
fi
  '';
in
recreatePackage atom {
  preFixup = atom.preFixup + ''
    substituteInPlace $out/bin/atom --replace ${escapeShellArgs [snipStart snip]}
  '';
}
