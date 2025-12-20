{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf optionals hasAttr;
in
{
  imports = [
    ./picker-lsp.nix
  ];

  plugins = {
    snacks = {
      settings = {
        picker = {
          enable = true;
          sources = {
            noice = mkIf config.plugins.noice.enable {
              confirm = [
                "yank"
                "close"
              ];
            };
          };

          win = {
            list = {
              on_buf.__raw = ''
                function(self)
                    self:execute 'calculate_file_truncate_width'
                end
              '';
            };

            preview = {
              on_buf.__raw = ''
                function(self)
                    self:execute 'calculate_file_truncate_width'
                end
              '';
              on_close.__raw = ''
                function(self)
                    self:execute 'calculate_file_truncate_width'
                end
              '';
            };
          };

          layouts = {
            select = {
              layout = {
                relative = "cursor";
                width = 70;
                min_width = 0;
                row = 1;
              };
            };
          };
        };
      };
    };

    which-key.settings.spec = optionals config.plugins.snacks.enable [
      {
        __unkeyed-1 = "<leader>fn";
        mode = [
          "n"
          "x"
        ];
        desc = "Neovim";
      }
      {
        __unkeyed-1 = "<leader>s";
        mode = [
          "n"
          "x"
        ];
        desc = "Search";
      }
    ];
  };

  keymaps = mkIf (config.plugins.snacks.enable && hasAttr "picker" config.plugins.snacks.settings) [
    {
      mode = "n";
      key = "<leader><space>";
      action = "<cmd>lua Snacks.picker.smart()<cr>";
      options = {
        desc = "Smart Find Files";
      };
    }
    {
      mode = "n";
      key = "<leader>:";
      action = "<cmd>lua Snacks.picker.command_history()<cr>";
      options = {
        desc = "Command History";
      };
    }

    {
      mode = "n";
      key = "<leader>fna";
      action = "<cmd>lua Snacks.picker.autocmds()<cr>";
      options = {
        desc = "Find autocmds";
      };
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>lua Snacks.picker.buffers()<cr>";
      options = {
        desc = "Find buffers";
      };
    }
    {
      mode = "n";
      key = "<leader>fnc";
      action = "<cmd>lua Snacks.picker.commands()<cr>";
      options = {
        desc = "Find commands";
      };
    }
    {
      mode = "n";
      key = "<leader>fC";
      action.__raw = ''
        function()
          require("snacks.picker").files {
            prompt_title = "Config Files",
            cwd = vim.fn.stdpath("config"),
          }
        end
      '';
      options = {
        desc = "Find config files";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>fe";
      action = "<cmd>lua Snacks.explorer()<cr>";
      options = {
        desc = "File Explorer";
      };
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>lua Snacks.picker.files({hidden = true, ignored = true})<cr>";
      options = {
        desc = "Find files (All files)";
      };
    }
    {
      mode = "n";
      key = "<leader>fnh";
      action = "<cmd>lua Snacks.picker.help()<cr>";
      options = {
        desc = "Find help tags";
      };
    }
    {
      mode = "n";
      key = "<leader>fk";
      action = "<cmd>lua Snacks.picker.keymaps()<cr>";
      options = {
        desc = "Find keymaps";
      };
    }
    {
      mode = "n";
      key = "<leader>fm";
      action = "<cmd>lua Snacks.picker.man()<cr>";
      options = {
        desc = "Find man pages";
      };
    }
    {
      mode = "n";
      key = "<leader>fo";
      action = "<cmd>lua Snacks.picker.recent()<cr>";
      options = {
        desc = "Find recent files";
      };
    }
    {
      mode = "n";
      key = "<leader>fp";
      action = "<cmd>lua Snacks.picker.projects()<cr>";
      options = {
        desc = "Find projects";
      };
    }
    {
      mode = "n";
      key = "<leader>fq";
      action = "<cmd>lua Snacks.picker.qflist()<cr>";
      options = {
        desc = "Find quickfix";
      };
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = "<cmd>lua Snacks.picker.registers()<cr>";
      options = {
        desc = "Find registers";
      };
    }
    {
      mode = "n";
      key = "<leader>fS";
      action = ''<CMD>lua Snacks.picker.spelling({layout = { preset = "select" }})<CR>'';
      options = {
        desc = "Find spelling suggestions";
      };
    }
    # Moved to todo-comments module since lazy loading wasn't working
    (mkIf (!config.plugins.todo-comments.lazyLoad.enable) {
      mode = "n";
      key = "<leader>ft";
      action = ''<cmd>lua Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" }})<cr>'';
      options = {
        desc = "Find TODOs";
      };
    })
    {
      mode = "n";
      key = "<leader>fnt";
      action = "<cmd>lua Snacks.picker.colorschemes()<cr>";
      options = {
        desc = "Find theme";
      };
    }
    {
      mode = "n";
      key = "<leader>fu";
      action = "<cmd>lua Snacks.picker.undo()<cr>";
      options = {
        desc = "Undo History";
      };
    }
    # {
    #   mode = "n";
    #   key = "<leader>/";
    #   action = "<cmd>lua Snacks.picker.grep()<cr>";
    #   options = {
    #     desc = "Live grep";
    #   };
    # }
    {
      mode = "n";
      key = "<leader>/";
      action = "<cmd>lua Snacks.picker.grep({hidden = true, ignored = true})<cr>";
      options = {
        desc = "Live grep (All files)";
      };
    }
    {
      mode = "n";
      key = "<leader>f,";
      action = ''<cmd>lua Snacks.picker.icons({layout = { preset = "select" }})<cr>'';
      options = {
        desc = "Find icons";
      };
    }
    {
      mode = "n";
      key = "<leader>f'";
      action = "<cmd>lua Snacks.picker.marks()<cr>";
      options = {
        desc = "Find marks";
      };
    }
    {
      mode = "n";
      key = "<leader>f/";
      action = "<cmd>lua Snacks.picker.lines()<cr>";
      options = {
        desc = "Fuzzy find in current buffer";
      };
    }
    # {
    #   mode = "n";
    #   key = "<leader>f?";
    #   action = "<cmd>lua Snacks.picker.grep_buffers()<cr>";
    #   options = {
    #     desc = "Fuzzy find in open buffers";
    #   };
    # }
    {
      mode = "n";
      key = "<leader>f<CR>";
      action = "<cmd>lua Snacks.picker.resume()<cr>";
      options = {
        desc = "Resume find";
      };
    }

    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>sw";
      action = "<cmd>lua Snacks.picker.grep_word()<cr>";
      options = {
        desc = "Search Word (visual or cursor)";
      };
    }
    {
      mode = "n";
      key = "<leader>X";
      action = "<cmd>lua Snacks.profiler.toggle()<cr>";
      options = {
        desc = "Toggle Neovim profiler";
      };
    }
  ];
}
