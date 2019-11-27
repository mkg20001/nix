# 1-cron
# Enable system cleaning cronjobs
# docref: TODO <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 0 * * *      root    bash /etc/nixos/cron/daily.sh"
      "0 0 * * 1      root    bash /etc/nixos/cron/weekly.sh"
    ];
  };
}
