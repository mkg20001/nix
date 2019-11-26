# 3-docker
# Adds docker
# docref: https://nixos.wiki/wiki/Docker

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  virtualisation.docker.enable = true;

  users.users.maciej.extraGroups = [ "docker" ];
}
