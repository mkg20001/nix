# 4-ts3
# Adds teamspeak-client

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Add teamspeak-client
  environment.systemPackages = with pkgs; [
    teamspeak-client
  ];
}
