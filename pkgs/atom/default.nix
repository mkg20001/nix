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

WA_BIN="$ATOM_HOME/packages/wakatime/lib/wakatime-cli/wakatime-cli"
if [ -x "$WA_BIN" ]; then
  "${wakafix}/bin/wakafix" "$WA_BIN"
fi
  '';
in
stdenv.mkDerivation {
  inherit (atom) name version src nativeBuildInputs buildInputs buildCommand meta;

  preFixup = atom.preFixup + ''
    substituteInPlace $out/bin/atom --replace ${escapeShellArgs [snipStart snip]}
  '';
}
