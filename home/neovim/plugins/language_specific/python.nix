{...}: {
  programs.nixvim.plugins = {
    # Formatting
    none-ls.sources.formatting = {
      black.enable = true;
      isort.enable = true;
    };
    conform-nvim.formattersByFt = {
      python = ["isort" "black"];
    };

    # Linting
    lint.lintersByFt = {
      python = ["ruff" "mypy" "pylance"];
    };

    # Language
    lsp.servers.pylsp = {
      enable = true;
      settings.plugins = {
        black.enabled = true;
        ruff.enabled = true;
        isort.enabled = true;
        # TODO - curate below
        jedi.enabled = true;
        mccabe.enabled = true;
        pycodestyle.enabled = true;
        pydocstyle.enabled = true;
        pyflakes.enabled = true;
        pylint.enabled = true;
        rope.enabled = true;
        yapf.enabled = true;
      };
    };
  };
}
