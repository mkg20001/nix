# 4-voice
# Adds VoIP apps

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    teamspeak_client
    mumble
    zoom-us
  ];
}
