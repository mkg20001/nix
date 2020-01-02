# tasks
watch:
	nodemon -e nix -x "nix-build -j auto -A current -v --show-trace -I nixpkgs=../nixpkgs"
iso:
	bash .ci/tag.sh
	nix-build -v -j auto -A iso -I nixpkgs=/etc/nixpkgs

# maint tasks
update:
	make -C pkgs update
