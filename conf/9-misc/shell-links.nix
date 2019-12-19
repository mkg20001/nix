# 9-shell-links
# creates links like /bin/bash

{ config, lib, pkgs, ... }:

with lib;

let
  joinPath = builtins.concatStringsSep "/";
  joinLines = builtins.concatStringsSep "\n";

  linkList = {
    bin.bash = "${pkgs.bash}/bin/bash";
    etc.nixpkgs = "${pkgs.nixpkgs}/etc/nixpkgs";
  };

  convertLinksRecursive = { attr, path ? [] }:
    builtins.concatMap (key:
      let
        newPath = path ++ [ key ];
        value = attr.${key};
      in
        if builtins.isAttr value then
          [
            ''
              mkdir -p ${joinPath newPath}
            ''
          ] ++ (convertLinksRecursive { path = newPath; })
        else if builtins.isString value then
          [
            ''
              ln -sfn ${val} ${joinPath newPath}.tmp
              mv ${joinPath newPath}.tmp ${joinPath newPath}
            ''
          ]
        else builtins.throw "Shell-Links got invalid value of non-attr/string type"
      ) (builtins.attrNames attr);
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

  system.activationScripts.binsh = stringAfter [ "stdio" ]
    joinLines (convertLinksRecursive linkList)

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
