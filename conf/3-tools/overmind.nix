# 3-overmind
# Adds overmind

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    overmind # Process manager for Procfile-based projects
  ];
}
