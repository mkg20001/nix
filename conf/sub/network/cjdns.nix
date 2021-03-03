# Enable cjdns
# docref: <nixpkgs/nixos/modules/services/networking/cjdns.nix>

{ config, lib, pkgs, ... }:

with (import ../../util.nix lib);

let
  cfg = config.mod.cjdns;
in
{
  options = {
    mod.cjdns = {
      port = mkOption {
        type = types.int;
        default = 12024;
      };

      passwords = mkOption {
        type = types.attrs;
        # default = (loadPriv "cjdns_pw.toml").${machine};
        default = {};
      };
    };
  };

  config = {
    # Enable the cjdns daemon.
    services.cjdns = {
      enable = true;

      ETHInterface = # otherwise the assertion fails
        {
          bind = "all";
          beacon = 2; # 0=off, 1=accept, 2=accept & send
          # connectTo = {};
        };

      extraConfig = {
        authorizedPasswords = mapAttrsToList (user: password: { inherit user password; }) cfg.passwords;

        interfaces = {
          UDPInterface = [
            {
              bind = "0.0.0.0:${toString cfg.port}";
              connectTo = filterAttrs (n: v: v.hostname != config.networking.hostName) # prevent connecting to ourselves
                (loadPriv "cjdns_nodes.toml");

              beacon = 2;
              beconDevices = ["all"];
              beaconPort = cfg.port + 1;
            }
            {
              bind = "[::]:${toString cfg.port}";

              beacon = 2;
            }
          ];
        };
      };
    };

    networking.firewall.allowedUDPPorts = [
      cfg.port
      (cfg.port + 1)
    ];

    environment.systemPackages = with pkgs; [
      yrd
    ];
  };
}
