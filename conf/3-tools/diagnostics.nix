# 3-APP
# Adds diagnostics tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # inxi -v7: List ALL the specs INCLUDING software
  # lstopo: show a nice picture of the hardware configuration
  environment.systemPackages = with pkgs; [
    inxi
    hwloc
  ];
}
