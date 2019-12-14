# 4-coding-tools
# Adds coding tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    bless # gtk# hex editor
  ];
}
