{ config, lib, ... }:
{
  plugins = {
    compiler = {
      enable = true;
    };

    which-key.settings.spec = lib.optionals config.plugins.compiler.enable [
      {
        __unkeyed-1 = "<leader>r";
        group = "Compiler";
        icon = "";
      }
    ];
  };

  keymaps = lib.mkIf config.plugins.compiler.enable [
    {
      mode = "n";
      key = "<leader>ro";
      action = "<cmd>CompilerOpen<CR>";
      options = {
        desc = "Compiler Open";
      };
    }
    {
      mode = "n";
      key = "<leader>rr";
      action = "<cmd>CompilerRedo<CR>";
      options = {
        desc = "Compiler Redo";
      };
    }
    {
      mode = "n";
      key = "<leader>rs";
      action = "<cmd>CompilerStop<CR>";
      options = {
        desc = "Compiler Stop";
      };
    }
    {
      mode = "n";
      key = "<leader>rt";
      action = "<cmd>CompilerToggleResults<CR>";
      options = {
        desc = "Compiler Toggle Results";
      };
    }
  ];
}
