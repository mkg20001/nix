# 3-APP
# Adds development tools

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    binutils # strings
    strace
    gitAndTools.gitFull
    gitAndTools.gitRemoteGcrypt
    git-lfs
    git-secrets
    git-sizer
    # gitAndTools.diff-so-fancy
    
    # stuff
    python3
    gnumake
  ];
}
