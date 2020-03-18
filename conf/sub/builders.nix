# Enable distributed builds

{ config, pkgs, lib, ... }:

with (import ../util.nix lib);

{
  imports = [];

  nix.distributedBuilds = true;
  # optional, useful when the builder has a faster internet connection than yours
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';

  nix.buildMachines = builtins.attrValues (loadPriv "build_machines.toml");
/*

[your_server]
hostName = "your_server.com"
system = "x86_64"

# if the builder supports building for multiple architectures, 
# replace the previous line by, e.g.,
# systems = ["x86_64-linux", "aarch64-linux"]

sshUser = "..."
sshKey = "..."

maxJobs = 1
speedFactor = 2
supportedFeatures = [ "nixos-test", "benchmark", "big-parallel", "kvm" ]
mandatoryFeatures = [ ]

*/
}

