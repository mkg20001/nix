# 2-cjdns
# Enable cjdns
# docref: TODO <nixpkgs/nixos/modules/services/networking/cjdns.nix>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Enable the cjdns daemon.
  services.cjdns = {
    enable = true;

    ETHInterface = {
      bind = "all";
      beacon = 2; # 0=off, 1=accept, 2=accept & send
      # connectTo = {};
    };

    UDPInterface = {
      bind = "0.0.0.0:12024";
      # connectTo = {}; # private config
    };
  };

  environment.systemPackages = with pkgs; [
    yrd
  ];
}
