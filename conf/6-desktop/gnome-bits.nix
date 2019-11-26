# 6-gnome-bits
# Add gnome bits and pieces like GOA
# docref: <nixpkgs/nixos/modules/services/x11/desktop-managers/gnome3.nix>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  config.services.gnome3.core-os-services.enable = true;
  config.services.gnome3.core-utilities.enable = true;
}
