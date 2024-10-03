
{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    owntracks-recorder
  ];

  networking.firewall.allowedTCPPorts = [ 1883 ];

  environment.etc."default/ot-recorder" = {
    text = ''
     OTR_STORAGEDIR="/var/lib/owntracks"
     OTR_PORT="1883"
     OTR_USER="seb"
     OTR_PASS="test"
     OTR_VIEWSDIR="/var/lib/owntracks/recorder/htdocs"
    '';
    user = "owntracks";
    group = "owntracks";
  };

  systemd.services.owntracks-recorder = {
    description = "OwnTracks Recorder";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.owntracks-recorder}/bin/ot-recorder 'owntracks/#'";
      Restart = "on-failure";
      User = "owntracks";
      Group = "owntracks";
      WorkingDirectory = "/var/lib/owntracks";
    };
  };

  users.users.owntracks = {
    isSystemUser = true;
    group = "owntracks";
    home = "/var/lib/owntracks";
    createHome = true;
  };

  users.groups.owntracks = {};

  system.activationScripts.makeOwntracksDir = lib.stringAfter [ "var" ] ''
    mkdir -p /var/lib/owntracks
    mkdir -p /var/lib/owntracks/recorder/htdocs
    chown owntracks:owntracks /var/lib/owntracks
  '';
}
