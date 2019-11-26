# 3-tmux
# Adds tmux

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    tmux
  ];
}
