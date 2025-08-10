{
  lib,
  ...
}: {
  imports = [
    # software configs
    ../../home/zsh.nix
    ../../home/git.nix
    ../../home/kitty.nix
    ../../home/tmux.nix
    ../../home/navi.nix
    ../../home/modern_unix.nix
    ../../home/neovim/standalone
  ];

  programs = {
    git = {
      userName = lib.mkDefault "sebastian9";
      userEmail = lib.mkDefault "sebastianls0228@gmail.com";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
