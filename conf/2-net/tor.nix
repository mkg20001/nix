# 2-tor
# Enable tor
# docref: <nixpkgs/nixos/modules/services/networking/tor.nix>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    tor # onions
    obfs4 # onion hide tool
    nyx # and control panel
  ];

  # TODO: service
}
