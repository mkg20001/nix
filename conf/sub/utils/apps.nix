# Adds misc tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

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
    gnome3.gnome-disk-utility

    # gnome
    gnome3.gedit # TODO: plugins
    gnome3.gnome-terminal
    evince
    gnome3.eog
    gnome3.gnome-todo
    gnome3.rhythmbox
    gnome3.nautilus
    gnome3.gnome-online-accounts
    # gnome3.gnome-disk-utility

    # graphics
    gimp
    mypaint
    inkscape
    shotwell
    # TODO: add rgbpaint

    # instant messaging
    tdesktop # telegram.org
    riot-desktop # riot.im

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
    trilium # for notes
    pick-colour-picker # color picker that saves picks
    pavucontrol # pulseaudio control
    (hiPrio qpaeq) # pulseaudio equalizer control

    vlc # player

    # voip
    teamspeak_client # ts3
    mumble
    zoom-us

    # work
    thunderbird # email client
    twinkle # twinkle SIP
    heimer
    # paperwork # openpaper.work burocrazy managment
  ];
}
