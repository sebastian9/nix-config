_: {
  programs.nixvim.plugins = {
    web-devicons.enable = true;
    telescope = {
      enable = true;
      extensions = {
        fzf-native = {
          enable = true;
          settings = {
            fuzzy = true;
            override_generic_sorter = true;
            override_file_sorter = true;
            case_mode = "smart_case";
          };
        };
        ui-select = {
          enable = true;
          settings = {
            specific_opts = {
              codeactions = true;
            };
          };
        };
      };
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
