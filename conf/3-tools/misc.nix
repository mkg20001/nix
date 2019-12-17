# 3-misc-tools
# Adds misc tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    redshift
  ];
}
