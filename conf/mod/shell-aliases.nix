# 9-shell-links
# creates shell aliases

{ config, lib, pkgs, ... }:

with lib;

let
  aliasList = {
    meros-upgrade = "nixos-rebuild switch --upgrade";
  };

  createScript = key: value:
  let
    normalizedKey = key; # TODO: normalize
    script = ''#!${pkgs.bash}/bin/bash

set -euo pipefail

exec ${value}
'';
  in
    ''
      echo ${escapeShellArg script} > $out/bin/${escapeShellArg normalizedKey}
      chmod +x $out/bin/${escapeShellArg normalizedKey}
    '';
in
{
  config = mkIf (aliasList != {}) {
    environment.systemPackages = [
      (with pkgs; stdenv.mkDerivation {
        pname = "aliases";
        version = "1.0.0";

        dontUnpack = true;

        installPhase = ''
          mkdir -p $out/bin
          ${builtins.concatStringsSep "\n" (forEach (builtins.attrNames aliasList) (key: createScript key aliasList.${key}))}
        '';
      })
    ];
  };
}
