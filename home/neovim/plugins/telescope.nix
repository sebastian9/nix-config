{...}: {
  programs.nixvim.plugins = {
    telescope = {
      enable = true;

      keymaps = {
        "<leader>/" = "live_grep";
        "<leader>ff" = "git_files";
        "<leader>fF" = "find_files";
        "<leader>fb" = "buffers";
        "<leader>bf" = "buffers";
        "<leader>fc" = "commands";
        "<leader>fk" = "keymaps";
        "<leader>fh" = "help_tags";
        "<leader>fs" = "lsp_dynamic_workspace_symbols";
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
