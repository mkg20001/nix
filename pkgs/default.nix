let
  pkgs = (import <nixpkgs> { config.allowUnfree = true; });
  node = (import ./node pkgs);

  writeShellScriptBinPath = name : deps : text :
  pkgs.writeShellScriptBin name ''
    export PATH='${pkgs.lib.makeBinPath deps}'${PATH:+':'}$PATH

    ${text}
    '';

  recreatePackage = orig: override:
    orig.overrideAttrs (orig: override);
in
  {
    thunderbird = pkgs.thunderbird.override {
      enableOfficialBranding = true;
    };

    brother = pkgs.callPackage ./brother { };

    nix = pkgs.nixStable.overrideAttrs(p: p // { patches = [ ./nix.patch ]; });

    service-shim = pkgs.writeShellScriptBin "service" (builtins.readFile ./service-shim.sh);
    nix-call-package = pkgs.writeShellScriptBin "nix-call-package" (builtins.readFile ./nix-call-package.sh);
    nix-edit-package = pkgs.writeShellScriptBin "nix-edit-package" (builtins.readFile ./nix-edit-package.sh);
    nix-visualize = writeShellScriptBinPath "nix-visualize" [ pkgs.graphviz pkgs.nix ] (builtins.readFile ./nix-visualize.sh);

    iso2boot = pkgs.callPackage ./iso2boot { };
    # yaru-blue = pkgs.callPackage ./yaru-blue { inherit recreatePackage };
    yaru-blue = pkgs.yaru-theme; # TODO: fix yaru patch
    kseistrup-filters = pkgs.callPackage ./kseistrup-filters { };

    atom = pkgs.callPackage ./atom { inherit recreatePackage; };
    yarn = pkgs.yarn.override { nodejs = node.node_lts; };

    break-symmetry = pkgs.callPackage ./break-symmetry { };

    # space fix
    firmwareLinuxNonfree = pkgs.callPackage ./firmware-linux-nonfree { inherit recreatePackage; };
  } // node
