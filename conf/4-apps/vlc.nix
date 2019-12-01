# 4-vlc
# Adds vlc

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Add vlc
  environment.systemPackages = with pkgs; [
    vlc # player
  ];
}
