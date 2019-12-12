# VM config
# docref: <nixpkgs/..>

{ config, lib, pkgs, ... }:

{
  imports = [ ];

  # Name the child
  networking.hostName = "mkg-vm";

  users.users.maciej = {
    password = "";
  };

  users.users.root.password = "";

  services.mingetty.autologinUser = "root";

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    extraConfig = ''
      PermitEmptyPasswords yes
    '';
  };

  # Forward ssh, the like
  virtualisation.qemu.networkingOptions = [
    "-net nic,netdev=user.0,model=virtio"
    "-netdev user,id=user.0\${QEMU_NET_OPTS:+,$QEMU_NET_OPTS},hostfwd=tcp::8088-:80,hostfwd=tcp::2222-:22"
    "-soundhw hda"
    "-enable-kvm"
    "-cpu max"
    "-smp 4"
  ];
  # speed boost

  nix.maxJobs = lib.mkDefault 6;
}
