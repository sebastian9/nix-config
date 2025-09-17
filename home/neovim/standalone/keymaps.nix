# All keymaps _should_ be here
_: {
  programs.nixvim = {
    globals.mapleader = " ";
    keymaps = [
      # Insert mode
      {
        key = "jj";
        action = "<Esc><cmd>write<CR>";
        mode = "i";
        options.desc = "Escape insert mode with jj and save";
      }

      # Normal mode
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
        key = "<leader><M-c>";
        action = ''
          :exe "!code " .. shellescape(expand("%"))<CR>
        '';
        mode = "n";
        options.desc = "Open file in vscode";
      }
      {
        key = "<leader><M-C>";
        action = ''
          :exe "!code " .. shellescape(expand(getcwd()))<CR>
        '';
        mode = "n";
        options.desc = "Open project in vscode";
      }
      {
        key = "<leader>et";
        action =  ":lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<CR>";
        mode = "n";
        options.desc = "Toogle Diagnostics";
      }
      # Editing
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

      # View
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

      # Clipboard
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
        key = "<leader>y";
        action = "<cmd>execute setreg('+',getreg('\"'))<CR>";
        mode = "n";
        options.desc = ''
          Set system register to last deleted, changed or yanked content
        '';
      }
      {
        key = "<leader>by";
        action = "<cmd>execute setreg('+',getreg('%'))<CR>";
        mode = "n";
        options.desc = ''
          Set system register to the file path and name
        '';
      }
      {
        key = "Y";
        action = "y$";
        mode = "n";
        options.desc = "Fix Y; yank until end of line";
      }
      {
        key = "<leader>D"; # d is the debugging group
        action = "\"_d";
        mode = ["n" "v"];
        options.desc = "Delete to void register";
        # can use a motion after eg <leader>dw
      }

      # "Fixes"
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
        mode = "n";
        # Set highlight on search, but clear on pressing <C-c> in normal mode
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }

      # Search and replace
      {
        key = "<leader>s";
        action = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>";
        mode = ["n" "v"];
        options.desc = "Substitute selection";
      }

      # Buffers
      {
        key = "<leader><Tab>";
        action = ":b#<CR>";
        options.desc = "Alternate buffer";
      }
      {
        key = "<leader>bd";
        action = ":bd<CR>";
        options.desc = "Close Buffer";
      }

      # LspSaga
      {
        key = "<leader>jv";
        action = "<cmd>Lspsaga outline<CR>";
        mode = "n";
        options.desc = "Jump to outline/variables";
      }
      {
        key = "<leader>K";
        action = "<cmd>Lspsaga hover_doc<CR>";
        mode = "n";
        options.desc = "Hover using LspSaga";
      }
      {
        key = "<leader>mr";
        action = "<cmd>Lspsaga lsp_rename ++project<CR>";
        mode = "n";
        options.desc = "Rename";
      }
      {
        key = "gd";
        action = "<cmd>Lspsaga goto_definition<CR>";
        mode = "n";
        options.desc = "Go to Definition";
      }
      {
        key = "gD";
        action = "<cmd>Lspsaga finder ++normal<CR>";
        mode = "n";
        options.desc = "Go to References";
      }
      {
        key = "<leader>!";
        action = "<cmd>Lspsaga term_toggle<CR>";
        mode = "n";
        options.desc = "Open float terminal";
      }
      {
        key = "<leader>en";
        action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
        mode = "n";
        options.desc = "Next diagnostic";
      }
      {
        key = "[e";
        action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
        mode = "n";
        options.desc = "Next diagnostic";
      }
      {
        key = "<leader>ep";
        action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
        mode = "n";
        options.desc = "Previous diagnostic";
      }
      {
        key = "]e";
        action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
        mode = "n";
        options.desc = "Previous diagnostic";
      }


      # Remaps for dealing with word wrap and adding jumps to the jumplist.
      # TODO - understand this
      {
        mode = "n";
        key = "j";
        action.__raw = "
          [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']]
        ";
        options = {
          expr = true;
          desc = "Remap for dealing with word wrap and adding jumps to the jumplist.";
        };
      }

      {
        mode = "n";
        key = "k";
        action.__raw = "
          [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']]
        ";
        options = {
          expr = true;
          desc = "Remap for dealing with word wrap and adding jumps to the jumplist.";
        };
      }

      # DAP Telescope Actions
      {
        mode = "n";
        key = "<leader>d/c";
        action = "<CMD>Telescope dap commands<CR>";
        options.desc = "Search Commands";
      }
      {
        mode = "n";
        key = "<leader>d/b";
        action = "<CMD>Telescope dap list_breakpoints<CR>";
        options.desc = "Search Breakpoints";
      }
      {
        mode = "n";
        key = "<leader>d/v";
        action = "<CMD>Telescope dap variables<CR>";
        options.desc = "Search Variables";
      }
      {
        mode = "n";
        key = "<leader>d/f";
        action = "<CMD>Telescope dap frames<CR>";
        options.desc = "Search Frames";
      }

      # Debugging
      {
        mode = "n";
        key = "<leader>dB";
        action = "
            <cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>
          ";
        options = {
          silent = true;
          desc = "Breakpoint Condition";
        };
      }
      {
        mode = "n";
        key = "<leader>db";
        action = ":DapToggleBreakpoint<cr>";
        options = {
          silent = true;
          desc = "Toggle Breakpoint";
        };
      }
      {
        mode = "n";
        key = "<leader>dc";
        action = ":DapContinue<cr>";
        options = {
          silent = true;
          desc = "Continue";
        };
      }
      {
        mode = "n";
        key = "<leader>da";
        action = "<cmd>lua require('dap').continue({ before = get_args })<cr>";
        options = {
          silent = true;
          desc = "Run with Args";
        };
      }
      {
        mode = "n";
        key = "<leader>dC";
        action = "<cmd>lua require('dap').run_to_cursor()<cr>";
        options = {
          silent = true;
          desc = "Run to cursor";
        };
      }
      {
        mode = "n";
        key = "<leader>dg";
        action = "<cmd>lua require('dap').goto_()<cr>";
        options = {
          silent = true;
          desc = "Go to line (no execute)";
        };
      }
      {
        mode = "n";
        key = "<leader>di";
        action = ":DapStepInto<cr>";
        options = {
          silent = true;
          desc = "Step into";
        };
      }
      {
        mode = "n";
        key = "<leader>dj";
        action = "
            <cmd>lua require('dap').down()<cr>
          ";
        options = {
          silent = true;
          desc = "Down";
        };
      }
      {
        mode = "n";
        key = "<leader>dk";
        action = "<cmd>lua require('dap').up()<cr>";
        options = {
          silent = true;
          desc = "Up";
        };
      }
      {
        mode = "n";
        key = "<leader>dl";
        action = "<cmd>lua require('dap').run_last()<cr>";
        options = {
          silent = true;
          desc = "Run Last";
        };
      }
      {
        mode = "n";
        key = "<leader>do";
        action = ":DapStepOut<cr>";
        options = {
          silent = true;
          desc = "Step Out";
        };
      }
      {
        mode = "n";
        key = "<leader>dO";
        action = ":DapStepOver<cr>";
        options = {
          silent = true;
          desc = "Step Over";
        };
      }
      {
        mode = "n";
        key = "<leader>dp";
        action = "<cmd>lua require('dap').pause()<cr>";
        options = {
          silent = true;
          desc = "Pause";
        };
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = ":DapToggleRepl<cr>";
        options = {
          silent = true;
          desc = "Toggle REPL";
        };
      }
      {
        mode = "n";
        key = "<leader>ds";
        action = "<cmd>lua require('dap').session()<cr>";
        options = {
          silent = true;
          desc = "Session";
        };
      }
      {
        mode = "n";
        key = "<leader>dt";
        action = ":DapTerminate<cr>";
        options = {
          silent = true;
          desc = "Terminate";
        };
      }
      {
        mode = "n";
        key = "<leader>du";
        action = "<cmd>lua require('dapui').toggle()<cr>";
        options = {
          silent = true;
          desc = "Dap UI";
        };
      }
      {
        mode = "n";
        key = "<leader>dw";
        action = "<cmd>lua require('dap.ui.widgets').hover()<cr>";
        options = {
          silent = true;
          desc = "Widgets";
        };
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>de";
        action = "<cmd>lua require('dapui').eval()<cr>";
        options = {
          silent = true;
          desc = "Eval";
        };
      }
      {
        mode = "n";
        key = "<leader>df";
        action = "<CMD>lua require('dap.ext.vscode').load_launchjs()<CR><CMD>Telescope dap configurations<CR>";
        options = {
          silent = true;
          desc = "Debug Configurations";
        };
      }
    ];
    plugins = {
      # Live keymap cheatsheet
      which-key.enable = true; # TODO add groups per fred-drake's example
      telescope.keymaps = {
        "<leader>/" = "live_grep theme=dropdown";
        "<leader>ff" = "git_files";
        "<leader>fF" = "find_files";
        "<leader>fr" = "oldfiles";
        "<leader>fc" = "commands";
        "<leader>fk" = "keymaps";
        "<leader>fh" = "help_tags theme=dropdown";
        "<leader>fs" = "lsp_dynamic_workspace_symbols theme=dropdown";
        "<leader>fS" = "lsp_document_symbols theme=dropdown";
        "<leader>fp" = "projects";
        # "gD" = "lsp_references theme=dropdown";
      };
      lsp.keymaps = {
        silent = false;
        lspBuf = {
          "gd" = "definition";
          "gt" = "type_definition";
          "gi" = "implementation";
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
