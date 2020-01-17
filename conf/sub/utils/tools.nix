# Adds misc tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    # auth
    pass
    oathToolkit

    # app util
    clipit

    # deploy
    nixops
    terraform

    # development
    binutils # strings
    strace
    python3
    gnumake # make
    nushell

    # node
    nodejs-10_x
    yarn

    # overmind
    overmind # Process manager for Procfile-based projects

    # git
    gitAndTools.gitFull
    gitAndTools.gitRemoteGcrypt
    git-lfs
    git-secrets
    git-sizer
    # gitAndTools.diff-so-fancy

    # pentesting tools
    wireshark # old but gold, sniffer
    mitmproxy # mitm
    ettercap # ARP/DHCP spoofing
    termshark # wireshark for the terminal
    nmap # address/service scanning
    dnsutils # provides dig dns tool

    # diagnostic tools
    inxi # inxi -v7: List ALL the specs INCLUDING software
    hwloc # lstopo: show a nice picture of the hardware configuration

    # night light
    redshift
    geoclue2

    # interplanetary (:P) tools
    ipfs # go-ipfs

    # misc
    xsel
    file
    macchanger

    tmux

    lm_sensors
    inetutils
    lxqt.pavucontrol-qt
    youtube-dl
    (hiPrio ntfs3g)

    # backup
    sshpass
    borgbackup

    # nixpkgs
    nixpkgs-fmt
    nixpkgs-review

    # fun
    lolcat
    cmatrix
  ] ++ builtins.attrValues(pkgs.node10Pkgs);

  services.geoclue2 = {
    enable = true;
    appConfig.redshift = {
      isAllowed = true;
      isSystem = false;
      users = [ "" ];
    };
  };
}
