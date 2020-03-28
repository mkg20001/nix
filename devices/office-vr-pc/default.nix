# PC config
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Name the child
  networking.hostName = "mkg-office-vr-pc";

  # Raise da flags
  flags.highSpec = true;
  flags.tools = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
