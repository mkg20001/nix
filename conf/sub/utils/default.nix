{ config, lib, pkgs, ... }:

with lib;

let
  common = builtins.fetchGit {
    url = "https://github.com/mkg20001/mkg-nix";
    rev = "2947964be1b86ee8e24feaddc94c342a00183f0e";
  };
in
{
  imports = [
    ./android.nix
    ./apps.nix
    ./docker.nix
    ./lxd.nix
    ./qemu.nix
    "${common}/sysadmin-tools.nix"
    ./tools.nix
    ./vbox.nix
  ];
}
