# This module contains the basic configuration for building a NixOS
# installation CD.

{ config, lib, pkgs, ... }:

with lib;

{
  imports =
    [ <nixpkgs/nixos/modules/installer/cd-dvd/iso-image.nix>
      <nixpkgs/nixos/modules/profiles/installation-device.nix>
      
      # System
      ./base.nix
    ];

  # ISO naming.
  isoImage.isoName = "${config.isoImage.isoBaseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.iso";

  isoImage.volumeID = substring 0 11 "MKGOS_ISO";

  # EFI booting
  isoImage.makeEfiBootable = true;

  # USB booting
  isoImage.makeUsbBootable = true;

  # Add Memtest86+ to the CD.
  boot.loader.grub.memtest86.enable = true;

  system.stateVersion = mkDefault "18.03";
}
