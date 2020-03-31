# PC config
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Name the child
  networking.hostName = "mkg-razer";

  # Raise da flags
  flags.highSpec = true;
  flags.tools = true;

  # services.xserver.videoDrivers = [ "nvidia" ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      version = 2;
    };
  };
}
