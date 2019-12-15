# 5-import-npm-packages
# Imports npm packages

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  nixpkgs.overlays = [
    (self: super: {
      npm-tools =
        let
          nixNodePackage = builtins.fetchGit {
            url = "https://github.com/mkg20001/nix-node-package";
            rev = "898134fddca2e42a4ecdd6e386aac2869256f6d0";
          };
          makeNode = import "${nixNodePackage}/nix/default.nix" pkgs {
            root = ./.;
            nodejs = pkgs.nodejs-10_x;
            # production = false;
          };
        in
          makeNode {
            postPhases = "linkAllBins";

            linkAllBins = ''
              rm -vf $out/bin/*
              ln -s $out/node_modules/.bin/* $out/bin/
              '';
          };
    })
  ];

  environment.systemPackages = with pkgs; [
    npm-tools
  ];
}
