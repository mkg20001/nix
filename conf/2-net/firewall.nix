# 2-firewall
# Misc Firewall Config
# docref: TODO <nixpkgs/..>

{ config, lib, pkgs, ... }:

{
  imports = [];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
