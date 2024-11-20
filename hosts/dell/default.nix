{
  pkgs,
  user,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../common/base.nix
    ../../common/system_packages.nix
    ../../common/fonts.nix
    ../../common/garbage_collection.nix
    ../../common/nas.nix
    ../../common/docker.nix
  ];

  services.openssh = {
    enable = true; # For github
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  programs.ssh.startAgent = true;

  services.libinput.touchpad.naturalScrolling = true;

  environment.variables.XCURSOR_SIZE = 32;
  environment.variables.CONFIG_DIR = "/home/${user}/nixos-config/";

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

  users.users.${user} = {
    isNormalUser = true;
    description = "Main user";
    extraGroups = ["networkmanager" "wheel"];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # apps
    firefox
    vagrant

    # utilities
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

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [user];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # ().
  system.stateVersion = "24.05"; # Did you read the comment?
}
