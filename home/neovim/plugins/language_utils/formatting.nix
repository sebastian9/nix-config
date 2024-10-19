{...}: {
  programs.nixvim.plugins = {
    none-ls = {
      enable = true;
      sources.formatting = {
        prettier.enable = true;
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

      formatOnSave = {
        lspFallback = true;
        timeoutMs = 500;
      };

      notifyOnError = true;

      formattersByFt = {
        lua = ["stylua"];
        yaml = ["yamlfmt"];
        json = [["prettierd" "prettier"]];
        sql = ["sqlformat"];
      };
    };
  };
}
