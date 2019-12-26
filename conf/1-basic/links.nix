{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.shell-links;
in

{
  options = {
    system = {
      links = mkOption {
        type = types.strOr (types.submodule );
        description = "Create a symlink";
        literalExample = ''
          config.shell-links.bin.bash = "${pkgs.bash}/bin/bash";
          '';
      };
    };
  };

  config = {};
}
