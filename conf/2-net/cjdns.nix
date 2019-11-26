# 2-cjdns
# Enable cjdns
# docref: TODO <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Enable the cjdns daemon.
  services.cjdns.enable = true;
}
