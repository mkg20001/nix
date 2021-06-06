{ pkgs, ... }: with pkgs; {
  environment.systemPackages = with pkgs; [
    cachix
    openssh
  ];

  nix = {
    binaryCaches = [
      "https://mkg20001.cachix.org"
      "https://cache.xeredo.it"
    ];
    binaryCachePublicKeys = [
      "mkg20001.cachix.org-1:dg0SpEMJfgL8EDI0NRkGUd+wMoUaSzhZURsz1vRt4wY="
      "cache.xeredo.it-1:Dlh2ON5d64vjGOSc7NTD7/64diyuZczokmGObFRjMvE="
    ];
  };
}
