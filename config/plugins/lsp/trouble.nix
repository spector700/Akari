{
  plugins = {
    trouble = {
      enable = true;
      settings = {
        auto_close = true;
        modes = {
          preview_split = {
            # NOTE: can automatically open when diagnostics exist
            # auto_open = true;
            mode = "diagnostics";
            preview = {
              type = "split";
              relative = "win";
              position = "right";
              size = 0.5;
            };
          };
        };
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>x";
        mode = "n";
        icon = "";
        group = "Trouble";
      }
    ];
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble preview_split toggle<cr>";
      options = {
        desc = "Diagnostics toggle";
      };
    }
    {
      mode = "n";
      key = "<leader>xX";
      action = "<cmd>Trouble preview_split toggle filter.buf=0<cr>";
      options = {
        desc = "Buffer Diagnostics toggle";
      };
    }
    {
      mode = "n";
      key = "<leader>us";
      action = "<cmd>Trouble symbols toggle focus=false<cr>";
      options = {
        desc = "Symbols toggle";
      };
    }
    {
      mode = "n";
      key = "<leader>xl";
      action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
      options = {
        desc = "LSP Definitions / references / ... toggle";
      };
    }
    {
      mode = "n";
      key = "<leader>xL";
      action = "<cmd>Trouble loclist toggle<cr>";
      options = {
        desc = "Location List toggle";
      };
    }
    {
      mode = "n";
      key = "<leader>xQ";
      action = "<cmd>Trouble qflist toggle<cr>";
      options = {
        desc = "Quickfix List toggle";
      };
    }
  ];
}
