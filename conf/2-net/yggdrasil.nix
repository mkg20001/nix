# 2-yggdrasil
# Enable yggdrasil
# docref: TODO <nixpkgs/nixos/modules/services/networking/yggdrasil.nix>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Enable the yggdrasil daemon.
  services.yggdrasil.enable = true;
}
