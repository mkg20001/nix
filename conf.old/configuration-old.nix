# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, fetchgit, ... }:

with lib;

let
  mkgRepo = (builtins.fromJSON(builtins.readFile ./mkgpkgs.json));
  mkgOverlay = (import (builtins.fetchGit mkgRepo));
in
  {
    imports =
      [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
      ];

    nixpkgs.overlays = [ mkgOverlay ];

    # networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    networking.useDHCP = false;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    i18n = {
      consoleFont = "Lat2-Terminus16";
      consoleKeyMap = "de";
      defaultLocale = "de_DE.UTF-8";
    };

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      wget vim nano htop nload iotop git tree nix-prefetch-git
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.layout = "de";
    # services.xserver.xkbOptions = "eurosign:e";

    # Enable touchpad support.
    services.xserver.libinput.enable = true;

    # Enable the KDE Desktop Environment.
    # services.xserver.displayManager.sddm.enable = true;
    # services.xserver.desktopManager.plasma5.enable = true;
    
    # GDM
    services.xserver.displayManager.gdm3.enable = true;
    
    # Cinnamon
    services.xserver.desktopManager.cinnamon.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.maciej = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    };

    services.cron = {
      enable = true;
      systemCronJobs = [
        "0 0 * * 1      root    bash /etc/nixos/cron/weekly.sh"
        "0 0 * * *      root    bash /etc/nixos/cron/daily.sh"
      ];
    };

    # TODO: clean
    networking.networkmanager.enable = true;
    networking.wireless.enable = mkForce false;
    powerManagement.enable = true;

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "19.09"; # Did you read the comment?

  }
