# 4-remote-desktop
# Adds remote desktop clients

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    # BROKEN anydesk
    remmina
    x2goclient
  ];
}
