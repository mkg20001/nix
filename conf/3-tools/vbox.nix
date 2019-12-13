# 3-APP
# Adds vbox tools tools

{ config, lib, pkgs, ... }:

with lib;

mkIf config.flags.highSpec {
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  environment.systemPackages = with pkgs; [
    packer
    vagrant
  ];
}
