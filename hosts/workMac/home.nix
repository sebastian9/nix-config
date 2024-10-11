{ config, pkgs, user, host_alias, ... }:

{

  imports = [
    ./packages.nix # standalone packages

    # software configs
    ../../home/zsh.nix
    ../../home/git.nix
    ../../home/vim.nix
    ../../home/kitty.nix
  ];

  home.sessionPath = [
    "$HOME/.pyenv/bin"
    "$HOME/.nvm"
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    "opt/homebrew/opt/openjdk/bin"
    "/Users/slopezsanchez/.local/bin"
  ];

  # Extra shell aliases for this machine/darwin
  programs.zsh = {
    shellAliases = {
      firefox = "open -a Firefox";
      excel = "open -a 'Microsoft Excel'";
      cdcode = "cd \"/Users/slopezsanchez/OneDrive - Tesla/code/\"";
      cdspec = "cd \"/Users/slopezsanchez/OneDrive - Tesla/code/solarapp/spec\"";
      cdebt = "cd \"/Users/slopezsanchez/OneDrive - Tesla/code/tesla/energy-business-tools\"";
      update = ''
        cd $CONFIG_DIR && git add -A && sudo darwin-rebuild switch --flake .#${host_alias} && cd -
      '';
    };
  };

  programs.kitty.font.size = 20;

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
