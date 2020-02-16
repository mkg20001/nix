# Enable cjdns
# docref: <nixpkgs/nixos/modules/services/networking/cjdns.nix>

{ config, lib, pkgs, ... }:

with (import ../../util.nix lib);

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
      connectTo = loadPriv "cjdns_nodes.toml";
    };
  };

  # TODO: fw

  environment.systemPackages = with pkgs; [
    yrd
  ];
}
