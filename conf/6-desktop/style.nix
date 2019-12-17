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
    yaru-blue # from overlay
  ];
  
  fonts.fonts = with pkgs; [
    cantarell-fonts
    dejavu_fonts
    source-code-pro # Default monospace font in 3.32
    source-sans-pro
    ubuntu_font_family
  ];
}
