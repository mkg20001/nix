{ config, pkgs, lib, ... }:

{
  networking.networkmanager = {
    enable = true;
    dns = "dnsmasq";
    dispatcherScripts =
    [ {
      source = pkgs.writeText "upHook" ''
        # Only set dns for wlp and enp interface, not virbr, docker and so on
        # FIXME: only works after first connect, should work by default and not change config
        if [[ $DEVICE_IFACE == *"wlp"* || $DEVICE_IFACE == *"enp"* ]]; then
          /run/current-system/sw/bin/nmcli connection modify uuid $CONNECTION_UUID \
          ipv4.dhcp-send-hostname "false" \
          ipv4.ignore-auto-dns "true" \
          ipv4.dns "127.0.0.1" \
          ipv6.dhcp-send-hostname "false" \
          ipv6.ignore-auto-dns "true" \
          ipv6.dns "::1" # Dnsmasq doesn't actually listen on IPv6, so ipv6 dns requests probably won't work
        else
          echo "Excluding $DEVICE_IFACE from privacy dispatcher script" >> /tmp/dispatcherScripts.log
        fi
      '';
      type = "pre-up";
    } ]; # Use local DNS server and don't send hostname. For all connections
  };

  environment.etc = {
    "NetworkManager/dnsmasq.d/dnsmasq-nm.conf".text = ''
      no-resolv
      server=127.0.0.1#5453
      server=0::1#5453
      cache-size=1500
   '';
    "NetworkManager/dnsmasq-shared.d/dnsmasq-shared-nm.conf".text = ''
      no-resolv
      server=127.0.0.1#5453
      server=0::1#5453
      cache-size=500
    '';
  };

  services.stubby = {
    enable = true;
    listenAddresses =
    [
      "127.0.0.1@5453"
      "0::1@5453"
    ];
    upstreamServers = ''
      ## IPv4 ##
      # The Uncensored DNS servers
        - address_data: 89.233.43.71
          tls_auth_name: "unicast.censurfridns.dk"
          tls_pubkey_pinset:
            - digest: "sha256"
              value: wikE3jYAA6jQmXYTr/rbHeEPmC78dQwZbQp6WdrseEs=
      # Foundation for Applied Privacy
        - address_data: 37.252.185.232
          tls_auth_name: "dot1.appliedprivacy.net"
          tls_port: 443 # In case default 853 is blocked
      ## IPv6 ##
      # The Uncensored DNS server
        - address_data: 2a01:3a0:53:53::0
          tls_auth_name: "unicast.censurfridns.dk"
          tls_pubkey_pinset:
            - digest: "sha256"
              value: wikE3jYAA6jQmXYTr/rbHeEPmC78dQwZbQp6WdrseEs=
      # Foundation for Applied Privacy
        - address_data: 2a00:63c1:a:229::3
          tls_port: 443 # In case default 853 is blocked
          tls_auth_name: "dot1.appliedprivacy.net"
    '';
  };
}
