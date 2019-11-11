{ lib, ... }:

with lib;

{
  services.sshd.enable = true;

  services.xserver = {
    enable = true;
  };
  
  networking.networkmanager.enable = true;
  networking.wireless.enable = mkForce false;
  powerManagement.enable = true;

  hardware.pulseaudio.enable = true;

  services.xserver.desktopManager.gnome3.enable = true;

  services.xserver.displayManager.slim.enable = mkForce false;
  
  imports =
    [
      <nixpkgs/nixos/modules/profiles/all-hardware.nix>
      <nixpkgs/nixos/modules/profiles/base.nix>
      <nixpkgs/nixos/modules/hardware/video/radeon.nix>
    ];
}

