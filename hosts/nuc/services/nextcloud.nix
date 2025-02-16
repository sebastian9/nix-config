{pkgs, ...}: {
  environment.systemPackages = [pkgs.nextcloud30];
  environment.etc."nextcloud-admin-pass".text = "test_phrase";

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "cloud.home";
    configureRedis = true;
    config = {
      dbtype = "mysql";
      dbhost = "localhost:3306";
      adminpassFile = "/etc/nextcloud-admin-pass";
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
