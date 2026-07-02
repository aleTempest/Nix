{
  services.mullvad-vpn.enable = true;

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    dnsovertls = "true";
    fallbackDns = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
}
