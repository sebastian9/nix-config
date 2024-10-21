_: {
  programs.nixvim.plugins = {
    # Formatting
    none-ls.sources.formatting = {
      prettier = {
        enable = false;
        disableTsServerFormatter = false;
      };
    };
    conform-nvim.formattersByFt = {
      html = [["prettierd" "prettier"]];
      css = [["prettierd" "prettier"]];
      javascript = [["prettierd" "prettier"]];
      javascriptreact = [["prettierd" "prettier"]];
      typescript = [["prettierd" "prettier"]];
      typescriptreact = [["prettierd" "prettier"]];
    };

    # Linting
    lint.lintersByFt = {
      javascript = ["eslint_d"];
      javascriptreact = ["eslint_d"];
      typescript = ["eslint_d"];
      typescriptreact = ["eslint_d"];
    };

    # Language
    lsp.servers = {
      eslint.enable = true;
      # TODO - solve error with ts-ls "does not exist"
      # ts-ls = {
      #   enable = true;
      #   filetypes = [
      #     "javascript"
      #     "javascriptreact"
      #     "typescript"
      #     "typescriptreact"
      #   ];
      #   extraOptions = {
      #     settings = {
      #       javascript = {
      #         inlayHints = {
      #           includeInlayEnumMemberValueHints = true;
      #           includeInlayFunctionLikeReturnTypeHints = true;
      #           includeInlayFunctionParameterTypeHints = true;
      #           includeInlayParameterNameHints = "all";
      #           includeInlayParameterNameHintsWhenArgumentMatchesName = true;
      #           includeInlayPropertyDeclarationTypeHints = true;
      #           includeInlayVariableTypeHints = true;
      #         };
      #       };
      #       typescript = {
      #         inlayHints = {
      #           includeInlayEnumMemberValueHints = true;
      #           includeInlayFunctionLikeReturnTypeHints = true;
      #           includeInlayFunctionParameterTypeHints = true;
      #           includeInlayParameterNameHints = "all";
      #           includeInlayParameterNameHintsWhenArgumentMatchesName = true;
      #           includeInlayPropertyDeclarationTypeHints = true;
      #           includeInlayVariableTypeHints = true;
      #         };
      #       };
      #     };
      #   };
      # };
    };
  };
}
