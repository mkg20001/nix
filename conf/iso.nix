# This module contains the basic configuration for building a NixOS
# installation CD.

{ config, lib, pkgs, ... }:

with lib;

{
  imports =
    [ <nixos/modules/installer/cd-dvd/iso-image.nix>

      # Profiles of this basic installation CD.
      <nixos/modules/profiles/all-hardware.nix>
      <nixos/modules/profiles/base.nix>
      <nixos/modules/profiles/installation-device.nix>
      
      # System
      ./configuration.nix
    ];

  # ISO naming.
  isoImage.isoName = "${config.isoImage.isoBaseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.iso";

  isoImage.volumeID = substring 0 11 "NIXOS_ISO";

  # EFI booting
  isoImage.makeEfiBootable = true;

  # USB booting
  isoImage.makeUsbBootable = true;

  # Add Memtest86+ to the CD.
  boot.loader.grub.memtest86.enable = true;

  system.stateVersion = mkDefault "18.03";
}
