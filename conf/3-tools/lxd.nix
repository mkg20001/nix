# 3-lxd
# Adds lxd

{ config, lib, pkgs, ... }:

with lib;

lib.mkIf config.flags.tools {
  imports = [];

  virtualisation.lxd.enable = true;

  users.users.maciej.extraGroups = [ "lxd" ];
}
