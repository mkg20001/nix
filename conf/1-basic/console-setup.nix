# 1-console-setup
# Setup some extra TTYs, because we can ^^
# docref: <nixpkgs/nixos/modules/tasks/kbd.nix>

{ config, lib, pkgs, ... }:

{
  imports = [];

  boot.extraTTYs = ["tty7" "tty8" "tty9"];
}
