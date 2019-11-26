# 4-remote-access
# Adds remote access tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    filezilla
  ];
}
