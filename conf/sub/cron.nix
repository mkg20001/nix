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
  c = name: intv:
    let
      pkg = pkgs.writeShellScriptBin "cron-${name}" (builtins.readFile (../../cron + "/${name}.sh"));
    in
    {
      systemd.services."cron-${name}" = rec {
        description = "mkg cron ${name}";
        startAt = intv;
        restartIfChanged = false;

        path = config.environment.systemPackages;

        serviceConfig = {
          ExecStart = "${pkg}/bin/cron-${name}";
        };

        environment.NIX_PATH = "nixpkgs=/etc/nixpkgs:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels";
      };

      environment.systemPackages = [ pkg ];
    };
in
 mkIf (!config.flags.portable)
  (
    (c "daily" "daily") //
    (c "weekly" "weekly") //
    (c "clean-node-modules" "daily") //
    (c "free-space" "minutely")
  )
