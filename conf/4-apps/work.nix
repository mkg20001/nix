# 4-work
# Adds stuff I need for work comms

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    (thunderbird.override({ enableOfficialBranding = true; })) # email client
    twinkle # twinkle SIP
    # paperwork # openpaper.work burocrazy managment
  ];
}
