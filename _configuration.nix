# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ device, channel ? false }:
{ config, lib, pkgs, fetchgit, ... }:

with lib;

let
  mkgRepo = (builtins.fromJSON(builtins.readFile ./mkgpkgs.json));
  mkgOverlay = (import (builtins.fetchGit mkgRepo));
in
  {
    imports =
      [ # Include merged config
        ./conf/merged.nix
        # Include the results of the hardware scan.
        # ./hardware-configuration.nix
        # Include per-device config
        device
      ] ++ (if channel then [
        # Include channel config
        ./channel.nix
      ] else []);

    nixpkgs.overlays = [ mkgOverlay ];
    nixpkgs.config.allowUnfree = true;

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    networking.useDHCP = false;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # TODO: split
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      wget vim nano htop nload iotop git tree nix-prefetch-git jq

      (import ./tools/iso2boot.nix pkgs)
    ] ++ (if channel then [
      # Include nixpkgs config
      ./nixpkgs.nix
    ] else []);

  }
