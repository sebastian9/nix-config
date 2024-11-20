{config, ...}: let
  cfg = config.programs.nixvim;
in {
  programs.nixvim.plugins = {
    lint = {
      enable = !cfg.vscode;
      lintersByFt = {
        lua = ["selene"];
        json = ["jsonlint"];
        bash = ["shellcheck"];
      };
    };
  };
}
