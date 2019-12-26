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
    (hiPrio qpaeq)

    sshpass
    borgbackup

    lm_sensors
    inetutils
    cmatrix
    lxqt.pavucontrol-qt
    youtube-dl
    (hiPrio ntfs3g)
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
