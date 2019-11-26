# 2-ssh
# Enable OpenSSH
# docref: TODO <nixpkgs/..>

{ config, lib, pkgs, ... }:

{
  imports = [];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
