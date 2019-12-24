let
  pkgs = (import <nixpkgs> { config.allowUnfree = true; });
  node = (import ./node pkgs);
in
  {
    # override pangox_compat instead?
    anydesk = pkgs.anydesk.override {
      pangox_compat = pkgs.pangox_compat.override {
        pango = pkgs.callPackage ./backportz/pango.nix { };
      };
    };

    thunderbird = pkgs.thunderbird.override {
      enableOfficialBranding = true;
    };

    iso2boot = pkgs.callPackage ./iso2boot { };
    yaru-blue = pkgs.callPackage ./yaru-blue { };
  } // node
