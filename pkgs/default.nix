let
  pkgs = (import <nixpkgs> { });
  overlay = (self: super: {
    anydesk = pkgs.anydesk.override {
      pangox_compat = pkgs.pangox_compat.override {
        pango = pkgs.callPackage ./pango-for-anydesk pkgs;
      };
    };
    iso2boot = pkgs.callPackage ./iso2boot { };
    yaru-blue = pkgs.callPackage ./yaru-blue { };
  });
in
  overlay
