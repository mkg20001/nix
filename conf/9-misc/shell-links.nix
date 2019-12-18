# 9-shell-links
# creates links like /bin/bash

{ config, lib, pkgs, ... }:

with lib;

let
  linkList = {
    bin.bash = "${pkgs.bash}/bin/bash";
    etc.nixpkgs = "${pkgs.nixpkgs}/etc/nixpkgs";
  };
in
{
  imports = [];

  # iterate over keys:
  # path ? []
  # path push val
  # if isAttr val:
  #  mkdir -p ${path join "/"}
  #  iterate val, path
  # else if isString val:
  #  ln -sfn ${val} ${path join "/"}.tmp
  #  mv ${path join "/"}.tmp ${path join "/"}

  /* system.actinationScripts.shelllinks = stringAfter [ "stdio" ]
    builtins.concatMap (key: ) (builtins.attrNames linkList)

  system.activationScripts.binsh = stringAfter [ "stdio" ]
  ''
    # Create the required /bin/sh symlink; otherwise lots of things
    # (notably the system() function) won't work.
    mkdir -m 0755 -p /bin
    ln -sfn "${cfg.binsh}" /bin/.sh.tmp
    mv /bin/.sh.tmp /bin/sh # atomically replace /bin/sh
  ''; */
}
