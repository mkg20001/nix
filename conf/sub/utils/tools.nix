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
    # nixops # TODO: re-enable after v2 mess
    terraform

    # development
    binutils # strings
    strace
    (python3.withPackages(ps: with ps; [ /* python-language-server */ ]))
    gnumake # make
    # nushell
    rustup

    # node
    node_lts # nodejs-12_x
    yarn

    # overmind
    overmind # Process manager for Procfile-based projects
    # pueue # for long-running tasks

    # git
    gitAndTools.gitFull
    gitAndTools.gitRemoteGcrypt
    git-lfs
    git-secrets
    git-sizer
    # gitAndTools.diff-so-fancy

    # pentesting tools
    # wireshark # old but gold, sniffer
    # mitmproxy # mitm
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
    screen
    pueue
    nix-call-package
    nix-edit-package
    nix-visualize
    jdk

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
      isSystem = true;
      users = [ "maciej" ];
    };
  };

  location.provider = "geoclue2";

  users.users.maciej.extraGroups = [ "wireshark" ];
  programs.wireshark.enable = true;

  # Adds netdata service
  # docref: <nixpkgs/nixos/modules/services/monitoring/netdata.nix>
  services.netdata.enable = true;

  services.netdata.config.global = {
    "OOM score" = 0;
    "error log" = "syslog";
  };
}
