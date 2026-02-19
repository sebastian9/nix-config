{pkgs, ...}: {
  programs.nixvim.plugins = {
    none-ls.sources = {
      formatting.csharpier.enable = true;
    };
    lsp = {
      servers = {
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
        csharp_ls = {
          enable = pkgs.stdenv.hostPlatform.system != "aarch64-darwin";
        };
      };
    };
  };
}
