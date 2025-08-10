{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      dap = {
        enable = true;

        signs = {
          dapBreakpoint = {
            text = "●";
            texthl = "DapBreakpoint";
          };
          dapBreakpointCondition = {
            text = "";
            texthl = "DapBreakpointCondition";
          };
          dapLogPoint = {
            text = "◆";
            texthl = "DapLogPoint";
          };
        };
      };

      dap-virtual-text = {
        enable = true;
      };

      dap-python = {
        enable = true;
      };

      dap-ui = {
        enable = true;
        settings = {
          floating.mappings = {
            close = [
              "<ESC>"
              "q"
            ];
          };
          icons = {
            expanded = "▾";
            collapsed = "▸";
            current_frame = "*";
          };
          controls = {
            icons = {
              pause = "⏸";
              play = "▶";
              step_into = "⏎";
              step_over = "⏭";
              step_out = "⏮";
              step_back = "b";
              run_last = "▶▶";
              terminate = "⏹";
              disconnect = "⏏";
            };
          };
        };
      };
    };

    # Allow DAP UI to automatically open and close when possible
    extraConfigLua = ''
      require('dap').listeners.after.event_initialized['dapui_config'] = require('dapui').open
      require('dap').listeners.before.event_terminated['dapui_config'] = require('dapui').close
      require('dap').listeners.before.event_exited['dapui_config'] = require('dapui').close
    '';

    extraPlugins = [pkgs.vimPlugins.telescope-dap-nvim];
  };
}
