# 3-qemu
# Adds qemu
# docref: <nixpkgs/pkgs/applications/virtualization/qemu/default.nix>
# docref_m: https://nixos.wiki/wiki/Virtualization_in_NixOS

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    qemu
  ];

  # TODO: needed?
  users.users.maciej.extraGroups = [ "qemu" "kvm" ];
}
