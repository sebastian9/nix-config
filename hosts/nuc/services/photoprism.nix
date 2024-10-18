{pkgs, ...}: {
  environment.systemPackages = [pkgs.photoprism];
  environment.etc."photoprism-admin-pass".text = "test_phrase";
  networking.firewall.allowedTCPPorts = [2342];

  services.photoprism = {
    enable = true;
    passwordFile = "/etc/photoprism-admin-pass";
    port = 2342;
    originalsPath = "/mnt/synology/seb/photoprism/originals";
    importPath = "/mnt/synology/seb/photoprism/imports";
    address = "0.0.0.0";
    settings = {
      PHOTOPRISM_ADMIN_USER = "admin";
      PHOTOPRISM_ADMIN_PASSWORD = "...";
      PHOTOPRISM_DEFAULT_LOCALE = "en";
      PHOTOPRISM_DATABASE_DRIVER = "mysql";
      PHOTOPRISM_DATABASE_NAME = "photoprism";
      PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
      PHOTOPRISM_DATABASE_USER = "photoprism";
      PHOTOPRISM_SITE_URL = "http://nuc.home:2342";
      PHOTOPRISM_SITE_TITLE = "Seb's PhotoPrism";
    };
  };
}
