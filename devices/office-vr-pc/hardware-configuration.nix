# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/e37f114a-f32f-4691-8bda-9d92923abaa8";
      fsType = "ext4";
    };

  fileSystems."/data" =
    { device = "/dev/disk/by-uuid/ddba9207-f932-4619-b0cb-c14a5d5c3ab0";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/288C-DDB7";
      fsType = "vfat";
    };

  fileSystems."/tmp" =
    { device = "/data/tmp";
      options = [ "bind" ];
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 16;
}
