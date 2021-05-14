{ pkgs, ... }: with pkgs; {
  environment.systemPackages = with pkgs; [
    cachix
    openssh
  ];
}
