# 4im
# Adds instant messanging apps

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    tdesktop
    riot-desktop
  ];
}
