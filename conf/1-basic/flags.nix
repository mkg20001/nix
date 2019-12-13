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
        description = "Enable highSpec modules";
      };

      portable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable portable modules";
      };
    };
  };

  config = {};
}
