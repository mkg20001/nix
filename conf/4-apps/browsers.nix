# 4-browsers
# Adds browsers

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Add browsers
  environment.systemPackages = with pkgs; [
    firefox google-chrome
  ];
}
