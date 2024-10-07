{ lib, config, pkgs, ... }:

{

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  imports = [
    ./hardware-configuration.nix
    ./deployment.nix
    ./users.nix
    ./services
    ../../common/base.nix
    ../../common/system_packages.nix
    ../../common/fonts.nix
    ../../common/garbage_collection.nix
    ../../common/nas.nix
    ../../common/docker.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # ().
  system.stateVersion = "24.05"; # Did you read the comment?

}
