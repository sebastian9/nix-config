# Auto-generated using compose2nix v0.3.1-pre.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."dawarich_app" = {
    image = "freikin/dawarich:latest";
    environment = {
      "APPLICATION_HOST" = "localhost";
      "APPLICATION_HOSTS" = "localhost";
      "APPLICATION_PROTOCOL" = "http";
      "DATABASE_HOST" = "dawarich_db";
      "DATABASE_NAME" = "dawarich_development";
      "DATABASE_PASSWORD" = "password";
      "DATABASE_USERNAME" = "postgres";
      "DISTANCE_UNIT" = "km";
      "MIN_MINUTES_SPENT_IN_CITY" = "60";
      "RAILS_ENV" = "development";
      "REDIS_URL" = "redis://dawarich_redis:6379/0";
      "TIME_ZONE" = "America/Los_Angeles";
    };
    volumes = [
      "dawarichgpstracker_gem_cache:/usr/local/bundle/gems:rw"
      "dawarichgpstracker_public:/var/app/public:rw"
      "dawarichgpstracker_watched:/var/app/tmp/imports/watched:rw"
    ];
    ports = [
      "3000:3000/tcp"
    ];
    cmd = [ "bin/dev" ];
    dependsOn = [
      "dawarich_db"
      "dawarichgpstracker-dawarich_redis"
    ];
    log-driver = "journald";
    extraOptions = [
      "--cpu-quota=50000"
      "--memory=2147483648b"
      "--network-alias=dawarich_app"
      "--network=dawarichgpstracker_dawarich"
    ];
  };
  systemd.services."docker-dawarich_app" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-dawarichgpstracker_dawarich.service"
      "docker-volume-dawarichgpstracker_gem_cache.service"
      "docker-volume-dawarichgpstracker_public.service"
      "docker-volume-dawarichgpstracker_watched.service"
    ];
    requires = [
      "docker-network-dawarichgpstracker_dawarich.service"
      "docker-volume-dawarichgpstracker_gem_cache.service"
      "docker-volume-dawarichgpstracker_public.service"
      "docker-volume-dawarichgpstracker_watched.service"
    ];
    partOf = [
      "docker-compose-dawarichgpstracker-root.target"
    ];
    wantedBy = [
      "docker-compose-dawarichgpstracker-root.target"
    ];
  };
  virtualisation.oci-containers.containers."dawarich_db" = {
    image = "postgres:14.2-alpine";
    environment = {
      "POSTGRES_PASSWORD" = "password";
      "POSTGRES_USER" = "postgres";
    };
    volumes = [
      "dawarichgpstracker_db_data:/var/lib/postgresql/data:rw"
      "dawarichgpstracker_shared_data:/var/shared:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=dawarich_db"
      "--network=dawarichgpstracker_dawarich"
    ];
  };
  systemd.services."docker-dawarich_db" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-dawarichgpstracker_dawarich.service"
      "docker-volume-dawarichgpstracker_db_data.service"
      "docker-volume-dawarichgpstracker_shared_data.service"
    ];
    requires = [
      "docker-network-dawarichgpstracker_dawarich.service"
      "docker-volume-dawarichgpstracker_db_data.service"
      "docker-volume-dawarichgpstracker_shared_data.service"
    ];
    partOf = [
      "docker-compose-dawarichgpstracker-root.target"
    ];
    wantedBy = [
      "docker-compose-dawarichgpstracker-root.target"
    ];
  };
  virtualisation.oci-containers.containers."dawarich_sidekiq" = {
    image = "freikin/dawarich:latest";
    environment = {
      "APPLICATION_HOST" = "localhost";
      "APPLICATION_HOSTS" = "localhost";
      "APPLICATION_PROTOCOL" = "http";
      "BACKGROUND_PROCESSING_CONCURRENCY" = "10";
      "DATABASE_HOST" = "dawarich_db";
      "DATABASE_NAME" = "dawarich_development";
      "DATABASE_PASSWORD" = "password";
      "DATABASE_USERNAME" = "postgres";
      "DISTANCE_UNIT" = "km";
      "RAILS_ENV" = "development";
      "REDIS_URL" = "redis://dawarich_redis:6379/0";
    };
    volumes = [
      "dawarichgpstracker_gem_cache:/usr/local/bundle/gems:rw"
      "dawarichgpstracker_public:/var/app/public:rw"
      "dawarichgpstracker_watched:/var/app/tmp/imports/watched:rw"
    ];
    cmd = [ "sidekiq" ];
    dependsOn = [
      "dawarich_app"
      "dawarich_db"
      "dawarichgpstracker-dawarich_redis"
    ];
    log-driver = "journald";
    extraOptions = [
      "--cpu-quota=50000"
      "--entrypoint=[\"dev-entrypoint.sh\"]"
      "--log-opt=max-file=5"
      "--log-opt=max-size=100m"
      "--memory=2147483648b"
      "--network-alias=dawarich_sidekiq"
      "--network=dawarichgpstracker_dawarich"
    ];
  };
  systemd.services."docker-dawarich_sidekiq" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-dawarichgpstracker_dawarich.service"
      "docker-volume-dawarichgpstracker_gem_cache.service"
      "docker-volume-dawarichgpstracker_public.service"
      "docker-volume-dawarichgpstracker_watched.service"
    ];
    requires = [
      "docker-network-dawarichgpstracker_dawarich.service"
      "docker-volume-dawarichgpstracker_gem_cache.service"
      "docker-volume-dawarichgpstracker_public.service"
      "docker-volume-dawarichgpstracker_watched.service"
    ];
    partOf = [
      "docker-compose-dawarichgpstracker-root.target"
    ];
    wantedBy = [
      "docker-compose-dawarichgpstracker-root.target"
    ];
  };
  virtualisation.oci-containers.containers."dawarichgpstracker-dawarich_redis" = {
    image = "redis:7.0-alpine";
    volumes = [
      "dawarichgpstracker_shared_data:/var/shared/redis:rw"
    ];
    cmd = [ "redis-server" ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=dawarich_redis"
      "--network=dawarichgpstracker_dawarich"
    ];
  };
  systemd.services."docker-dawarichgpstracker-dawarich_redis" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-dawarichgpstracker_dawarich.service"
      "docker-volume-dawarichgpstracker_shared_data.service"
    ];
    requires = [
      "docker-network-dawarichgpstracker_dawarich.service"
      "docker-volume-dawarichgpstracker_shared_data.service"
    ];
    partOf = [
      "docker-compose-dawarichgpstracker-root.target"
    ];
    wantedBy = [
      "docker-compose-dawarichgpstracker-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-dawarichgpstracker_dawarich" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f dawarichgpstracker_dawarich";
    };
    script = ''
      docker network inspect dawarichgpstracker_dawarich || docker network create dawarichgpstracker_dawarich
    '';
    partOf = [ "docker-compose-dawarichgpstracker-root.target" ];
    wantedBy = [ "docker-compose-dawarichgpstracker-root.target" ];
  };

  # Volumes
  systemd.services."docker-volume-dawarichgpstracker_db_data" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect dawarichgpstracker_db_data || docker volume create dawarichgpstracker_db_data
    '';
    partOf = [ "docker-compose-dawarichgpstracker-root.target" ];
    wantedBy = [ "docker-compose-dawarichgpstracker-root.target" ];
  };
  systemd.services."docker-volume-dawarichgpstracker_gem_cache" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect dawarichgpstracker_gem_cache || docker volume create dawarichgpstracker_gem_cache
    '';
    partOf = [ "docker-compose-dawarichgpstracker-root.target" ];
    wantedBy = [ "docker-compose-dawarichgpstracker-root.target" ];
  };
  systemd.services."docker-volume-dawarichgpstracker_public" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect dawarichgpstracker_public || docker volume create dawarichgpstracker_public
    '';
    partOf = [ "docker-compose-dawarichgpstracker-root.target" ];
    wantedBy = [ "docker-compose-dawarichgpstracker-root.target" ];
  };
  systemd.services."docker-volume-dawarichgpstracker_shared_data" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect dawarichgpstracker_shared_data || docker volume create dawarichgpstracker_shared_data
    '';
    partOf = [ "docker-compose-dawarichgpstracker-root.target" ];
    wantedBy = [ "docker-compose-dawarichgpstracker-root.target" ];
  };
  systemd.services."docker-volume-dawarichgpstracker_watched" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect dawarichgpstracker_watched || docker volume create dawarichgpstracker_watched
    '';
    partOf = [ "docker-compose-dawarichgpstracker-root.target" ];
    wantedBy = [ "docker-compose-dawarichgpstracker-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-dawarichgpstracker-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
