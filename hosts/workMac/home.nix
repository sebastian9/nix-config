{
  pkgs,
  lib,
  host_alias,
  ...
}: {
  imports = [
    ./packages.nix # standalone packages

    # software configs
    ../../home/zsh.nix
    ../../home/git.nix
    ../../home/vim.nix
    ../../home/kitty.nix
    ../../home/tmux.nix
    ../../home/navi.nix
    ../../home/modern_unix.nix
    ../../home/neovim/standalone
  ];

  home.sessionPath = [
    "$HOME/.pyenv/bin"
    "$HOME/.nvm"
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    "opt/homebrew/opt/openjdk/bin"
    "/Users/slopezsanchez/.local/bin"
  ];

  programs = {
    zsh = {
      sessionVariables.EDITOR = "nvim";
      # Extra shell aliases for this machine/darwin
      shellAliases = {
        firefox = "open -a Firefox";
        excel = "open -a 'Microsoft Excel'";
        code = "code .";
        update = ''
          cd $CONFIG_DIR && git add -A && sudo darwin-rebuild switch --flake .#${host_alias} && cd -
        '';
        install-nix-darwin = ''
          sudo nix run nix-darwin/nix-darwin-24.11#darwin-rebuild -- switch; update
        '';
        gstr = "gh pr status";
        gcop = "gh pr checkout";
        gapr = "gh pr create --web --fill --assignee slopezsanchez --base";
        prw = "gh pr view --web";
        prv = "gh pr view --comments";
        gdp = "gh pr diff";
        jira = ''
          open -a Firefox "https://issues.teslamotors.com/browse/$(git_current_branch | grep -Eoi 'RESI-\d+')";
        '';
      };
      initExtra = ''
        # programs.zoxide init option wasn't working
        eval "$(${pkgs.zoxide}/bin/zoxide init zsh)";
        source ~/teleport-ssh-config/teleport-functions;
      '';
    };

    git = {
      userName = lib.mkDefault "sebastian9";
      userEmail = lib.mkDefault "sebastianls0228@gmail.com";
    };

    tmux = {
      shell = "/etc/profiles/per-user/slopezsanchez/bin/zsh";
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
