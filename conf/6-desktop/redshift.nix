# 6-redshift
# Setup redshift

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  services.redshift = {
    enable = true;

    temperature.day = 4000;
    temperature.night = 2000;

    brightness.night = "0.25";
    brightness.day = "0.5";
  };
}
