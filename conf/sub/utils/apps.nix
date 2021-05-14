# Adds misc tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    # editors
    atom # the one and only
    bless # gtk# hex editor

    # browsers
    firefox
    firefox-devedition-bin
    torbrowser
    google-chrome

    # disk utils
    gparted
    gnome.gnome-disk-utility

    # gnome
    gnome.gedit # TODO: plugins
    gnome.gnome-terminal
    evince
    gnome.eog
    gnome.gnome-todo
    gnome.rhythmbox
    gnome.nautilus
    gnome.gnome-online-accounts
    # gnome.gnome-disk-utility

    # graphics
    gimp
    mypaint
    inkscape
    shotwell
    # TODO: add rgbpaint

    # instant messaging
    tdesktop # telegram.org
    element-desktop # riot.im

    # remote desktop
    anydesk
    remmina
    x2goclient

    # misc remote access
    filezilla

    # syncthing
    syncthing
    syncthing-cli
    syncthing-discovery
    syncthing-tray

    # utils
    trilium-desktop # for notes
    pick-colour-picker # color picker that saves picks
    pavucontrol # pulseaudio control
    (hiPrio qpaeq) # pulseaudio equalizer control
    jdownloader # the one and only
    flameshot # screenshot tool

    vlc # player

    # voip
    teamspeak_client # ts3
    mumble
    zoom-us

    # work
    thunderbird # email client
    #twinkle # twinkle SIP
    heimer
    # paperwork # openpaper.work burocrazy managment
  ];

  services.flatpak.enable = true;
}
