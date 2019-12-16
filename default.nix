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

  all = [ # TODO: instead just turn machines into a list using lib or sth
    machines.pc
    machines.portable
    machines.usb
    machines.lenovo
  ];
}
