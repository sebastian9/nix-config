{config, ...}: let
  cfg = config.programs.nixvim;
in {
  programs.nixvim.plugins = {
    lsp.enable = !cfg.vscode;
    lsp-format.enable = false;
  };
}
