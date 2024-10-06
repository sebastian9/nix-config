{ pkgs, ... }:

{

  environment.systemPackages = [ pkgs.nextcloud29 ];
  environment.etc."nextcloud-admin-pass".text = "test_phrase";

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    hostName = "nuc.home";
    config = {
      dbtype = "mysql";
      dbhost = "localhost:3306";
      adminpassFile = "/etc/nextcloud-admin-pass";
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

}
