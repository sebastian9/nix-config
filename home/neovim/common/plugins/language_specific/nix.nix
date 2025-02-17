_: {
  programs.nixvim.plugins = {
    # Formatting
    none-ls.sources = {
      formatting.alejandra.enable = true;
      diagnostics.statix.enable = true;
    };
    conform-nvim.settings = {
      enable = true;
      formattersByFt = {
        nix = ["alejandra"];
      };
    };

    # Linting
    lint.lintersByFt = {
      nix = ["statix"];
    };

    # Language
    lsp = {
      servers = {
        nixd.enable = true;
      };
    };
  };
}
