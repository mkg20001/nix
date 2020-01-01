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
  cDaily = pkgs.writeShellScriptBin "cron-daily" (builtins.readFile ../../cron/daily.sh);
  cWeekly = pkgs.writeShellScriptBin "cron-weekly" (builtins.readFile ../../cron/weekly.sh);

  c = intv:
    let
      pkg = pkgs.writeShellScriptBin "cron-${intv}" (builtins.readFile (../../cron + "/${intv}.sh"));
    in
    {
      systemd.services."cron-${intv}" = rec {
        description = "mkg cron ${intv}";
        startAt = intv;

        path = config.environment.systemPackages;

        serviceConfig = {
          ExecStart = "${pkg}/bin/cron-${intv}";
        };

        environment.NIX_PATH = "nixpkgs=/etc/nixpkgs:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels";
      };

      environment.systemPackages = [ pkg ];
    };
in
{
  imports = [
    (c "daily")
    (c "weekly")
  ];
}
