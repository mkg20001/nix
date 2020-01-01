{ config, lib, pkgs, ... }:

with lib;

let
  loaProcess = process: data:
    if builtins.isList data then
      map process data
    else
      if builtins.isAttrs data then
        if hasAttrByPath [ "enable" ] data then
          if data.enable then [ process data ]
          else []
        else {}
      else
        builtins.concatMap (key: loaProcess process data.${key}) (builtins.attrNames data);

  process = config:
    if builtins.isNull config.script && builtins.isNull config.command
      then builtins.throw "Can't have cronjob ${name} with neither command nor script"
    else
      let
        cronName = "cron-${name}";
        pkg = if config.script != null then
          pkgs.writeShellScriptBin cronName config.script
        else null;
      in
        {
          systemd.services.${cronName} = rec {
            description = "cron ${name} @ ${intv}";
            startAt = intv;

            # path = config.environment.systemPackages;

            serviceConfig = {
              ExecStart = if pkg != null then "${pkg}/bin/${cronName}" else config.command;
            };
          } // config.opt;

          environment.systemPackages = if pkg != null then [ pkg ] else [ ];
        };
in

{
  options = {
    cron = mkOption {
      default = {};
      description = "Cronjobs via systemd timers";

      type = with types; loaOf (submodule (
        { name, config, ... }:
        {
          options = {
            enable = mkOption {
              type = types.bool;
              default = true;
              description = ''
                Whether this cronjob should be enabled.
                This option allows specific cronjobs to be disabled.
              '';
            };

            name = mkOption {
              type = types.str;
              description = "Name of the cronjob";
            };

            intv = mkOption {
              type = types.str;
              description = "Interval (see systemd-time)";
              example = "daily";
            };

            script = mkOption {
              type = types.nullOr types.str;
              description = "Literal script to be executed";
              default = null;
            };

            command = {
              type = types.nullOr types.str;
              description = "Literal command to be executed";
              default = null;
            };

            opt = {
              type = types.attrs;
              description = "Extra options for the service";
              default = {};
            };
          };

          config = {
            name = mkDefault name;
          };
        }
      ));
    };
  };

  config = {};

  imports = loaProcess process config.cron;
}
