{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./mod/flags.nix
    ./mod/shell-links.nix
    ./mod/shell-aliases.nix

    ./sub/network
    ./sub/utils

    ./sub/cron.nix
    ./sub/desktop.nix
    (import ./sub/oom.nix [
      # OOM: max 1000, min -1000. the higher the faster killed
      { proc = "telegram-desktop"; score = 1000; }
      { proc = "chrome"; score = 950; }
      { proc = "firefox"; score = 900; }
      { proc = "atom"; score = 800; }
    ])
    ./sub/printer.nix
  ];

  # Select internationalisation properties.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";

    # Setup some extra TTYs, because we can ^^
    # docref: <nixpkgs/nixos/modules/tasks/kbd.nix>
    extraTTYs = ["tty7" "tty8" "tty9"];
  };

  i18n.defaultLocale = "de_DE.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Setup nix

  nix = {
    useSandbox = true;
    autoOptimiseStore = true;

    extraOptions = ''
      # In general, outputs must be registered as roots separately. However, even if the output of a derivation is registered as a root, the collector will still delete store paths that are used only at build time (e.g., the C compiler, or source tarballs downloaded from the network). To prevent it from doing so, set this option to true.
      gc-keep-outputs = true
      gc-keep-derivations = true
      env-keep-derivations = true

      # Cache TTLs
      # narinfo-cache-positive-ttl = 0
      narinfo-cache-negative-ttl = 0
      '';
  };

  # Swap, watch fixes
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 20480000;
    "vm.swappiness" = 80;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maciej = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "wireshark" ];
  };

  boot.loader.grub = {
    splashImage = ./grub-scaled.png;
    # black=transparent, tf
    extraEntries = ''
      set color_normal=dark-gray/black
      set color_highlight=white/cyan
    '';
  };

  # Enable GPG agent
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Firmware updates
  services.fwupd.enable = true;

  # Faster boot through entropy seeding
  services.haveged.enable = true;

  # Shutdown speed-up
  systemd.services.fwupd.serviceConfig = { TimeoutStopSec = 5; };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=20s
  '';

  services.journald.extraConfig = ''
    SystemKeepFree=10G
    SystemMaxUse=1G
  '';
}
