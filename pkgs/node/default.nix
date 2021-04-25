pkgs:

with (pkgs.lib);

let
  nixNodePackage = builtins.fetchGit {
    url = "https://github.com/mkg20001/nix-node-package";
    rev = "6981de863368a01b010ef26425a2140d202d900d";
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

  node14Pkgs = iterate pkgs.nodejs-14_x;
  node15Pkgs = iterate pkgs.nodejs-15_x;
  node16Pkgs = iterate pkgs.nodejs-16_x;
in
  {
    inherit node15Pkgs node14Pkgs;

    mkNode = makeNodeFnc;
    node_lts = pkgs.nodejs-16_x;
    node_lts_pkgs = node16Pkgs;
  } // node16Pkgs
