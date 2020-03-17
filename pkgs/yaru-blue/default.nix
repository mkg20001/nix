{ stdenv
, fetchFromGitHub
, yaru-theme
, recreatePackage
}:

recreatePackage yaru-theme {
  pname = "yaru-blue";

  patches = [
    ./0001-feat-colors.patch
  ];
}
