pkgs:

with (pkgs.lib);

let
  nixNodePackage = builtins.fetchGit {
    url = "https://github.com/mkg20001/nix-node-package";
    rev = "2b7a5d1dff02ca7f95e651c60476f17c720a3e72";
  };
  makeNodeFnc = import "${nixNodePackage}/nix/default.nix" pkgs;

  extra = import ./extra.nix pkgs;

  makePkg = nodejs: { root, args ? {} }:
    makeNodeFnc { inherit root nodejs; }
    ({
      postPhases = [ "linkAllBins" ];

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
      builtins.listToAttrs (forEach pkgLocks ({ name, version, root }:
        (pkgs.lib.nameValuePair name (pkg {
          inherit root;

          args = {
            name = "${name}-${version}";
          } // (
            if hasAttrByPath [ name ] extra then extra.${name}
            else {}
          );
        }))
      ));

  node13Pkgs = iterate pkgs.nodejs-13_x;
  node12Pkgs = iterate pkgs.nodejs-12_x;
  node10Pkgs = iterate pkgs.nodejs-10_x;
in
  {
    inherit node13Pkgs node12Pkgs node10Pkgs;

    node_lts = pkgs.nodejs-12_x;
  } // node12Pkgs
