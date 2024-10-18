{pkgs, ...}: {
  programs.nixvim.plugins.dap = {
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

    extensions = {
      dap-python = {
        enable = true;
      };
      dap-ui = {
        enable = true;
        floating.mappings = {
          close = [
            "<ESC>"
            "q"
          ];
        };
      };
      dap-virtual-text = {
        enable = true;
      };
    };

    configurations = {
      # java = [
      #   {
      #     type = "java";
      #     request = "launch";
      #     name = "Debug (Attach) - Remote";
      #     hostName = "127.0.0.1";
      #     port = 5005;
      #   }
      # ];
    };

    # Allow DAP UI to automatically open and close when possible
    extraConfigLua = ''
      require('dap').listeners.after.event_initialized['dapui_config'] = require('dapui').open
      require('dap').listeners.before.event_terminated['dapui_config'] = require('dapui').close
      require('dap').listeners.before.event_exited['dapui_config'] = require('dapui').close
    '';

    extraPlugins = [(pkgs.vimPlugins.telescope-dap-nvim)];
  };
}
