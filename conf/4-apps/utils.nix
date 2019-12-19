# 4-utils
# Adds utils I need (misc)

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    trilium # for notes
    pick-colour-picker # color picker that saves picks
    pavucontrol # pulseaudio control
  ];
}
