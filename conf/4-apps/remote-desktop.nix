# 4-remote-desktop
# Adds remote desktop clients

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    # anydesk upstream issue
    remmina
    x2goclient
  ];
}
