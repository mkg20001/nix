{ config, lib, pkgs, ... }:

with (import ../../util.nix lib);

{
  imports = [];

  # Enable the sycnthing daemon.
  systemd.services.syncthing = {
    wantedBy = [ "multi-user.target" ]; 
    after = [ "network.target" ];
    description = "Start syncthing";
    serviceConfig = {
      Type = "forking";
      User = "maciej";
      ExecStart = ''${pkgs.screen}/bin/screen -dmS syncthing ${pkgs.syncthing}/bin/syncthing'';         
      ExecStop = ''${pkgs.screen}/bin/screen -S syncthing -X quit'';
    };
  };
}

