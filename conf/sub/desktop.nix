# 6-basic
# Enables X11, Pulse & power managment
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # GDM
  services.xserver.displayManager.gdm.enable = true;

  # Cinnamon
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.displayManager.defaultSession = "cinnamon";

  # Gnome bits
  services.gnome3.core-os-services.enable = true;
  services.gnome3.core-utilities.enable = true;

  # Style
  environment.systemPackages = with pkgs; [
    arc-theme
    ant-theme
    papirus-icon-theme
    breeze-icons
    breeze-gtk
    # TODO: add patched yaru & ant
    yaru-blue # from overlay
  ];

  fonts.fonts = with pkgs; [
    cantarell-fonts
    dejavu_fonts
    source-code-pro # Default monospace font in 3.32
    source-sans-pro
    ubuntu_font_family
    symbola
  ];

  # Night light
  /* services.redshift = {
    enable = true;

    temperature.day = 4000;
    temperature.night = 2000;

    brightness.night = "0.25";
    brightness.day = "0.5";
  }; */

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.extraConfig = ''
    load-module module-equalizer-sink
    load-module module-dbus-protocol
  '';

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "de";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable powerManagment
  powerManagement.enable = true;
  services.upower.enable = true;
  services.acpid.enable = true;
}