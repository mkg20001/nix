{ config, lib, pkgs, ... }:

let
  README = (pkgs.writeTextDir "README.txt" (builtins.readFile ./README.txt));
in
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>
  ];

  # Name the child
  networking.hostName = "mkg-iso";

  # Auto-login & default pw
  services.xserver.displayManager.gdm.autoLogin = {
    enable = true;
    user = "maciej";
  };
  users.users.maciej.initialPassword = "install";

  # Whitelist wheel users to do anything
  # This is useful for things like pkexec
  #
  # WARNING: this is dangerous for systems
  # outside the installation-cd and shouldn't
  # be used anywhere else.
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  # Desktop
  system.activationScripts.installerDesktop = let
    homeDir = "/home/maciej/";
    desktopDir = homeDir + "Desktop/";

  in ''
    mkdir -p ${desktopDir}
    chown nixos ${homeDir} ${desktopDir}

    ln -sfT ${pkgs.gparted}/share/applications/gparted.desktop ${desktopDir + "gparted.desktop"}
    ln -sfT ${pkgs.gnome3.gnome_terminal}/share/applications/gnome-terminal.desktop ${desktopDir + "gnome-terminal.desktop"}
    ln -sfT ${README}/README.txt ${desktopDir + "README.txt"}
  '';

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "bootstrap" (builtins.readFile ../../bootstrap.sh))
    README
  ];
}
