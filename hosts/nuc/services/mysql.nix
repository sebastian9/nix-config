{ user, pkgs, ...}: {
  environment.systemPackages = [pkgs.mariadb];

  services = {
    mysql = {
      enable = true;
      package = pkgs.mariadb;
      ensureDatabases = [
        "nextcloud"
        "photoprism"
      ];
      ensureUsers = [
        {
          name = user;
          ensurePermissions = {
            "nextcloud.*" = "SELECT";
            "photoprism.*" = "SELECT";
          };
        }
        {
          name = "nextcloud";
          ensurePermissions = {
            "nextcloud.*" = "ALL PRIVILEGES";
          };
        }
        {
          name = "photoprism";
          ensurePermissions = {
            "photoprism.*" = "ALL PRIVILEGES";
          };
        }
        {
          name = "backup";
          ensurePermissions = {
            "*.*" = "SELECT, LOCK TABLES";
          };
        }
      ];
    };
    mysqlBackup = {
      enable = true;
      databases = [
        "nextcloud"
        "photoprism"
      ];
    };
  };
}
