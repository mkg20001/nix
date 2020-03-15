# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ device, channel ? false }:
{ config, lib, pkgs, fetchgit, ... }:

with lib;

let
  /* mkgRepo = (builtins.fromJSON(builtins.readFile ./mkgpkgs.json));
  mkgOverlay = (import (builtins.fetchGit mkgRepo)); */

  overlay = (import ./pkgs/overlay.nix);
in
  {
    imports =
      [ # Include merged config
        ./conf
        # Include cachix-managed conf
        ./cachix.nix
        # Include the results of the hardware scan.
        # ./hardware-configuration.nix
        # Include per-device config
        device
      ] ++ (if channel then [
        # Include channel config
        ./channel.nix
      ] else []);

    nixpkgs.overlays = [
      # mkgOverlay
      overlay
    ];

    nixpkgs.config.permittedInsecurePackages = [
      "openssl-1.0.2u"
     ];

    nixpkgs.config.allowUnfree = true;

    # TODO: split
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      wget vim nano htop nload iotop git tree nix-prefetch-git jq

      iso2boot # from overlay
    ];

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    # system.stateVersion = "20.03"; # Did you read the comment?
    system.stateVersion = "unstable"; # Did you read the comment?

    # system.autoUpgrade.enable = true;
    # system.autoUpgrade.channel = https://nixos.org/channels/nixos-19.09;
  }
