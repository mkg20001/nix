# 3-APP
# Adds netdata service
# docref: <nixpkgs/nixos/modules/services/monitoring/netdata.nix>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  services.netdata = {
    enable = true;
  };
}
