{ pkgs, ... }:
{
  programs.nixvim = {

    enable = true;

    viAlias = true;

    colorscheme = "midnight";

    opts = {
      mouse = "a";
      relativenumber = true;
      number = true;
      ignorecase = true;
      scrolloff = 8;
      hlsearch = false;
      incsearch = true;
      autoindent = true;
      smartindent = true;
      expandtab = true;
      tabstop = 4;
      softtabstop = 4;
      undofile = true;
      wrap = false;
      swapfile = false;
      backup = false;
      updatetime = 50;
    };

    globals.mapleader = " ";
    keymaps = [
      {
        key = "<leader><Tab>";
        action = ":b#<CR>";
        options.desc = "Alternate buffer";
      }
      {
        key = "<leader>n";
        action = ":Ex<CR>";
        mode = "n";
      }
      {
        key = "<leader>u";
        action = ":UndotreeFocus<CR>";
        mode = "n";
      }
      {
        key = "J";
        action = "mzJ`z";
        mode = "n";
        options.desc = "Keep cursor in place when joining lines";
      }
      {
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        mode = "v";
        options.desc = "Move selection down";
      }
      {
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        mode = "v";
        options.desc = "Move selection down";
      }
      {
        key = "<C-d>";
        action = "<C-d>zz";
        options.desc = "Non-disorienting half-page down";
      }
      {
        key = "<C-u>";
        action = "<C-u>zz";
        options.desc = "Non-disorienting half-page up";
      }
      {
        key = "n";
        action = "nzzzv";
        mode = "n";
        options.desc = "Non-disorienting next search match";
      }
      {
        key = "N";
        action = "Nzzzv";
        mode = "n";
        options.desc = "Non-disorienting next search match";
      }
      {
        key = "<leader>p";
        action = "\"_dP";
        mode = "v";
        options.desc = "Paste and send to void register";
      }
      {
        key = "<leader>y";
        action = "\"+y";
        mode = ["n" "v"];
        options.desc = "Yank selection to system register";
      }
      {
        key = "Y";
        action = "y$";
        mode = "n";
        options.desc = "Fix Y; yank until end of line";
      }
      {
        key = "<leader>d";
        action = "\"_d";
        mode = ["n" "v"];
        options.desc = "Delete to void register";
      }
      {
        key = "<C-c>";
        action = "<Esc>";
        mode = "i";
        options.desc = "So that <C-c> behaves as everywhere else in v-block mode";
      }
      {
        key = "Q";
        action = "<nop>";
        mode = "n";
        options.desc = "Q is a weird place to be";
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      midnight-nvim # color theme
      vim-lastplace
      YouCompleteMe
    ];

    plugins = {

      nix.enable = true;

      lualine.enable = true;

      undotree.enable = true;

      treesitter.enable = true;

      nvim-autopairs.enable = true;

      conform-nvim = {
        enable = true;
        notifyOnError = true;
        formatOnSave = {
          timeoutMs = 500;
          lspFallback = true;
        };
        formattersByFt = {
          python = [ "black" ];
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          rust = [ "rustfmt" ];
          html = [ [ "prettierd" "prettier" ] ];
          css = [ [ "prettierd" "prettier" ] ];
          javascript = [ [ "prettierd" "prettier" ] ];
          javascriptreact = [ [ "prettierd" "prettier" ] ];
          typescript = [ [ "prettierd" "prettier" ] ];
          typescriptreact = [ [ "prettierd" "prettier" ] ];
        };
      };

      lint = {
        enable = false; # TODO: why this fails on nix
        lintersByFt = {
          go = [ "golangci-lint" ];
          nix = [ "statix" ];
          lua = [ "selene" ];
          python = [ "ruff" "mypy" ];
          javascript = [ "eslint_d" ];
          javascriptreact = [ "eslint_d" ];
          typescript = [ "eslint_d" ];
          typescriptreact = [ "eslint_d" ];
          json = [ "jsonlint" ];
          bash = [ "shellcheck" ];
        };
      };

      lsp-format.enable = true;

      lsp = {

        enable = true;

        servers = {
          nixd.enable = true;
        };

        keymaps =  {

          diagnostic = {
            "<leader>en" = "goto_prev";
            "<leader>ep" = "goto_next";
          };

          lspBuf = {
            "gd" = "definition";
            "gD" = "references";
            "gt" = "type_definition";
            "gi" = "implementation";
            "K" = "hover";
          };

        };

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
              "<C-n>".__raw = "require('telescope.actions').move_selection_next";
              "<C-p>".__raw = "require('telescope.actions').move_selection_previous";
            };
          };
        };

      };

    };

  };
}
