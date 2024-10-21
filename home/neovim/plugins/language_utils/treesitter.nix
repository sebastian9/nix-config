_: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      indent = true;
      folding = false; # for now, needs plugin to tag along
      # highlight.enable = true; # needed in unstable
      # autopairs = true; # not available yet

      # nixvim specific injections, like lua highlighting in extraConfigLua
      nixvimInjections = true;

      # incremental selection based on the named nodes from the grammar
      incrementalSelection = {
        enable = true;
        keymaps = {
          initSelection = "gnn";
          nodeIncremental = "grn";
          scopeIncremental = "grc";
          nodeDecremental = "grm";
        };
      };
    };
    treesitter-textobjects = {
      enable = true;
      # Define your own text objects mappings similar to `ip` (inner paragraph) and `ap`
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
      # Go to previous/next TS text objects
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
      # Swap TS nodes around
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

    # Auto-close and auto-rename html tags
    ts-autotag = {
      enable = true;
    };

    # Show code context (function, class, list, etc)
    # on top of window
    treesitter-context = {
      enable = true;
      settings = {
        max_lines = 2;
        min_window_height = 0;
        multiline_threshold = 20;
        line_numbers = true;
        trim_scope = "outer";
        mode = "cursor";
        zindex = 20;
      };
    };

    # This plugin only changes the commentstring setting.
    # It does not add any mappings for commenting.
    # It does not replace mini.comment
    ts-context-commentstring = {
      enable = true;
      disableAutoInitialization = false;
    };
  };
}
