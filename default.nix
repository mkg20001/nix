let
  e = device: (import <nixpkgs/nixos> {
    configuration = import ./_configuration.nix { device = device; };
  });
  f = device: (e device).system;

  machines = {
    pc = f ./devices/pc;
    portable = f ./devices/portable;
    usb = f ./devices/usb;
    lenovo = f ./devices/lenovo;
    razer = f ./devices/razer;
		work = f ./devices/work;
  };
in
{
  inherit machines;

  iso = (e ./devices/iso).config.system.build.isoImage;

  vme = (e ./devices/vme).config.system.build.virtualBoxOVA;

  current =
    if builtins.pathExists ./device
      then e ./device
      else null;

  all = builtins.concatMap (iter: [machines.${iter}]) (builtins.attrNames machines);
}
