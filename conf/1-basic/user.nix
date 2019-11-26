# 1-user
# Add yours truly's user  account
# docref: TODO <nixpkgs/..>

{ config, lib, pkgs, ... }:

{
  imports = [];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maciej = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };
}
