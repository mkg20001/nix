pkgs:

with (pkgs.lib);

let
  nixNodePackage = builtins.fetchGit {
    url = "https://github.com/mkg20001/nix-node-package";
    rev = "1fc7a8cb64d35a1c37fc72820f86869dce1bfbb9";
  };
  makeNodeFnc = import "${nixNodePackage}/nix/default.nix" pkgs;

  extra = import ./extra.nix pkgs;

  makePkg = nodejs: { root, args ? {} }:
    makeNodeFnc { inherit root nodejs; build = false; }
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
