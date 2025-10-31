{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      v = "nvim";
      cd = "z";
      cat = "bat";
      ll = "ls -l";
      lgrep = "ls -l | grep ";
      hgrep = "history | grep";
      cl = "clear";
      wcl = "wc -l";
      gdl = "git diff HEAD^ HEAD";
      gdll = "git diff HEAD^^ HEAD^";
      gci = "git commit --interactive";
      repo = "gh repo view --web";
      prw = "gh pr view --web";
      prv = "gh pr view --comments";
      gapr = "gh pr create --web --fill --assignee $GITHUB_USER --base";
      pr-search = "gh pr list --state ALL --search ";
      git-pickaxe = "git log --all --pickaxe-all -S ";
      fzf = "fzf --preview \"bat --color=always --style=numbers --line-range=:500 {}\"";
      fvim = "nvim $(fzf)";
      fblame = "git blame $(fzf)";
      fcamunda = "open -a \"Camunda Modeler\" $(fzf)";
      fenv = "printenv | fzf";
      falias = "alias | fzf";
      tma = "tmux a";
      lg = "lazygit";
      editc = "cd \"$CONFIG_DIR\" && nvim";
      cdc = "cd $CONFIG_DIR";
      update = lib.mkDefault ''
        cd $CONFIG_DIR && git add -A && sudo nixos-rebuild switch --flake "$CONFIG_DIR#dell" && cd -
      '';
      update-no-cache = lib.mkDefault ''
        cd $CONFIG_DIR && git add -A && sudo nixos-rebuild switch --flake "$CONFIG_DIR#dell" --no-eval-cache && cd -
      '';
      deploy = ''
        nix run "$CONFIG_DIR" -- -p zima nuc
      '';
      backup = ''
        sudo mount /dev/sda /mnt/usb &&
        sudo rsync -av --i-r --progress --no-owner --no-group /mnt/synology/ /mnt/usb/backup
      '';
      jira = ''
        firefox "https://issues.teslamotors.com/browse/$(git_current_branch | grep -Eoi '\W{4}-\d+')";
      '';
      feel = "amm --predef ~/.config/feel/feel-repl.sc";
      poetry-shell = "eval \"$(poetry env activate)\"";
      dformat = "git diff --staged --name-only | xargs dotnet format --include";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };

    sessionVariables = {
      EDITOR = "nvim";
      ZVM_VI_INSERT_ESCAPE_BINDKEY = "jj"; # zsh-vi-mode escape key
    };

    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    initContent = ''
      # programs.zoxide init option wasn't working
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

      # TODO - move to siteFunctions once home manager is upgraded
      function digitalExperience-Clone  {
        gh repo clone "digital-experience/$1";
      }
    '';
  };
}
