# 3-android
# Adds android tools

{ config, lib, pkgs, ... }:

with lib;

lib.mkIf config.flags.highSpec {
  imports = [];

  environment.systemPackages = with pkgs; [
    android-studio
    apktool
    fastlane
  ];

  virtualisation.anbox.enable = true;
}
