# 4-ipfs
# Adds ipfs

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Add ipfs
  environment.systemPackages = with pkgs; [
    ipfs # IDE
  ];
}
