{ pkgs, ... }:

{

  imports = [
    ./plugins/telescope.nix
    ./plugins/cmp.nix
    ./plugins/formatting.nix
    ./plugins/harpoon.nix
  ];

  programs.nixvim = {

    enable = true;

    viAlias = true;

    vimAlias = true;

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
        options.desc = "Worst place in the universe";
      }
      {
        key = "<leader>s";
        action = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>";
        mode = "n";
        options.desc = "Substitute selection";
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      midnight-nvim # color theme
      vim-tmux-navigator
    ];

    plugins = {

      nix.enable = true;

      lualine.enable = true;

      lastplace.enable = true;

      undotree.enable = true;

      dap.enable = true;

      treesitter.enable = true;

      nvim-autopairs.enable = true;

      lint = {
        enable = true;
        lintersByFt = {
          go = [ "golangci-lint" ];
          # nix = [ "statix" ]; # TODO: why this fails on nix
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

      lsp = {

        enable = true;

        servers = {
          nixd.enable = true;
        };

        keymaps =  {

          silent = true;

          diagnostic = {
            "<leader>[e" = "goto_prev";
            "<leader>]e" = "goto_next";
          };

          lspBuf = {
            "gd" = "definition";
            "gD" = "references";
            "gt" = "type_definition";
            "gi" = "implementation";
            "K" = "hover";
            "<leader>r" = "rename";
          };

        };

      };

    };

  };
}
