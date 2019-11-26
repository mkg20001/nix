# PC config
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

{
  imports = [];

  # Name the child
  networking.hostName = "mkg-pc";

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Use MBR
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdc";
}
