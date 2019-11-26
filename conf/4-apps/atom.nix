# 4-atom
# Adds atom

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Add atom
  environment.systemPackages = with pkgs; [
    atom # IDE
  ];
}
