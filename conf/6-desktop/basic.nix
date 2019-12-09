# 6-basic
# Enables X11, Pulse & power managment
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

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

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
