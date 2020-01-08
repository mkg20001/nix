let
  pkgs = (import <nixpkgs> { config.allowUnfree = true; });
  node = (import ./node pkgs);
in
  {
    thunderbird = pkgs.thunderbird.override {
      enableOfficialBranding = true;
    };

    iso2boot = pkgs.callPackage ./iso2boot { };
    yaru-blue = pkgs.callPackage ./yaru-blue { };
    tpm2-tss = {} // pkgs.tpm2-tss // { dontCheck = true; };
  } // node
