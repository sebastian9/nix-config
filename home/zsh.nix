{ config, pkgs, ... }:
{
  programs.zsh = {

    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      cl = "clear";
      gdl = "git diff HEAD^ HEAD";
      editc = "cd \"$CONFIG_DIR\" && vim -c :Files .";
      cdc = "cd $CONFIG_DIR";
      update = ''
        sudo nixos-rebuild switch --flake "$CONFIG_DIR#dell"
      '';
      deploy = ''
        nix run "$CONFIG_DIR" -- nuc
      '';
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "gnzh";
    };

  };
}
