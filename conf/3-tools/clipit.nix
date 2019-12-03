# 3-clipit
# Adds clipit

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    clipit
  ];
}
