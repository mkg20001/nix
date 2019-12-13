# 1-nix
# Setup nix caches

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # TODO: add cachix

  nix.extraOptions = ''
    # In general, outputs must be registered as roots separately. However, even if the output of a derivation is registered as a root, the collector will still delete store paths that are used only at build time (e.g., the C compiler, or source tarballs downloaded from the network). To prevent it from doing so, set this option to true.
    gc-keep-outputs = true
    gc-keep-derivations = true
    env-keep-derivations = true

    # Cache TTLs
    # narinfo-cache-positive-ttl = 0
    narinfo-cache-negative-ttl = 0
    '';

}
