{
  services.sshd.enable = true;
  
  imports =
    [
      <nixpkgs/nixos/modules/profiles/all-hardware.nix>
      <nixpkgs/nixos/modules/profiles/base.nix>
      <nixpkgs/nixos/modules/hardware/video/radeon.nix>
    ];
}

