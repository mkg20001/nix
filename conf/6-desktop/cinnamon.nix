# 6-cinnamon
# Enable cinnamon
# docref: TODO <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Cinnamon
  services.xserver.desktopManager.cinnamon.enable = true;
}
