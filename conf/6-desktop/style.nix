# 6-style
# Adds themes and icons
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    arc-theme
    ant-theme
    papirus-icon-theme
    breeze-icons
    breeze-gtk
    # TODO: add patched yaru & ant
    (import ../../pkgs/yaru-blue.nix pkgs)
  ];
}
