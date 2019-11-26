# 6-gdm
# Enables GDM3 (TODO: and customizes the theme)
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # GDM
  services.xserver.displayManager.gdm3.enable = true;
}
