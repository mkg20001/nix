# 3-APP
# Adds TOOL

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    # htop: process monitor
    htop
    # nload/nethogs: network monitor
    nload nethogs
    # iotop: disk monitor
    iotop
    # wget/curl: HTTP
    wget curl
    # nano: editor
    nano
    # tree/ncdu: file analytics
    tree ncdu
    # glances: netdata for cli, basically
    python38Packages.glances
  ];
}
