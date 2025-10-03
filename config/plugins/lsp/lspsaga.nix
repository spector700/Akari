{
  plugins = {
    lspsaga = {
      enable = true;
      settings = {
        beacon.enable = true;
        ui.border = "rounded"; # One of none, single, double, rounded, solid, shadow
        hover = {
          openCmd = "!firfox";
          openLink = "gx";
        };
        symbolInWinbar = {
          enable = true; # Breadcrumbs
          showFile = false;
        };

        codeAction = {
          showServerName = true;
          numShortcut = false;
          onlyInCursor = false;
          keys = {
            exec = "<CR>";
            quit = [
              "<Esc>"
              "q"
            ];
          };
        };

        lightbulb = {
          enable = true;
          sign = true;
        };

        rename.keys = {
          exec = "<CR>";
          quit = [
            "<C-k>"
            "<Esc>"
          ];
          select = "x";
        };

        outline = {
          closeAfterJump = true;
          layout = "normal"; # normal or float
          winPosition = "right"; # left or right
          keys = {
            jump = "e";
            quit = "q";
            toggleOrJump = "o";
          };
        };

        scrollPreview = {
          scrollUp = "<C-d>";
          scrollDown = "<C-u>";
        };
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "gp";
        mode = "n";
        group = "+peek";
      }
    ];
  };

  keymaps = [
    {
      mode = "n";
      key = "K";
      # action = "<cmd>Lspsaga hover_doc<CR>";
      action.__raw = ''
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.cmd("Lspsaga hover_doc")
          end
        end
      '';
      options = {
        desc = "Hover";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>lo";
      action = "<cmd>Lspsaga outline<CR>";
      options = {
        desc = "Outline";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>lr";
      action = "<cmd>Lspsaga rename<CR>";
      options = {
        desc = "Rename";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ca";
      action = "<cmd>Lspsaga code_action<CR>";
      options = {
        desc = "Code Action";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>cd";
      action = "<cmd>Lspsaga show_buf_diagnostics<CR>";
      options = {
        desc = "Line Diagnostics";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "gd";
      action = "<cmd>Lspsaga goto_definition<CR>";
      options = {
        desc = "Goto Definition";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "gt";
      action = "<cmd>Lspsaga goto_type_definition<CR>";
      options = {
        desc = "Type Definitions";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "gpd";
      action = "<cmd>Lspsaga peek_definition<CR>";
      options = {
        desc = "Peek Definitions";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "gpt";
      action = "<cmd>Lspsaga peek_type_definition<CR>";
      options = {
        desc = "Peek Type Definitions";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "gl";
      action = "<cmd>Lspsaga show_line_diagnostics<CR>";
      options = {
        desc = "Line Diagnostics";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "[d";
      action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
      options = {
        desc = "Next Diagnostic";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "]d";
      action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
      options = {
        desc = "Previous Diagnostic";
        silent = true;
      };
    }
  ];
}
