{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

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

  services.libinput.touchpad.naturalScrolling = true;

  environment.variables.EDITOR = "kitty"; # Make kitty default terminal emulator
  environment.variables.XCURSOR_SIZE = 32;

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

  fonts.packages = with pkgs; [
    nerdfonts
    meslo-lgs-nf
  ];

  users.users.seb = {
    isNormalUser = true;
    description = "Sebastian Lopez Sanchez";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ neovim ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    kitty
    git

    # apps
    firefox
    # spotify

    # utilities
    wget
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


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # ().
  system.stateVersion = "24.05"; # Did you read the comment?

}
