# 4-printer
# Adds my brother printer

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    brscan4 # sane support for brother
  ];
}
