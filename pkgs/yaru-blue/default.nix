{ stdenv
, fetchFromGitHub
, yaru-theme
}:

stdenv.mkDerivation rec {
  inherit (yaru-theme) src nativeBuildInputs buildInputs propagatedUserEnvPkgs postPatch meta version;

  pname = "yaru-blue";

  patches = [
    ./0001-feat-colors.patch
  ];
}
