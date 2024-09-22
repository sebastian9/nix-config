{ lib, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../common/base.nix
      ../../common/garbage_collection.nix
      ../../common/fonts.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dell"; # Define your hostname.
  networking.networkmanager.enable = true;

  services.openssh.enable = true; # For github
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.KbdInteractiveAuthentication = false;
  programs.ssh.startAgent = true;

  services.libinput.touchpad.naturalScrolling = true;

  environment.variables.EDITOR = "vim";
  environment.variables.XCURSOR_SIZE = 32;
  environment.variables.CONFIG_DIR = "/home/seb/nixos-config/";

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Hyprland window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Hint Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Screen sharing
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  users.users.seb = {
    isNormalUser = true;
    description = "Sebastian Lopez Sanchez";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Passwordless sudo
  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    kitty
    git

    # apps
    firefox
    vagrant

    # utilities
    wget
    curl
    xclip
    busybox
    gcc
    networkmanagerapplet # GUI
    brightnessctl # display control

    dunst # notifiction daemon

    # hyprland
    hyprland
    swww # wallpapers
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

    # wayland (display manager)
    xwayland
    waybar
    wl-clipboard
    rofi # app launcher

    # sound
    pavucontrol #GUI
    pipewire
  ];

  nixpkgs.config.allowUnfree = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "seb" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # ().
  system.stateVersion = "24.05"; # Did you read the comment?

}
