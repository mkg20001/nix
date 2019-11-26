# 3-nodejs
# Adds nodejs & yarn

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    nodejs-10_x
    yarn
  ];
}
