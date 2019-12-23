# 3-misc-tools
# Adds misc tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    redshift
    xsel
    geoclue2
    file
    macchanger
    qpaeq
  ];
  
  services.geoclue2 = {
    enable = true;
    appConfig.redshift = {
      isAllowed = true;
      isSystem = false;
      users = [ "" ];
    };
  };

  # Firmware updates
  services.fwupd.enable = true;

  # Faster boot through entropy seeding
  services.haveged.enable = true;
}
