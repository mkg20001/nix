# 4-gnome-tools
# Adds gnome tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    gnome3.gedit # TODO: plugins
    gnome3.gnome-terminal
    evince
    gnome3.eog
    gnome3.gnome-todo
    gnome3.rhythmbox
    gnome3.nautilus
    gnome3.gnome-disk-utility
  ];
}
