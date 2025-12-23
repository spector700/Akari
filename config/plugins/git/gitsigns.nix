{
  plugins = {
    gitsigns = {
      enable = true;

      lazyLoad.settings.event = "DeferredUIEnter";

      settings = {
        trouble = true;
        current_line_blame = false;
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>gd";
        group = "Diff";
        icon = " ";
      }
    ];
  };

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>gh";
      action = "gitsigns";
      options = {
        silent = true;
        desc = "+hunks";
      };
    }
    {
      mode = "n";
      key = "<leader>ghb";
      action = ":Gitsigns blame_line<CR>";
      options = {
        silent = true;
        desc = "Blame line";
      };
    }
    {
      mode = "n";
      key = "<leader>ghd";
      action = ":Gitsigns diffthis<CR>";
      options = {
        silent = true;
        desc = "Diff This";
      };
    }
    {
      mode = "n";
      key = "<leader>ghp";
      action = ":Gitsigns preview_hunk<CR>";
      options = {
        silent = true;
        desc = "Preview hunk";
      };
    }
    {
      mode = "n";
      key = "<leader>ghR";
      action = ":Gitsigns reset_buffer<CR>";
      options = {
        silent = true;
        desc = "Reset Buffer";
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>ghr";
      action = ":Gitsigns reset_hunk<CR>";
      options = {
        silent = true;
        desc = "Reset Hunk";
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>ghs";
      action = ":Gitsigns stage_hunk<CR>";
      options = {
        silent = true;
        desc = "Stage Hunk";
      };
    }
    {
      mode = "n";
      key = "<leader>gS";
      action.__raw = ''
        function()
          require('gitsigns').stage_buffer()
          local file = vim.fn.expand('%')
          vim.notify('Staged ' .. file, vim.log.levels.INFO, { title = 'Gitsigns' })
        end
      '';
      options = {
        desc = "Stage Buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>gU";
      action.__raw = ''
        function()
          local file = vim.fn.expand('%')
          vim.fn.system('git restore --staged ' .. file)
          require('gitsigns').refresh()
          vim.notify('Unstaged ' .. file, vim.log.levels.INFO, { title = 'Gitsigns' })
        end
      '';
      options = {
        desc = "Unstage Buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>ghu";
      action = ":Gitsigns undo_stage_hunk<CR>";
      options = {
        silent = true;
        desc = "Undo Stage Hunk";
      };
    }
    # Toggles
    {
      mode = "n";
      key = "<leader>ugb";
      action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
      options = {
        desc = "Toggle Blame";
      };
    }
    {
      mode = "n";
      key = "<leader>ugw";
      action = "<cmd>Gitsigns toggle_word_diff<CR>";
      options = {
        desc = "Toggle Word Diff";
      };
    }
  ];
}
