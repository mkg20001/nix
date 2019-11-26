# 3-lxd
# Adds lxd

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  virtualisation.lxd.enable = true;

  users.users.maciej.extraGroups = [ "lxd" ];
}
