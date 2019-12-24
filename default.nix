let
  e = device: (import <nixpkgs/nixos> {
    configuration = import ./_configuration.nix { device = device; };
  }).system;

  machines = {
    pc = e ./devices/pc;
    portable = e ./devices/portable;
    usb = e ./devices/usb;
    lenovo = e ./devices/lenovo;
  };
in
{
  inherit machines;

  all = builtins.concatMap (iter: [machines.${iter}]) (builtins.attrNames machines);
}
