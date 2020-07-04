{ stdenv
, fetchFromGitHub
, jdk
, makeWrapper
, makeDesktopItem
, imagemagick
}:

stdenv.mkDerivation {
  pname = "jdownloader";
  version = "someversion";

  src = ./.;

  buildInputs = [
    jdk
  ];

  nativeBuildInputs = [
    makeWrapper
    imagemagick
  ];

  desktopItem = makeDesktopItem {
    name = "jdownloader";
    exec = "@out@/bin/jdownloader";
    icon = "jdownloader";
    desktopName = "JDownloader";
    categories = "Application;Network;";
  };

  java = jdk;

  installPhase = ''
    mkdir $out/bin -p
    mv JDownloader.jar $out
    sed "s|@out@|$out|g" -i bin.sh
    sed "s|@out@|$out|g" -i bin.sh
    convert jd_logo_256_256.png -resize 128x128 128.png
    convert jd_logo_256_256.png -resize 64x64 64.png
    convert jd_logo_256_256.png -resize 48x48 48.png

    install -D $desktopItem/share/applications/jdownloader.desktop   $out/share/applications/jdownloader.desktop
    sed "s|@out@|$out|g" -i $out/share/applications/jdownloader.desktop
    install -D 48.png                                                $out/share/icons/hicolor/48x48/apps/jdownloader.png
    install -D 64.png                                                $out/share/icons/hicolor/64x64/apps/jdownloader.png
    install -D 128.png                                               $out/share/icons/hicolor/128x128/apps/jdownloader.png
    install -D jd_logo_256_256.png                                   $out/share/icons/hicolor/256x256/apps/jdownloader.png

    sed "s|@java@|$java/bin/java|g" -i bin.sh
    mv bin.sh $out/bin/jdownloader
  '';
}

