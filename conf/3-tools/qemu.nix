# 3-qemu
# Adds qemu
# docref: <nixpkgs/pkgs/applications/virtualization/qemu/default.nix>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  virtualisation.qemu.enable = true;

  # TODO: needed?
  users.users.maciej.extraGroups = [ "qemu" "kvm" ];
}
