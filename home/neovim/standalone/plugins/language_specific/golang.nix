_: {
  programs.nixvim.plugins = {
    none-ls.sources = {
      formatting.gofmt.enable = true;
      diagnostics.golangci_lint.enable = true;
    };
    lsp = {
      servers = {
        gopls.enable = true;
        golangci_lint_ls.enable = true;
      };
    };
  };
}
