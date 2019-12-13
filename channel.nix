# 1-channel
# Setup channel config
# docref: https://github.com/mkg20001/nixpkgs

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  nix.nixPath = lib.mkDefault [
    "nixpkgs=/nixpkgs"
    "nixos-config=/etc/nixos/configuration.nix"
  ];
}
