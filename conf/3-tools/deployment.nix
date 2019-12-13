# 3-APP
# Adds deployment tools

{ config, lib, pkgs, ... }:

with lib;

mkIf config.flags.tools {
  environment.systemPackages = with pkgs; [
    nixops
    terraform
  ];
}
