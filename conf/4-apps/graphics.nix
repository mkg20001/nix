# 4-graphics
# Adds graphics tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Add graphics tools
  environment.systemPackages = with pkgs; [
    gimp
    mypaint
    inkscape
    shotwell
    # TODO: add rgbpaint
  ];
}
