_: {
  # Thanks Gaetan
  programs = {
    nixvim = {
      plugins = {
        conform-nvim.formattersByFt = {
          python = [
            "black"
          ];
        };
        lint.lintersByFt.python = [
          "mypy"
          "ruff"
        ];
        lsp.servers = {
          pylsp = {
            enable = true;
            settings.plugins = {
              jedi_completion.fuzzy = true;
              black.enabled = true;
              ruff.enabled = true;
              pylsp_mypy = {
                enabled = true;
                dmypy = true;
                report_progress = true;
              };
            };
          };
        };
      };
    };
  };
}
