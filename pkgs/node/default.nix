pkgs:

with (pkgs.lib);

let
  nixNodePackage = builtins.fetchGit {
    url = "https://github.com/mkg20001/nix-node-package";
    rev = "898134fddca2e42a4ecdd6e386aac2869256f6d0";
  };
  makeNodeFnc = import "${nixNodePackage}/nix/default.nix" pkgs;

  makePkg = nodejs: { root, args ? {} }:
    (makeNodeFnc {
      inherit root nodejs;
      production = true;
    }) ({
      postPhases = "linkAllBins";

      linkAllBins = ''
        rm -vf $out/bin/*
        ln -s $out/node_modules/.bin/* $out/bin/
        '';
    } // args);

  pkgLocks = import ./pkgs;

  iterate = nodejs:
    let
      pkg = makePkg nodejs;
    in
      builtins.listToAttrs (forEach pkgLocks ({ name, root }:
        (pkgs.lib.nameValuePair name (pkg {
          inherit root;
          args = {
            inherit name;
          };
        }))
      ));

  node12Pkgs = iterate pkgs.nodejs-12_x;
  node10Pkgs = iterate pkgs.nodejs-10_x;
in
  {
    inherit node12Pkgs node10Pkgs;
  } // node10Pkgs
