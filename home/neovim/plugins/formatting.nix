{ ... }:
{

  programs.nixvim.plugins = {

      none-ls = {
        enable = true;
        sources.formatting = {
          alejandra.enable = true;
          black.enable = true;
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
          nix = ["alejandra"];
          python = ["isort" "black"];
          lua = ["stylua"];
          yaml = ["yamlfmt"];
          html = [ [ "prettierd" "prettier" ] ];
          css = [ [ "prettierd" "prettier" ] ];
          json = [ [ "prettierd" "prettier" ] ];
          javascript = [ [ "prettierd" "prettier" ] ];
          javascriptreact = [ [ "prettierd" "prettier" ] ];
          typescript = [ [ "prettierd" "prettier" ] ];
          typescriptreact = [ [ "prettierd" "prettier" ] ];
        };
      };

    };

}
