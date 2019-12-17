# 3-auth-tools
# Adds auth tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    pass
    oathToolkit
  ];
}
