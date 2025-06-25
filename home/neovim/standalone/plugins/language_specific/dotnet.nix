_: {
  programs.nixvim.plugins = {
    # none-ls.sources = {
    #   formatting.csharpier.enable = true;
    # };
    lsp = {
      servers = {
        csharp_ls.enable = true;
        omnisharp = {
          enable = true;

          settings = {
            enableRoslynAnalyzers = true;
            enableEditorConfigSupport = true;
            enableImportCompletion = true;
            sdkIncludePrereleases = true;
            analyzeOpenDocumentsOnly = true;
          };
        };
      };
    };
  };
}
