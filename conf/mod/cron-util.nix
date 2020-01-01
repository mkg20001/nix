# TODO: turn into service?

name: intv: script:
  let
    pkg = pkgs.writeShellScriptBin "cron-${name}" script;
  in
  {
    systemd.services."cron-${name}" = rec {
      description = "cron ${name} @ ${intv}";
      startAt = intv;

      path = config.environment.systemPackages;

      serviceConfig = {
        ExecStart = "${pkg}/bin/cron-${name}";
      };
    };

    environment.systemPackages = [ pkg ];
  }
