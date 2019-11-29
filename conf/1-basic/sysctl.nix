# 1-sysctl
# Setup some sysctl vars

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 20480000;
    "vm.swappiness" = 80;
  };
}
