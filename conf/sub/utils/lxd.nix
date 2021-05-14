# 3-lxd
# Adds lxd

{ config, lib, pkgs, ... }:

with lib;

lib.mkIf config.flags.tools {
  virtualisation.lxd.enable = true;

  systemd.services.lxcfs = {
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/true";
    };
  };

  users.users.maciej.extraGroups = [ "lxd" ];
}
