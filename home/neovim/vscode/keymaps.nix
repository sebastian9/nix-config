# All keymaps _should_ be here
_: {
  programs.nixvim = {
    globals.mapleader = ","; # Need a dedicated leader, vspacecode uses <space>
    keymaps = [
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
        key = "Y";
        action = "y$";
        mode = "n";
        options.desc = "Fix Y; yank until end of line";
      }
      {
        key = "<leader>d"; # d is the debugging group
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
        key = "<C-c>";
        action = "<cmd>nohlsearch<CR>";
      }

      # Search and replace
      {
        key = "<leader>s";
        action = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>";
        mode = ["n" "v"];
        options.desc = "Substitute selection";
      }

    ];
    plugins = {
      # Live keymap cheatsheet
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
    };
  };
}
