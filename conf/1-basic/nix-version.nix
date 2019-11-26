# 1-nix-version
# Define nix & nixOS version
# docref: TODO <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  # system.stateVersion = "19.09"; # Did you read the comment?
  system.stateVersion = "20.03"; # Did you read the comment?
}
