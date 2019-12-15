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
            rev = "da66d39148c360c4959f42fe10521f2a19395984";
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
