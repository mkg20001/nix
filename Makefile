build:
	nix-build -v '<nixpkgs/nixos>' -A config.system.build.nixos-install -I nixos-config=$(PWD)/conf/configuration.nix
build-iso:
	nix-build -v '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=$(PWD)/conf/iso.nix
update:
	nix-prefetch-git --quiet --url https://github.com/mkg20001/mkgpkgs > mkgpkgs.json
