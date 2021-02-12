# PC config
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Name the child
  networking.hostName = "mkg-work";

  # Raise da flags
  flags.tools = true;

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Use MBR
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xinput}/bin/xinput disable 'SynPS/2 Synaptics TouchPad'
  '';
}
