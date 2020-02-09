{ callPackage
, fetchurl
}:

let
  template = callPackage ./template.nix {};
in
{
  mfcj890dw = template rec {
    model = "mfcj890dw";
    version = "1.0.5-0";
    src = fetchurl {
      url = "https://download.brother.com/welcome/dlf103558/${model}pdrv-${version}.i386.deb";
      sha256 = "19h2z7i94qqva596mca692a4srjgfsl3adizb7hbk8b4fsr5vcda";
    };
  };
}
