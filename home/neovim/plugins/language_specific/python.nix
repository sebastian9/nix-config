_: {
  programs.nixvim.plugins = {
    # Formatting
    none-ls.sources = {
      formatting = {
        black.enable = true;
      };
    };
    conform-nvim.formattersByFt = {
      python = [
        "black"
      ];
    };

    # Linting
    lint.lintersByFt = {
      python = ["ruff" "mypy" "pylint"];
    };

    # Language
    lsp.servers.pylsp = {
      enable = true;
      settings.plugins = {
        black.enabled = true;
        ruff.enabled = true;
        pylint.enabled = true;
        pylsp_mypy = {
          enabled = true;
          dmypy = true;
          report_progress = true;
        };
        # isort.enabled = true;
        # TODO - curate below
        # mccabe.enabled = true;
        # pycodestyle.enabled = true;
        # pydocstyle.enabled = true;
        # pyflakes.enabled = true;
        # rope.enabled = true;
        # yapf.enabled = true;
      };
    };
  };
}
