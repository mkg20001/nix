# PC config
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Name the child
  networking.hostName = "mkg-razer";

  # Raise da flags
  flags.highSpec = true;
  flags.tools = true;

  # hardware.nvidiaOptimus.disable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs; [ nvidia-offload ];

  hardware.nvidia.modesetting.enable = true;

  hardware.nvidia.prime.offload.enable = true;
  hardware.nvidia.prime = {
    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";
    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";

    # sync.enable = true;
  };

  /* services.xserver.videoDrivers = [
    "nvidia"
    "nv"
    # def
    "radeon"
    "cirrus"
    "vesa"
    "vmware"
    "modesetting"
    # added
    "nvidia"
    "nv"
  ]; */

  # boot.loader = {
  #  efi = {
  #    canTouchEfiVariables = true;
  #    efiSysMountPoint = "/boot";
  #  };
  #  grub = {
  #    devices = [ "nodev" ];
  #    efiSupport = true;
  #    version = 2;
  #  };
  # };
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.version = 2;

  services.mongodb.enable = true;

  services.mysql = {
    enable = true;
    package = pkgs.mysql;
    ensureDatabases = ["wpdev"];
    ensureUsers = [
      {
        name = "maciej";
        ensurePermissions = {
          "*.*" = "ALL PRIVILEGES";
        };
      }
      {
        name = "wwwrun";
        ensurePermissions = {
          "*.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  services.httpd = {
    enable = true;
    enablePHP = true;
    adminAddr = "me@localhost";
    virtualHosts."localhost" = {
      documentRoot = "/home/maciej/wpdev";
      extraConfig = ''
        DirectoryIndex index.html index.php

        <Directory "/home/maciej/wpdev">
          Options Indexes FollowSymLinks
          AllowOverride All
          Require all granted
        </Directory>
      '';
    };
  };

  security.sudo.extraConfig = ''
maciej ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/insmod /home/maciej/Projekte/sig-exec-module/cmake-build-debug/src/sig-exec.ko
maciej ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/rmmod sig_exec
  '';
}
