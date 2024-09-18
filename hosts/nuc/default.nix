{ lib, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./deployment.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nuc"; # Define your hostname.
  networking.networkmanager.enable = true;

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  environment.variables.EDITOR = "kitty"; # Make kitty default terminal emulator

  fonts.packages = with pkgs; [
    nerdfonts
    meslo-lgs-nf
  ];

  users.users.nuc = {
    isNormalUser = true;
    description = "Sebastian Lopez Sanchez";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    kitty
    git

    # utilities
    wget
    curl
    xclip
    busybox
    gcc
  ];

  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # ().
  system.stateVersion = "24.05"; # Did you read the comment?

}
