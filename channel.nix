# 1-channel
# Setup channel config
# docref: https://github.com/mkg20001/nixpkgs

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  nixpkgs.overlays = [
    (self: super: {
      nixpkgs = import ./nixpkgs.nix;
    })
  ];

  environment.systemPackages = with pkgs; [
    nixpkgs
  ];

  nix.nixPath = lib.mkDefault [
    "nixpkgs=/etc/nixpkgs"
    "nixos-config=/etc/nixos/configuration.nix"
  ];

  environment.etc.nixpkgs.source = "${pkgs.nixpkgs}/etc/nixpkgs";
}
