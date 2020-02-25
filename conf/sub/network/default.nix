{ config, lib, pkgs, ... }:

with lib;

let
  ports = [
    22000 # syncthing
    5060 5061 5062 # SIP
    30000 30001 30002 30003 30004 30005 # RTP (SIP)
          30006 30007 30008 30009 30010
  ];
in
{
  imports = [
    ./cjdns.nix
  ];

  services.teamviewer.enable = true;

  # Network manager ftw
  networking.networkmanager.enable = true;
  # TODO: do we need this?
  networking.wireless.enable = mkForce false;

  # Open ports in the firewall.
  # FW
  networking.firewall.allowedTCPPorts = ports;
  networking.firewall.allowedUDPPorts = ports;
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # sanity
    permitRootLogin = mkDefault "no";
    openFirewall = true;
    # security
    passwordAuthentication = false;
    # pubkey only
    challengeResponseAuthentication = true;
  };

  # keybase... fck'd my ram
  # services.keybase.enable = true;
  # services.kbfs.enable = true;

  # Enable tor
  # docref: <nixpkgs/nixos/modules/services/networking/tor.nix>
  # TODO: obfs4 tor service & move to seperate conf
  environment.systemPackages = with pkgs; [
    tor # onions
    obfs4 # onion hide tool
    nyx # and control panel

    keybase keybase-gui # bruh
  ];

  # Enable the yggdrasil daemon.
  # docref: <nixpkgs/nixos/modules/services/networking/yggdrasil.nix>
  # TODO: fixup
  services.yggdrasil.enable = true;
}
