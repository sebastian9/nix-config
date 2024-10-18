# TODO - connect somewhere and move all python stuff here
{
  plugins = {
    conform-nvim = {
      enable = true;
      settings = {formatters_by_ft.python = ["black"];};
    };
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
    none-ls.sources.formatting.black.enable = true;
  };
}
