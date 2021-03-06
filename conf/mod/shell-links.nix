# 9-shell-links
# creates links like /bin/bash

{ config, lib, pkgs, ... }:

with lib;

let
  joinPath = p:
    builtins.concatStringsSep "/" ([ "" ] ++ p);
  joinLines =
    builtins.concatStringsSep "\n";

  linkList = {
    bin.bash = "${pkgs.bash}/bin/bash";
    bin.true = "${pkgs.coreutils}/bin/coreutils";
    bin.false = "${pkgs.coreutils}/bin/coreutils";
    # bin."2fa" = "/home/maciej/.bin/2fa";
    # etc.nixpkgs = "${pkgs.nixpkgs}/etc/nixpkgs";
    usr.bin.free = "${pkgs.procps}/bin/free";
    # usr.share = "/run/current-system/sw/share";
    usr.lib.node_modules.eslint = "${pkgs.eslint}/node_modules/eslint";
    usr.lib.node_modules.eslint-config-aegir-standalone = "${pkgs.eslint-config-aegir-standalone}";
    node_modules = "/usr/lib/node_modules"; # summoning the darkest of dark js-magic, beware

    usr.lib.node_modules.eslint-plugin-no-only-tests = "${pkgs.eslint-config-aegir-standalone}/node_modules/eslint-plugin-no-only-tests";
    usr.lib.node_modules.eslint-plugin-import = "${pkgs.eslint-config-aegir-standalone}/node_modules/eslint-plugin-import";
    usr.lib.node_modules.eslint-plugin-node = "${pkgs.eslint-config-aegir-standalone}/node_modules/eslint-plugin-node";
    usr.lib.node_modules.eslint-plugin-promise = "${pkgs.eslint-config-aegir-standalone}/node_modules/eslint-plugin-promise";
    usr.lib.node_modules.eslint-plugin-standard = "${pkgs.eslint-config-aegir-standalone}/node_modules/eslint-plugin-standard";
  };

  convertLinksRecursive = { attr, path ? [] }:
    builtins.concatMap (key:
      let
        newPath = path ++ [ key ];
        value = attr.${key};
      in
        if builtins.isAttrs value then
          [
            ''
              mkdir -p ${joinPath newPath}
            ''
          ] ++ (convertLinksRecursive { path = newPath; attr = value; })
        else if builtins.isString value then
          [
            ''
              ln -sfn ${value} ${joinPath newPath}.tmp
              rm -f ${joinPath newPath}
              mv ${joinPath newPath}.tmp ${joinPath newPath}
            ''
          ]
        else builtins.throw "Shell-Links got invalid value of non-attr/string type"
      ) (builtins.attrNames attr);
in
{
  imports = []
  ++ optional (builtins.pathExists /home/maciej/.bin/2fa) { environment.systemPackages = [ (pkgs.writeShellScriptBin "2fa" (builtins.readFile /home/maciej/.bin/2fa)) ]; };

  # iterate over keys:
  # path ? []
  # path push val
  # if isAttr val:
  #  mkdir -p ${path join "/"}
  #  iterate val, path
  # else if isString val:
  #  ln -sfn ${val} ${path join "/"}.tmp
  #  mv ${path join "/"}.tmp ${path join "/"}

  system.activationScripts.shellLinks = {
    text = joinLines (convertLinksRecursive { attr = linkList; });
    deps = [ ]; # FIXME: add correct deps
  };

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
