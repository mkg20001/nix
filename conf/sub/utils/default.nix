{ config, lib, pkgs, ... }:

with lib;

let
  common = builtins.fetchGit {
    url = "https://github.com/mkg20001/mkg-nix";
    rev = "053139f91d01b00292d08d7de30b16a6b6ca901a";
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
