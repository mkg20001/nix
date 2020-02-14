{ config, lib, pkgs, ... }:

{
  services.system-config-printer.enable = true;
  environment.systemPackages = with pkgs; [ system-config-printer ];

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    # drivers = with pkgs; [ gutenprint hplip samsungUnifiedLinuxDriver splix brlaser brgenml1lpr brgenml1cupswrapper cups-googlecloudprint ];
    drivers = with pkgs; [ brother.mfcj890dw.driver brother.mfcj890dw.cupswrapper gutenprint hplip samsungUnifiedLinuxDriver splix brlaser brgenml1lpr brgenml1cupswrapper cups-googlecloudprint ];
    # this enables avahi+browsed autodiscover
    browsing = true;
    defaultShared = true;
    extraConf = ''
BrowseDNSSDSubTypes _cups,_print
BrowseLocalProtocols all
BrowseRemoteProtocols all
CreateIPPPrinterQueues All
    '';
    browsedConf = ''
BrowseDNSSDSubTypes _cups,_print
BrowseLocalProtocols all
BrowseRemoteProtocols all
CreateIPPPrinterQueues All

BrowseProtocols all
    '';
  };

  # And sane to scan
  hardware.sane.enable = true;

  # Cups network printing
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  hardware.sane.brscan4 = {
    enable = true;
    netDevices = {
      name = {
        ip = "192.168.178.130";
        model = "MFC-J890DW"; # ex MFC-XXXX
      };
    };
  };
}
