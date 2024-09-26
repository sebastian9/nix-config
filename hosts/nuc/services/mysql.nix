{ pkgs, ... }:

{
  services = {
    mysql = {
      enable = true;
      package = pkgs.mariadb;
      ensureDatabases = [
        "nextcloud"
      ];
      ensureUsers = [
        {
          name = "nuc";
          ensurePermissions = {
            "nextcloud.*" = "SELECT";
          };
        }
        {
          name = "nextcloud";
          ensurePermissions = {
            "nextcloud.*" = "ALL PRIVILEGES";
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
      ];
    };
  };
}
