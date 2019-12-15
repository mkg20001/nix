{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.flags;
in

{
  options = {
    flags = {
      highSpec = mkOption {
        type = types.bool;
        default = false;
        description = "Enable modules that require good hardware";
      };

      portable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable modules for portable installations";
      };

      tools = mkOption {
        type = types.bool;
        default = false;
        description = "Enable extra tools";
      };
    };
  };

  config = {};
}
