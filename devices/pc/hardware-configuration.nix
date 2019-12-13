# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "ahci" "ohci_pci" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # TODO: possibly switch to btrfs? or at least for home?

  fileSystems."/" =
    { #device = "/dev/disk/by-uuid/04f9c231-7127-46ef-b539-dfa29c1eaf47";
      device = "/dev/disk/by-label/nixos-root";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { #device = "/dev/disk/by-uuid/f7ddf94d-1584-44e6-b845-1e45e2a29983";
      device = "/dev/disk/by-label/nixos-boot";
      fsType = "ext4";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 6;
}