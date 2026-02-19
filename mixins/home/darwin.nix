{
  user,
  host_alias,
  ...
}: {
  home = {
    homeDirectory = "/Users/${user}";
    sessionPath = [
      "$HOME/.pyenv/bin"
      "$HOME/.nvm"
      "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
      "opt/homebrew/opt/openjdk/bin"
      "/Users/slopezsanchez/.local/bin"
    ];
  };

  programs = {
    zsh = {
      sessionVariables = {
        CONFIG_DIR = "/Users/${user}/.config/nix-config/";
      };
      # Extra shell aliases for this machine/darwin
      shellAliases = {
        firefox = "open -a Firefox";
        excel = "open -a 'Microsoft Excel'";
        update = ''
          cd $CONFIG_DIR && git add -A && sudo darwin-rebuild switch --flake .#${host_alias} && cd -
        '';
        install-nix-darwin = ''
          sudo nix run nix-darwin/nix-darwin-24.11#darwin-rebuild -- switch; update
        '';
      };
    };
  };

  programs.kitty.font.size = 20;
}
