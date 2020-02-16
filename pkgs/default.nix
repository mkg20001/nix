let
  pkgs = (import <nixpkgs> { config.allowUnfree = true; });
  node = (import ./node pkgs);
in
  {
    thunderbird = pkgs.thunderbird.override {
      enableOfficialBranding = true;
    };

    brother = pkgs.callPackage ./brother { };

    service-shim = pkgs.writeShellScriptBin "service" (builtins.readFile ./service-shim.sh);
    iso2boot = pkgs.callPackage ./iso2boot { };
    yaru-blue = pkgs.callPackage ./yaru-blue { };
    kseistrup-filters = pkgs.callPackage ./kseistrup-filters { };

    break-symmetry = pkgs.callPackage ./break-symmetry { };
  } // node
