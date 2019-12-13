# 3-overmind
# Adds overmind

{ config, lib, pkgs, ... }:

with lib;

mkIf config.flags.tools {
  environment.systemPackages = with pkgs; [
    overmind # Process manager for Procfile-based projects
  ];
}
