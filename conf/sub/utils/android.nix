# 3-android
# Adds android tools

{ config, lib, pkgs, ... }:

with lib;

mkIf config.flags.highSpec {
  environment.systemPackages = with pkgs; [
    android-studio
    # apktool
    fastlane
  ];

  virtualisation.anbox.enable = true;

  programs.adb.enable = true;
  users.users.maciej.extraGroups = ["adbusers"];
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
