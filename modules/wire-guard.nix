{
  lib,
  pkgs,
  config,
  ...
}:
{
  # disable built-in dns https://wiki.nixos.org/wiki/WireGuard#Secure_DNS_for_the_proxy_client
  services.resolved.enable = false;

  # knot dns resolver
  services.kresd.enable = true;

  networking.resolvconf.enable = false;
  environment.etc."resolv.conf" = {
    mode = "0644";
    text = "nameserver ::1";
  };

#   # NixOS firewall will block wg traffic because of rpfilter
#   networking.firewall.checkReversePath = "loose";

  # Secure DNS hinders usage of captive portals. Snippet taken from https://wiki.nixos.org/wiki/Systemd/resolved
  # The following configuration configures resolved daemon to use the public DNS resolver provided by Cloudflare. DNSSEC and DNS-over-TLS is enabled for authenticity and encryption.
  /*services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "true";
      Domains = [ "~." ];
      DNSOverTLS = "true";
      FallbackDNS = [
      "1.1.1.1"
      "1.0.0.1"
      ];
    };
  };*/

}
