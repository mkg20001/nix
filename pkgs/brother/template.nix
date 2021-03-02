{ pkgsi686Linux
, stdenv
, fetchurl
, dpkg
, makeWrapper
, coreutils
, ghostscript
, gnugrep
, gnused
, which
, perl
, lib
}:

{ model
, version
, src
}:

let
  reldir = "opt/brother/Printers/${model}/";

in rec {
  driver = pkgsi686Linux.stdenv.mkDerivation rec {
    inherit src version;
    pname = "${model}drv";

    nativeBuildInputs = [ dpkg makeWrapper ];

    unpackPhase = "dpkg-deb -x $src $out";

    installPhase = ''
      ls
      dir="$out/${reldir}"
      substituteInPlace $dir/lpd/filter_${model} \
        --replace /usr/bin/perl ${perl}/bin/perl \
        --replace "BR_PRT_PATH =~" "BR_PRT_PATH = \"$dir\"; #" \
        --replace "PRINTER =~" "PRINTER = \"${model}\"; #"
      wrapProgram $dir/lpd/filter_${model} \
        --prefix PATH : ${lib.makeBinPath [
          coreutils ghostscript gnugrep gnused which
        ]}
      # need to use i686 glibc here, these are 32bit proprietary binaries
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        $dir/lpd/br${model}filter || true
    '';

    meta = {
      description = "Brother ${lib.strings.toUpper model} driver";
      homepage = http://www.brother.com/;
      license = lib.licenses.unfree;
      platforms = [ "x86_64-linux" "i686-linux" ];
      maintainers = [ lib.maintainers.steveej ];
    };
  };

  cupswrapper = stdenv.mkDerivation rec {
    inherit src version;
    pname = "${model}cupswrapper";

    nativeBuildInputs = [ dpkg makeWrapper ];

    unpackPhase = "dpkg-deb -x $src $out";

    installPhase = ''
      basedir=${driver}/${reldir}
      dir=$out/${reldir}
      substituteInPlace $dir/cupswrapper/brother_lpdwrapper_${model} \
        --replace /usr/bin/perl ${perl}/bin/perl \
        --replace "basedir =~" "basedir = \"$basedir\"; #" \
        --replace "PRINTER =~" "PRINTER = \"${model}\"; #"
      wrapProgram $dir/cupswrapper/brother_lpdwrapper_${model} \
        --prefix PATH : ${lib.makeBinPath [ coreutils gnugrep gnused ]}
      mkdir -p $out/lib/cups/filter
      mkdir -p $out/share/cups/model
      ln $dir/cupswrapper/brother_lpdwrapper_${model} $out/lib/cups/filter
      ln $dir/cupswrapper/brother_${model}_printer_en.ppd $out/share/cups/model
    '';

    meta = {
      description = "Brother ${lib.strings.toUpper model} CUPS wrapper driver";
      homepage = http://www.brother.com/;
      license = lib.licenses.gpl2;
      platforms = [ "x86_64-linux" "i686-linux" ];
      maintainers = [ lib.maintainers.steveej ];
    };
  };
}
