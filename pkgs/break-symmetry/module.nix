{ config, pkgs, lib, ... }:

with lib;

{
  options = {
    break-symmetry.enable = mkOption {
      type = types.bool;
      description = "Enable break-symmetry";
      default = false;
    };
  };

  config = mkIf config.break-symmetry.enable {
    environment.systemPackages = [ pkgs.break-symmetry ];

    system.activationScripts.A_break-symmetry = stringAfter [ "stdio" ] "${pkgs.break-symmetry}/libexec/break-symmetry-hook";
  };
}
