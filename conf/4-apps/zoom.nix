# 4-zoom
# Adds Zoom.us

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Add app
  environment.systemPackages = with pkgs; [
    zoom-us
  ];
}
