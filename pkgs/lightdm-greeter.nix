{ stdenv
, fetchFromGitHub
, pkgconfig
, gtk3
, glib
, lightdm
, gobject-introspection
, lib
, ... }:

stdenv.mkDerivation {
  pname = "lightdm-tiny-greeter";
  version = "1.2";

  src = fetchFromGitHub {
    owner = "off-world";
    repo = pname;
    rev = version;
    sha256 = "08azpj7b5qgac9bgi1xvd6qy6x2nb7iapa0v40ggr3d1fabyhrg6";
  };

  patches = [
    ./0001-fix-prefix.patch
  ];

  postPatch = ''
    echo ${lib.escapeShellArg (builtins.readFile ./config.h)} > ./config.h
    '';

  buildInputs = [
    glib
    gtk3
    lightdm
  ];

  nativeBuildInputs = [
    pkgconfig
    gobject-introspection
  ];
}
