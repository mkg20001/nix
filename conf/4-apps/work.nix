# 4-work
# Adds stuff I need for work comms

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    thunderbird
    # TODO: twinkle SIP "twinkle"
  ];
}