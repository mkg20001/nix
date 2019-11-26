# 2-yggdrasil
# Enable yggdrasil
# docref: TODO <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Enable the yggdrasil daemon.
  services.yggdrasil.enable = true;
}
