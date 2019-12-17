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
}
