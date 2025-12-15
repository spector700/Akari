{
  plugins = {
    bufferline = {
      enable = true;
      settings = {
        # NOTE: fixes colorscheme with transparent_background
        # and better contrast selected tabs
        highlights =
          let
            commonBgColor = "#363a4f";
            commonFgColor = "#1e2030";

            commonSelectedAttrs = {
              bg = commonBgColor;
            };

            # Define a set with common selected attributes
            selectedAttrsSet = builtins.listToAttrs (
              map
                (name: {
                  inherit name;
                  value = commonSelectedAttrs;
                })
                [
                  # "separator_selected" # Handled uniquely
                  "buffer_selected"
                  "tab_selected"
                  "numbers_selected"
                  "close_button_selected"
                  "duplicate_selected"
                  "modified_selected"
                  "info_selected"
                  "warning_selected"
                  "error_selected"
                  "hint_selected"
                  "diagnostic_selected"
                  "info_diagnostic_selected"
                  "warning_diagnostic_selected"
                  "error_diagnostic_selected"
                  "hint_diagnostic_selected"
                ]
            );
          in
          # Merge the common selected attributes with the unique attributes
          selectedAttrsSet
          // {
            fill = {
              bg = commonFgColor;
            };
            separator = {
              fg = commonFgColor;
            };
            separator_visible = {
              fg = commonFgColor;
            };
            separator_selected = {
              bg = commonBgColor;
              fg = commonFgColor;
            };
          };

        options = {
          diagnostics = "nvim_lsp";
          diagnostics_indicator = /* Lua */ ''
            function(count, level, diagnostics_dict, context)
              local s = ""
              for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " "
                  or (e == "warning" and " " or "" )
                if(sym ~= "") then
                  s = s .. " " .. n .. sym
                end
              end
              return s
            end
          '';
          # Will make sure all names in bufferline are unique
          enforce_regular_tabs = false;

          offsets = [
            {
              filetype = "neo-tree";
              text = "Neo-tree";
              highlight = "Directory";
              text_align = "left";
            }
          ];

          groups = {
            options = {
              toggle_hidden_on_enter = true;
            };

            items = [
              {
                name = "Tests";
                highlight = {
                  underline = true;
                  fg = "#a6da95";
                  sp = "#494d64";
                };
                priority = 2;
                # icon = "";
                matcher.__raw = ''
                  function(buf)
                    return buf.name:match('%test') or buf.name:match('%.spec')
                  end
                '';
              }
              {
                name = "Docs";
                highlight = {
                  undercurl = true;
                  fg = "#ffffff";
                  sp = "#494d64";
                };
                auto_close = false;
                matcher.__raw = ''
                  function(buf)
                    return buf.name:match('%.md') or buf.name:match('%.txt')
                  end
                '';
              }
            ];
          };

          left_trunc_marker = "";
          max_name_length = 18;
          max_prefix_length = 15;
          modified_icon = "●";

          persist_buffer_sort = true;
          right_trunc_marker = "";
          separator_style = "slant";
          show_buffer_close_icons = true;
          show_buffer_icons = true;
          show_close_icon = true;
          show_tab_indicators = true;
          sort_by = "extension";
          tab_size = 18;
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<C-Tab>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options = {
        desc = "Cycle to next buffer";
      };
    }

    {
      mode = "n";
      key = "<C-S-Tab>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options = {
        desc = "Cycle to previous buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>br";
      action = "<cmd>BufferLineCloseRight<cr>";
      options = {
        desc = "Delete buffers to the right";
      };
    }

    {
      mode = "n";
      key = "<leader>bl";
      action = "<cmd>BufferLineCloseLeft<cr>";
      options = {
        desc = "Delete buffers to the left";
      };
    }

    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>BufferLineTogglePin<cr>";
      options = {
        desc = "Toggle pin";
      };
    }

    {
      mode = "n";
      key = "<leader>bP";
      action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
      options = {
        desc = "Delete non-pinned buffers";
      };
    }
  ];
}
