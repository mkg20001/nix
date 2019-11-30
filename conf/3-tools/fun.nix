# 3-fun
# Adds fun stuff

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    lolcat
  ];
}
