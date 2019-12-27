{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./cjdns.nix
  ];

  # Network manager ftw
  networking.networkmanager.enable = true;
  # TODO: do we need this?
  networking.wireless.enable = mkForce false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable tor
  # docref: <nixpkgs/nixos/modules/services/networking/tor.nix>
  # TODO: obfs4 tor service & move to seperate conf
  environment.systemPackages = with pkgs; [
    tor # onions
    obfs4 # onion hide tool
    nyx # and control panel
  ];

  # Enable the yggdrasil daemon.
  # docref: <nixpkgs/nixos/modules/services/networking/yggdrasil.nix>
  # TODO: fixup
  services.yggdrasil.enable = true;
}
