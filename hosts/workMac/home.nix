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

  home = {
    sessionPath = [
      "$HOME/.pyenv/bin"
      "$HOME/.nvm"
      "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
      "opt/homebrew/opt/openjdk/bin"
      "/Users/slopezsanchez/.local/bin"
    ];
    file.".config/feel/feel-repl.sc" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/camunda/feel-scala/master/feel-repl.sc";
        sha256 = "sha256-rQL8JfNBCaNYOhqFGfGYKcwMsnspPY9MfM/tcJagkWk=";
      };
    };
  };

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
        gapr = "gh pr create --web --fill --assignee slopezsanchez --base";
        jira = ''
          open -a Firefox "https://issues.teslamotors.com/browse/$(git_current_branch | grep -Eoi 'RESI-\d+')";
        '';
        feel = "amm --predef ~/.config/feel/feel-repl.sc";
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
