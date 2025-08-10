{
  config,
  pkgs,
  user,
  ...
}: {
  home.username = user;
  home.homeDirectory = "/home/${user}";

  programs.kitty.enable = true; # required for the default Hyprland config

  imports = [
    ./packages.nix # standalone packages
    ./hyprland.nix

    # software configs
    ../../home/zsh.nix
    ../../home/git.nix
    ../../home/vscode.nix
    ../../home/kitty.nix
    ../../home/tmux.nix
    ../../home/navi.nix
    ../../home/modern_unix.nix
    ../../home/neovim/standalone
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
