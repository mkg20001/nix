# config
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/virtualbox-image.nix>
    # <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "bootstrap" (builtins.readFile ../../bootstrap-vm.sh))
  ];

  users.users.maciej.password = "1234potato";

  # FIXME: UUID detection is currently broken
  boot.loader.grub.fsIdentifier = "provided";

  # Allow mounting of shared folders.
  users.users.maciej.extraGroups = [ "vboxsf" ];

  # Add some more video drivers to give X11 a shot at working in
  # VMware and QEMU.
  services.xserver.videoDrivers = mkOverride 40 [ "virtualbox" "vmware" "cirrus" "vesa" "modesetting" ];

  # Name the child
  networking.hostName = "mkg-vm";

  # Raise da flags
  # flags.highSpec = true;
  flags.tools = true;
  services.mongodb.enable = true;
}
