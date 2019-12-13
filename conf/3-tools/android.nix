# 3-android
# Adds android tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  config = lib.mkIf config.flags.highSpec {
    environment.systemPackages = with pkgs; [
      android-studio
      apktool
      fastlane
    ];

    virtualisation.anbox.enable = true;
  };
}
