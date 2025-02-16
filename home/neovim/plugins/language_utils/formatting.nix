_: {
  programs.nixvim.plugins = {
    none-ls = {
      enable = true;
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
      enable = true;
      settings = {
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
  };
}
