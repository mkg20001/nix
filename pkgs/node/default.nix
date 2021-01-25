pkgs:

with (pkgs.lib);

let
  nixNodePackage = builtins.fetchGit {
    url = "https://github.com/mkg20001/nix-node-package";
    rev = "6ece1177d0c0b8aca1a983744099235f4191d735";
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
in
  {
    inherit node15Pkgs node14Pkgs;

    mkNode = pkgs.callPackage "${nixNodePackage}/nix/default.nix" { };
    node_lts = pkgs.nodejs-14_x;
    node_lts_pkgs = node14Pkgs;
  } // node14Pkgs
