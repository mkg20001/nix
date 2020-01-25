pkgs:

with (pkgs.lib);

let
  ncd = (builtins.fromJSON (builtins.readFile ./pkgs/ndb/chromium.json));

  ndbChromium = with pkgs.xorg; with pkgs;
  let
    # from <nixpkgs/./pkgs/applications/networking/browsers/google-chrome/default.nix>

    pulseSupport = true;

    opusWithCustomModes = libopus.override {
      withCustomModes = true;
    };

    gtk = gtk3;
    gnome = gnome3;

    deps = [
      glib fontconfig freetype pango cairo libX11 libXi atk gnome2.GConf nss nspr
      libXcursor libXext libXfixes libXrender libXScrnSaver libXcomposite libxcb
      alsaLib libXdamage libXtst libXrandr expat cups
      dbus gdk-pixbuf gcc-unwrapped.lib
      systemd
      libexif
      liberation_ttf curl utillinux xdg_utils wget
      flac harfbuzz icu libpng opusWithCustomModes snappy speechd
      bzip2 libcap at-spi2-atk at-spi2-core
      kerberos
    ] ++ optional pulseSupport libpulseaudio
      ++ [ gtk ];

    # /end
  in
  stdenv.mkDerivation rec {
    name = "chromium4ndb";
    version = ncd.rev;

    # from <nixpkgs/./pkgs/applications/networking/browsers/google-chrome/default.nix>

    commandLineArgs = ""; # args which are always set

    rpath = makeLibraryPath deps + ":" + makeSearchPathOutput "lib" "lib64" deps;
    binpath = makeBinPath deps;

    # /end

    src = fetchurl {
      url = ncd.url;
      sha256 = ncd.hash;
    };

    nativeBuildInputs = [
      unzip
      makeWrapper
    ];

    installPhase = ''
      cp -rp $PWD $out

      for elf in $out/{chrome,chrome_sandbox,nacl_helper}; do
        patchelf --set-rpath $rpath $elf
        patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $elf
      done

      wrapProgram "$out/chrome" \
        --prefix LD_LIBRARY_PATH : "$rpath" \
        --prefix PATH            : "$binpath" \
        --prefix XDG_DATA_DIRS   : "$XDG_ICON_DIRS:$GSETTINGS_SCHEMAS_PATH" \
        --add-flags ${escapeShellArg commandLineArgs}
    '';
  };
in
{
  ndb = {
    # https://storage.googleapis.com/chromium-browser-snapshots/Linux_x64/624492/chrome-linux.zip

    buildInputs = [
      pkgs.makeWrapper
      ndbChromium

      pkgs.python3
    ];

    installPhase = ''
      # (this._downloadsFolder, this._platform + '-' + revision)
      # path.join(projectRoot, '.local-chromium')
      # __dirname, '.local-data'
      # __dirname == $out/node_modules/carlo/lib/

      OUT="$out/node_modules/carlo/lib/.local-data/linux-${ncd.rev}/chrome-linux"
      mkdir -p "$(dirname "$OUT")"
      ln -sv ${ndbChromium} "$OUT"
    '';

          /* sed "s|/usr/share/applications|${pkgs.chromium}/share/applications|g" -i ./node_modules/carlo/lib/find_chrome.js
          wrapProgram $out/node_modules/.bin/ndb \
            --prefix PATH : "${pkgs.chromium}/bin" \
            --set CHROME_PATH "${pkgs.chromium}/bin/chromium" */

  };
}
