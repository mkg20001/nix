# 2-ssh
# Enable OpenSSH
# docref: TODO <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
