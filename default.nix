let
  e = device: import <nixpkgs/nixos> {
    configuration = import ./_configuration.nix { device = device; };
  };

  machines = {
    pc = e ./devices/pc;
    portable = e ./devices/portable;
  };
in
{
  inherit machines;

  all = [ machines.pc machines.portable ];
}
