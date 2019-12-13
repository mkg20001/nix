# 4-disk-tools
# Adds disk tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    gparted
  ];
}
