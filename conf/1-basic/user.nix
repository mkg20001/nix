# 1-user
# Add yours truly's user account
# docref: TODO <nixpkgs/..>

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maciej = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
}
