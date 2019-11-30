# 3-android
# Adds android tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    android-studio-stable
  ];
}
