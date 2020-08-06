{ config, lib, pkgs, ... }:

with lib;
let
  README = (pkgs.writeTextDir "README.txt" (builtins.readFile ./README.txt));
  date = replaceChars ["\n"] [""] (builtins.readFile ../../rev);
in
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>
  ];

  services.xserver.videoDrivers = mkOverride 10 [
    # def nixos
    "radeon"
    "cirrus"
    "vesa"
    "modesetting"

    # added
    "vmware"
    "qemu"
    "virtualbox" # by virtualisation module
    "i915"
    "nvidia"

    # inxi
    # list is from sgfxi plus non-free drivers, plus ARM drivers
    "amdgpu" "apm" "ark" "armsoc" "atimisc" "ati"
    "chips" "cirrus" "cyrix" "fbdev" "fbturbo" "fglrx" "geode" "glide" "glint"
    "i128" "i740" "i810-dec100" "i810e" "i810" "i815" "i830" "i845" "i855" "i865" "i915" "i945" "i965"
    "iftv" "imstt" "intel" "ivtv" "mach64" "mesa" "mga" "modesetting"
    "neomagic" "newport" "nouveau" "nsc" "nvidia" "nv" "openchrome" "r128" "radeonhd" "radeon"
    "rendition" "s3virge" "s3" "savage" "siliconmotion" "sisimedia" "sisusb" "sis"
    "sunbw2" "suncg14" "suncg3" "suncg6" "sunffb" "sunleo" "suntcx"
    "tdfx" "tga" "trident" "tseng" "unichrome" "v4l" "vboxvideo" "vesa" "vga" "via" "vmware" "vmwgfx"
  ];

  virtualisation.virtualbox.guest = { enable = true; x11 = true; };
  services.qemuGuest.enable = true;

  # Name the child
  networking.hostName = "mkg-iso";

  # Raise da flags
  flags.portable = true;

  # Brand
  isoImage.isoName = "mkgnix-${date}-${config.isoImage.isoBaseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.iso";

  isoImage.volumeID = substring 0 11 "MKGNIX_ISO";

  isoImage.prependItems = [
    { class = "installer-persistent"; params = "boot.persistence=/dev/disk/by-label/mkg-portable"; }
    { class = "nomodeset-persistent"; params = "boot.persistence=/dev/disk/by-label/mkg-portable nomodeset"; }
    { class = "copytoram-persistent"; params = "boot.persistence=/dev/disk/by-label/mkg-portable copytoram"; }
    { class = "debug-persistent";     params = "boot.persistence=/dev/disk/by-label/mkg-portable debug"; }
  ];

  # Auto-login & default pw
  /* services.xserver.displayManager.gdm.autoLogin = {
    enable = true;
    user = "maciej";
  }; */
  users.users.maciej.initialPassword = "install";

  # Write cache
  boot.kernel.sysctl = {
    "vm.dirty_background_ratio" = 50;
    "vm.dirty_ratio" = 80;
  };

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

  # TODO: make persistence dynamicly configurable

  # Desktop
  system.activationScripts.installerDesktop = let
    homeDir = "/home/maciej/";
    desktopDir = homeDir + "Desktop/";

  in ''
    mkdir -p ${desktopDir}
    chown maciej ${homeDir} ${desktopDir}

    ln -sfT ${pkgs.gparted}/share/applications/gparted.desktop ${desktopDir + "gparted.desktop"}
    ln -sfT ${pkgs.gnome3.gnome_terminal}/share/applications/gnome-terminal.desktop ${desktopDir + "gnome-terminal.desktop"}
    ln -sfT ${README}/README.txt ${desktopDir + "README.txt"}
  '';

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "bootstrap" (builtins.readFile ../../bootstrap.sh))
    README
  ];
}
