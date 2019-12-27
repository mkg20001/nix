{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./mod/flags.nix
    ./mod/shell-links.nix

    ./sub/network
    ./sub/utils

    ./sub/desktop.nix
    (import ./sub/oom.nix [
      # OOM: max 1000, min -1000. the higher the faster killed
      { proc = "telegram-desktop"; score = 1000; }
      { proc = "chrome"; score = 990; }
      { proc = "firefox"; score = 980; }
      { proc = "atom"; score = 970; }
    ])
    ./sub/printer.nix
  ];

  # Enable system cleaning cronjobs

  # TODO: use internal jobs & use timers

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 0 * * *      root    bash /etc/nixos/cron/daily.sh"
      "0 0 * * 1      root    bash /etc/nixos/cron/weekly.sh"
    ];
  };

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
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };

  # Enable GPG agent
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Firmware updates
  services.fwupd.enable = true;

  # Faster boot through entropy seeding
  services.haveged.enable = true;
}
