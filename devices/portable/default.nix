# Portable config
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Name the child
  networking.hostName = "mkg-portable";

  flags.portable = true;

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Use MBR
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/disk/by-id/usb-ZALMAN_ZM-VE350_WXT1EC0HDWX8-0:1";

  fileSystems."/zalman" =
    { device = "/dev/disk/by-label/zalman";
      fsType = "ntfs";
    };
}
