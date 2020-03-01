{ stdenv
, atom
, callPackage
}:

with stdenv.lib;

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
stdenv.mkDerivation {
  inherit (atom) name version src nativeBuildInputs buildInputs buildCommand meta;

  preFixup = atom.preFixup + ''
    substituteInPlace $out/bin/atom --replace ${escapeShellArgs [snipStart snip]}
  '';
}
