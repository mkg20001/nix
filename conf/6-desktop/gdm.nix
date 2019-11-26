# 6-gdm
# Enables GDM3 (TODO: and customizes the theme)
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

{
  imports = [];

  # GDM
  services.xserver.displayManager.gdm3.enable = true;
}
