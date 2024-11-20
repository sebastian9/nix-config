{config, ...}: let
  cfg = config.programs.nixvim;
in {
  programs.nixvim.plugins = {
    cmp = {
      enable = !cfg.vscode;
      settings = {
        autoEnableSources = true;
        performance = {
          debounce = 150;
        };
        sources = [
          {name = "path";}
          {
            name = "nvim_lsp";
            keywordLength = 1;
          }
          {
            name = "buffer";
            keywordLength = 3;
          }
        ];
        formatting = {
          fields = [
            "menu"
            "abbr"
            "kind"
          ];
          format = ''
            function(entry, item)
              local menu_icon = {
                nvim_lsp = '🔧',
                luasnip = '✂️',
                buffer = '📄',
                path = '🗂️',
              }

              item.menu = menu_icon[entry.source.name]
              return item
            end
          '';
        };
        window = {
          completion = {
            border = "rounded";
            winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None";
            zindex = 1001;
            scrolloff = 0;
            colOffset = 0;
            sidePadding = 1;
            scrollbar = true;
          };
          documentation = {
            border = "rounded";
            winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None";
            zindex = 1001;
            maxHeight = 20;
          };
        };
      };
    };
    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-treesitter.enable = true;
  };
}
