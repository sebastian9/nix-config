# Most keymaps that are not plugin specific are here
{...}: {
  programs.nixvim = {
    globals.mapleader = " ";
    keymaps = [
      {
        key = "<leader><Tab>";
        action = ":b#<CR>";
        options.desc = "Alternate buffer";
      }
      {
        key = "<leader>n";
        # open directory of current file (in a last used state)
        # with focus on that file
        action = ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>";
        mode = "n";
        options.desc = "Open file manager";
      }
      {
        key = "<leader>u";
        action = ":UndotreeShow<CR>";
        mode = "n";
      }
      {
        key = "J";
        # mark z, join and go to z
        action = "mzJ`z";
        mode = "n";
        options.desc = "Keep cursor in place when joining lines";
      }
      {
        key = "J";
        action = ":m '>+1<CR>gv=gv"; # keep selection
        mode = "v";
        options.desc = "Move selection down";
      }
      {
        key = "K";
        action = ":m '<-2<CR>gv=gv"; # keep selection
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
        mode = "v";
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
        # can use a motion after eg <leader>dw
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
    plugins = {
      # Live keymap cheatsheet
      which-key.enable = true;
      harpoon.keymaps = {
        # m is the native set mark key
        # ' is  the native mark motion
        # j is the first mark
        # h is too far away from '
        addFile = "mj";
        toggleQuickMenu = "<leader>me";
        navFile = {
          "1" = "'j";
          "2" = "'k";
          "3" = "'l";
          "4" = "'m";
        };
      };
      telescope.keymaps = {
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
      lsp.keymaps = {
        silent = false;
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
          "<leader>mr" = "rename"; # vspacecode
        };
      };
      cmp.settings.mapping = let
        selectOpts = "{behavior = cmp.SelectBehavior.Select}";
      in {
        "<Up>" = "cmp.mapping.select_prev_item(${selectOpts})";
        "<Down>" = "cmp.mapping.select_next_item(${selectOpts})";

        "<C-p>" = "cmp.mapping.select_prev_item(${selectOpts})";
        "<C-n>" = "cmp.mapping.select_next_item(${selectOpts})";

        "<C-u>" = "cmp.mapping.scroll_docs(-4)";
        "<C-d>" = "cmp.mapping.scroll_docs(4)";

        "<Esc>" = "cmp.mapping.abort()";
        "<C-e>" = "cmp.mapping.abort()";

        "<C-y>" = "cmp.mapping.confirm({select = true})";
        "<CR>" = "cmp.mapping.confirm({select = false})";

        "<C-f>" = ''
          cmp.mapping(
            function(fallback)
              if luasnip.jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end,
            { "i", "s" }
          )
        '';

        "<C-b>" = ''
          cmp.mapping(
            function(fallback)
              if luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end,
            { "i", "s" }
          )
        '';

        "<Tab>" = ''
          cmp.mapping(
            function(fallback)
              local col = vim.fn.col('.') - 1

              if cmp.visible() then
                cmp.select_next_item(select_opts)
              elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
              else
                cmp.complete()
              end
            end,
            { "i", "s" }
          )
        '';

        "<S-Tab>" = ''
          cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.select_prev_item(select_opts)
              else
                fallback()
              end
            end,
            { "i", "s" }
          )
        '';
      };
    };
  };
}
