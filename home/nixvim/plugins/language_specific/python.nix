{config, ...}: let
  cfg = config.programs.nixvim;
in {
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
            enable = !cfg.vscode;
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
