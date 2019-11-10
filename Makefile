build:
	nix-build '<nixpkgs/nixos>' -A config.system.build.nixos-install -I nixos-config=$(PWD)/conf/configuration.nix
build-iso:
	nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=$(PWD)/conf/iso.nix
