# 3-docker
# Adds docker
# docref: https://nixos.wiki/wiki/Docker

{ config, lib, pkgs, ... }:

with lib;

lib.mkIf config.flags.tools {
  imports = [];

  virtualisation.docker.enable = true;

  users.users.maciej.extraGroups = [ "docker" ];
}
