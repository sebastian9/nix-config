{ pkgs, ... }:
{
  programs.nixvim = {

    enable = true;

    opts = {
      mouse = "a";
      relativenumber = true;
      number = true;
      ignorecase = true;
    };

    globals.mapleader = " ";
    keymaps = [
      {
        key = "<leader><Tab>";
        action = ":b#<CR>";
      }
      {
        key = "<leader>n";
        action = ":Ex<CR>";
      }
    ];


    colorscheme = "midnight";

    extraPlugins = with pkgs.vimPlugins; [
      midnight-nvim # color theme
      vim-lastplace
      YouCompleteMe
    ];

    plugins = {

      nix.enable = true;

      lualine.enable = true;

      treesitter = {
        enable = true;
      };

      telescope = {

        enable = true;

        keymaps = {
          "<leader>/" = "live_grep";
          "<C-p>" = "git_files"; # respects git_ignore
          "<leader>ff" = "find_files";
          "<leader>fb" = "buffers";
          "<leader>fc" = "commands";
          "<leader>fk" = "keymaps";
          "<leader>fm" = "marks";
          "<leader>fh" = "help_tags";
        };

        defaults = {
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
              "<C-j>".__raw = "require('telescope.actions').move_selection_next";
              "<C-k>".__raw = "require('telescope.actions').move_selection_previous";
            };
          };
        };

      };

    };

  };
}
