pkgs:

with (pkgs.lib);

let
  nixNodePackage = builtins.fetchGit {
    url = "https://github.com/mkg20001/nix-node-package";
    rev = "7035ea3b00e58f469193151c3fc7cae7ef7a1661";
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

  node12Pkgs = iterate pkgs.nodejs-12_x;
  node10Pkgs = iterate pkgs.nodejs-10_x;
in
  {
    inherit node12Pkgs node10Pkgs;
  } // node10Pkgs
