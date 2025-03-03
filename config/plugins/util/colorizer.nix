{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    windows-nvim
    nvzone-minty
  ];
  extraConfigLua = # lua
    ''
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()

      require('minty').setup({
        huefy = {
          border = "rounded",
          mappings = function(buf)
            local api = require("minty.shades.api")
            vim.keymap.set("n", "s", api.save_color, { buffer = buf })
          end
        }
      })
    '';

  plugins.colorizer = {
    enable = true;
    settings = {
      filetypes = {
        __unkeyed = "*";
      };
      user_default_options = {
        names = true;
        RRGGBBAA = true;
        AARRGGBB = true;
        rgb_fn = true;
        hsl_fn = true;
        css = true;
        css_fn = true;
        tailwind = true;
        mode = "virtualtext";
        virtualtext = "■";
        always_update = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>uc";
      action = "<cmd>lua require('minty.huefy').open()<cr>";
      options.desc = "Minty Color Picker";
    }
  ];
}
