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
            rev = "0d0bf19e7650588a6a2ad0f319ea19cc479681d6";
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
    # npm-tools
  ];
}
