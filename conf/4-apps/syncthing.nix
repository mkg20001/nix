# 4-syncthing
# Adds syncthing

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Add syncthing
  environment.systemPackages = with pkgs; [
    syncthing
    syncthing-cli
    syncthing-discovery
    syncthing-tray
  ];

  # TODO: FW config
}
