# 6-gdm
# Enables GDM3 (TODO: and customizes the theme)
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # GDM
  services.xserver.displayManager.gdm.enable = true;
  # No wayland
  services.xserver.displayManager.gdm.wayland = false;
}
