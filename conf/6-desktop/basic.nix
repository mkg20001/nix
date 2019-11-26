# 6-basic
# Enables X11, Pulse & power managment
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

{
  imports = [];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "de";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable powerManagment
  powerManagement.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
