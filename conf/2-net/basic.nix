# 2-net
# Networking setup
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  networking.networkmanager.enable = true;
  # TODO: do we need this?
  networking.wireless.enable = mkForce false;
}
