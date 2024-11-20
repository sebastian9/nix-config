{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.nixvim;
in {
  programs.nixvim = {
    plugins.dap = {
      enable = !cfg.vscode;

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

      extensions = {
        dap-python = {
          enable = !cfg.vscode;
        };

        dap-ui = {
          enable = !cfg.vscode;

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

        dap-virtual-text = {
          enable = !cfg.vscode;
        };
      };
    };

    # Allow DAP UI to automatically open and close when possible
    extraConfigLua = lib.optionalString (!cfg.vscode) ''
      require('dap').listeners.after.event_initialized['dapui_config'] = require('dapui').open
      require('dap').listeners.before.event_terminated['dapui_config'] = require('dapui').close
      require('dap').listeners.before.event_exited['dapui_config'] = require('dapui').close
    '';

    extraPlugins = [pkgs.vimPlugins.telescope-dap-nvim];
  };
}
