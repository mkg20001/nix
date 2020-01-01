{ config, lib, pkgs, ... }:

with lib;

/* services.cron = {
  enable = true;
  systemCronJobs = [
    "0 0 * * *      root    bash /etc/nixos/cron/daily.sh"
    "0 0 * * 1      root    bash /etc/nixos/cron/weekly.sh"
  ];
}; */

let
  c = intv:
    {
      cron.${intv} = {
        inherit intv;
        script = (builtins.readFile (../../cron + "/${intv}.sh"));
      };
    };
in
{
  imports = [
    (c "daily")
    (c "weekly")
  ];
}
