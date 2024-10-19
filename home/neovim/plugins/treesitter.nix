{...}: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      indent = true;
      folding = false; # for now, folds by default and it's annoying
      # nixvim specific injections, like lua highlighting in extraConfigLua
      nixvimInjections = true;
      # highlight.enable = true; # needed in unstable
      # autopairs = true; # not available yet
      # auto_install = true;
      # TODO what is this?
      # incremental_selection = {
      #   enable = true;
      #   keymaps = {
      #     init_selection = "<C-space>";
      #     node_incremental = "<C-space>";
      #     scope_incremental = false;
      #     node_decremental = "<bs>";
      #   };
      # };
    };

    treesitter-textobjects = {
      enable = true;
      select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "aa" = "@parameter.outer";
          "ia" = "@parameter.inner";
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
          "ii" = "@conditional.inner";
          "ai" = "@conditional.outer";
          "il" = "@loop.inner";
          "al" = "@loop.outer";
          "at" = "@comment.outer";
        };
      };
      move = {
        enable = true;
        gotoNextStart = {
          "]m" = "@function.outer";
          "]]" = "@class.outer";
        };
        gotoNextEnd = {
          "]M" = "@function.outer";
          "][" = "@class.outer";
        };
        gotoPreviousStart = {
          "[m" = "@function.outer";
          "[[" = "@class.outer";
        };
        gotoPreviousEnd = {
          "[M" = "@function.outer";
          "[]" = "@class.outer";
        };
      };
      # TODO what is this?
      swap = {
        enable = true;
        swapNext = {
          "<leader>a" = "@parameters.inner";
        };
        swapPrevious = {
          "<leader>A" = "@parameter.outer";
        };
      };
    };

    ts-autotag = {
      enable = true;
    };

    treesitter-context = {
      enable = true;
    };

    # TODO does this replace mini.comment?
    ts-context-commentstring = {
      enable = true;
      disableAutoInitialization = false;
    };
  };
}
