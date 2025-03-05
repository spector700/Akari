{ lib, config, ... }:
{
  plugins.flash = {
    enable = true;
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

  keymaps = lib.mkIf config.plugins.flash.enable [
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action = "<cmd>lua require('flash').jump()<cr>";
      options.desc = "Flash";
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
      mode = [
        "x"
        "o"
      ];
      key = "R";
      action = "<cmd>lua require('flash').treesitter_search()<cr>";
      options = {
        desc = "Treesitter Search";
      };
    }
  ];
}
