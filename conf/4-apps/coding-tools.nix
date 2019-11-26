# 4-coding-tools
# Adds coding tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    # TODO: bless hex editor - "bless"
  ];
}
