{
  fileSystems."/mnt/synology" = {
    device = "synology.home:/volume1/homes";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=60" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s" "nofail"];
  };
}
