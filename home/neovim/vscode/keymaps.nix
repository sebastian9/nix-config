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

      # Clipboard
      {
        key = "p";
        action = "\"_dP";
        mode = "v";
        options.desc = "Paste and send to void register; conserving original yank";
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

      # Harpoon
      {
        key = "mj";
        action = "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>";
        mode = ["n" "v"];
        options.desc = "Set harpoon mark";
      }
      {
        key = "<leader>m";
        action = "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>";
        mode = ["n" "v"];
        options.desc = "Show harpoon quick menu";
      }
      {
        key = "<leader>M";
        action = "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>";
        mode = ["n" "v"];
        options.desc = "Edit harpoon marks";
      }
      {
        key = "'j";
        action = "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>";
        mode = ["n" "v"];
        options.desc = "Go to harpoon mark 1";
      }
      {
        key = "'k";
        action = "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>";
        mode = ["n" "v"];
        options.desc = "Go to harpoon mark 2";
      }
      {
        key = "'l";
        action = "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>";
        mode = ["n" "v"];
        options.desc = "Go to harpoon mark 3";
      }
      {
        key = "'m";
        action = "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>";
        mode = ["n" "v"];
        options.desc = "Go to harpoon mark 4";
      }

      # Project Manager
      {
        key = "<leader>pa";
        action = "<cmd>lua require('vscode').action('projectManager.saveProject')<CR>";
        mode = ["n" "v"];
        options.desc = "Save current project";
      }
      {
        key = "<leader>po";
        action = "<cmd>lua require('vscode').action('projectManager.listProjectsNewWindow')<CR>";
        mode = ["n" "v"];
        options.desc = "List projects in a new window";
      }
      {
        key = "<leader>pe";
        action = "<cmd>lua require('vscode').action('projectManager.editProjects')<CR>";
        mode = ["n" "v"];
        options.desc = "Edit projects";
      }
    ];
  };
}
