# 3-APP
# Adds development tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    binutils # strings
    strace
  ];
}
