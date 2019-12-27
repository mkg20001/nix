{ config, lib, pkgs, ... }:

{
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # And sane to scan
  hardware.sane.enable = true;

  hardware.sane.brscan4 = {
    enable = true;
    netDevices = {
      /*
      name = {
        ip = "";
        model = ""; # ex MFC-XXXX
      };
      */
    };
  };
}
