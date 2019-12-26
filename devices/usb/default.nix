# Portable config
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

{
  imports = [
    ../portable-hardware-configuration.nix
  ];

  # Name the child
  networking.hostName = "mkg-usb";

  # Raise da flags
  flags.portable = true;

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Write cache
  boot.kernel.sysctl = {
    "vm.dirty_background_ratio" = 50;
    "vm.dirty_ratio" = 80;
  };

  # Use MBR
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/disk/by-id/usb-_Patriot_Memory_07019AEEAA008348-0:0";

  fileSystems."/" =
    { device = "/dev/disk/by-label/nix-usb";
      fsType = "ext4";
    };
}
