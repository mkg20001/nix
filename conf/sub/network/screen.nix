{ config, lib, pkgs, ... }:

with (import ../../util.nix lib);

let
  serv = name: bin: extra:
  { systemd.services.${name} = {
    wantedBy = [ "multi-user.target" ]; 
    after = [ "network.target" ];
    description = "Start ${name}";
    serviceConfig = {
      Type = "forking";
      User = "maciej";
      ExecStart = ''${pkgs.screen}/bin/screen -dmS ${name} ${bin}'';         
      ExecStop = ''${pkgs.screen}/bin/screen -S ${name} -X quit'';
    };
  } // extra;
  };
in
(serv "syncthing" "${pkgs.syncthing}/bin/syncthing" {}) //
(serv "tor" "${pkgs.tor}/bin/tor" {})

