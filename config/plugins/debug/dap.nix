{
  plugins = {
    dap-virtual-text.enable = true;
    dap = {
      enable = true;
      signs = {
        dapBreakpoint = {
          text = " ";
          texthl = "DiagnosticInfo";
        };
        dapBreakpointCondition = {
          text = " ";
          texthl = "DiagnosticInfo";
        };
        dapBreakpointRejected = {
          text = " ";
          texthl = "DiagnosticError";
        };
        dapLogPoint = {
          text = " ";
          texthl = "DiagnosticInfo";
        };
        dapStopped = {
          text = "󰁕 ";
          texthl = "DiagnosticWarn";
          linehl = "DapStoppedLine";
          numhl = "DapStoppedLine";
        };
      };
    };

    dap-ui = {
      enable = true;
      settings = {
        layouts = [
          {
            elements = [
              {
                id = "scopes";
                size = 0.25;
              }
              {
                id = "breakpoints";
                size = 0.25;
              }
              {
                id = "stacks";
                size = 0.25;
              }
              {
                id = "watches";
                size = 0.25;
              }
            ];
            position = "left";
            size = 40;
          }
          {
            elements = [
              {
                id = "repl";
                size = 0.5;
              }
              {
                id = "console";
                size = 0;
              }
            ];
            position = "bottom";
            size = 10;
          }
        ];
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>d";
        mode = [
          "n"
          "v"
        ];
        group = "Debug";
      }
    ];
  };

  keymaps = [
    {
      mode = [ "n" ];
      action = ":DapContinue<cr>";
      key = "<leader>dc";
      options = {
        desc = "Continue";
      };
    }
    {
      mode = [ "n" ];
      action = ":DapStepOver<cr>";
      key = "<leader>dO";
      options = {
        desc = "Step over";
      };
    }
    {
      mode = [ "n" ];
      action = ":DapStepInto<cr>";
      key = "<leader>di";
      options = {
        desc = "Step Into";
      };
    }
    {
      mode = [ "n" ];
      action = ":DapStepOut<cr>";
      key = "<leader>do";
      options = {
        desc = "Step Out";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dap').pause()<cr>";
      key = "<leader>dp";
      options = {
        desc = "Pause";
      };
    }
    {
      mode = [ "n" ];
      action = ":DapToggleBreakpoint<cr>";
      key = "<leader>db";
      options = {
        desc = "Toggle Breakpoint";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>";
      key = "<leader>dB";
      options = {
        desc = "Breakpoint (conditional)";
      };
    }
    {
      mode = [ "n" ];
      action = ":DapToggleRepl<cr>";
      key = "<leader>dR";
      options = {
        desc = "Toggle REPL";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dap').run_last()<cr>";
      key = "<leader>dr";
      options = {
        desc = "Run Last";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dap').session()<cr>";
      key = "<leader>ds";
      options = {
        desc = "Session";
      };
    }
    {
      mode = [ "n" ];
      action = ":DapTerminate<cr>";
      key = "<leader>dt";
      options = {
        desc = "Terminate";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dap.ui.widgets').hover()<cr>";
      key = "<leader>dw";
      options = {
        desc = "Hover Widget";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dapui').toggle()<cr>";
      key = "<leader>du";
      options = {
        desc = "Toggle UI";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dapui').eval()<cr>";
      key = "<leader>de";
      options = {
        desc = "Eval";
      };
    }
  ];
}
