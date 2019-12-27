{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./android.nix
    ./apps.nix
    ./docker.nix
    ./lxd.nix
    ./qemu.nix
    ./sysadmin-tools.nix
    ./tools.nix
    ./vbox.nix
  ];
}
