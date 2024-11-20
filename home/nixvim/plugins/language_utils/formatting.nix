{config, ...}: let
  cfg = config.programs.nixvim;
in {
  programs.nixvim.plugins = {
    none-ls = {
      enable = !cfg.vscode;
      sources.formatting = {
        sqlformat.enable = true;
        stylua.enable = true;
        yamlfmt.enable = true;
      };
      sources.diagnostics = {
        trivy.enable = false; # vulnerability scanner
        yamllint.enable = true;
      };
    };

    conform-nvim = {
      enable = !cfg.vscode;

      formatOnSave = {
        lspFallback = false;
        timeoutMs = 500;
      };

      notifyOnError = true;

      formattersByFt = {
        lua = ["stylua"];
        sql = ["sqlformat"];
      };
    };
  };
}
