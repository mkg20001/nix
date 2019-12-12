# PC config
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Name the child
  networking.hostName = "mkg-pc";

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Use MBR
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdc";

  # Bleeeeddd.... xD
  nix.nixPath = [
    "nixpkgs=/home/maciej/cinnamon"
    "nixos-config=/etc/nixos/configuration.nix"
  ];
}
