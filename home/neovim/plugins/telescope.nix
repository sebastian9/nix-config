{...}: {
  programs.nixvim.plugins = {
    telescope = {
      enable = true;
      settings.defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "%.ipynb"
        ];
        set_env.colorterm = "truecolor";
        selection_caret = "> ";
        mappings = {
          i = {
            "<C-n>".__raw = "require('telescope.actions').move_selection_next";
            "<C-p>".__raw = "require('telescope.actions').move_selection_previous";
          };
        };
      };
    };
  };
}
