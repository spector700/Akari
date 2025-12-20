{ lib, config, ... }:
let
  inherit (lib) mkIf;
in
{
  plugins = {
    flash = {
      enable = true;

      lazyLoad.settings.event = "DeferredUIEnter";

      settings = {
        label.uppercase = false;
        search = {
          exclude = [
            "notify"
            "cmp_menu"
            "noice"
            "flash_prompt"
            {
              __raw = ''
                function(win)
                  -- exclude non-focusable windows
                  return not vim.api.nvim_win_get_config(win).focusable
                end
              '';
            }
          ];
        };
      };
    };

    telescope.settings.defaults.mappings =
      let
        flash.__raw = ''
          function(prompt_bufnr)
            require("flash").jump({
              pattern = "^",
              label = { after = { 0, 0 } },
              search = {
                mode = "search",
                exclude = {
                  function(win)
                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
                  end,
                },
              },
              action = function(match)
                local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                picker:set_selection(match.pos[1] - 1)
              end,
            })
          end
        '';
      in
      mkIf config.plugins.flash.enable {
        n = {
          s = flash;
        };

        i = {
          "<c-s>" = flash;
        };
      };
  };

  keymaps = mkIf config.plugins.flash.enable [
    {
      key = "s";
      mode = [
        "n"
        "x"
        "o"
      ];
      action.__raw = ''function() require("flash").jump() end'';
      options.desc = "Flash";
    }
    {
      key = "S";
      action.__raw = ''function() require("flash").treesitter() end'';
      mode = [
        "n"
        "x"
        "o"
      ];
      options.desc = "Flash Treesitter";
    }
    {
      key = "r";
      action.__raw = ''function() require("flash").remote() end'';
      mode = [
        "o"
      ];
      options.desc = "Remote Flash";
    }
    {
      key = "R";
      mode = [
        "x"
        "o"
      ];
      action.__raw = ''function() require("flash").treesitter_search() end'';
      options = {
        desc = "Treesitter Search";
      };
    }
    {
      key = "gl";
      action.__raw = ''
        function()
          require("flash").jump {
            search = { mode = 'search', max_length = 0 },
            label = { after = { 0, 0 } },
            pattern = '^',
          }
        end
      '';
      mode = [
        "n"
        "x"
        "o"
      ];
      options.desc = "Flash Line";
    }
  ];
}
