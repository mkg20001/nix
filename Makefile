# tasks
watch:
	nodemon -e nix -x "nix-build -j auto -A current -v --show-trace -I nixpkgs=../nixpkgs"
iso:
	bash .ci/tag.sh
	nix-build -v -j auto -A machines.iso -I nixpkgs=/etc/nixpkgs

# maint tasks
conf-merge:
	cd conf && bash merge.sh
update:
	cd conf/5-tool-configuration && bash generate-npm-locks.sh
	make -C pkgs update
