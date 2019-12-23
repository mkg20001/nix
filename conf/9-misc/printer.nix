# 4-printer
# Adds my brother printer

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  hardware.sane.brscan4 = {
    enable = true;
    netDevices = {
      /*
      name = {
        ip = "";
        model = ""; # ex MFC-XXXX
      };
      */
    };
  };
}
