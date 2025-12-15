{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) optionals mkIf;
in
{
  extraPackages = with pkgs; [
    lsof
  ];
  extraLuaPackages =
    ps:
    lib.optionals
      (
        # Plugins with known tiktoken_core usage
        config.plugins.copilot-lua.enable
        || config.plugins.avante.enable
        # Plugins with chat/session features that could benefit
        || config.plugins.opencode.enable
      )
      [
        ps.tiktoken_core
      ];

  plugins = {
    opencode = {
      enable = true;

      settings = {
        auto_reload = true;
        provider = {
          enabled = "snacks";
          snacks = {
            win = {
              enter = true;
            };
          };
        };
      };
    };

    which-key.settings.spec = optionals config.plugins.opencode.enable [
      {
        __unkeyed-1 = "<leader>a";
        mode = "n";
        icon = "";
        group = "+AI";
      }
      {
        __unkeyed-1 = "<leader>ao";
        group = "Opencode";
        icon = "";
        mode = [
          "n"
          "v"
        ];
      }
    ];
  };

  keymaps = mkIf config.plugins.opencode.enable [
    {
      mode = "n";
      key = "<leader>aot";
      action.__raw = "function() require('opencode').toggle() end";
      options.desc = "Toggle opencode";
    }
    {
      mode = "n";
      key = "<leader>aoA";
      action.__raw = "function() require('opencode').ask() end";
      options.desc = "Ask opencode";
    }
    {
      mode = "n";
      key = "<leader>aoa";
      action.__raw = "function() require('opencode').ask('@cursor: ') end";
      options.desc = "Ask opencode about this";
    }
    {
      mode = "v";
      key = "<leader>aoa";
      action.__raw = "function() require('opencode').ask('@selection: ') end";
      options.desc = "Ask opencode about selection";
    }
    {
      mode = "n";
      key = "<leader>aon";
      action.__raw = "function() require('opencode').command('session_new') end";
      options.desc = "New opencode session";
    }
    {
      mode = "n";
      key = "<leader>aoy";
      action.__raw = "function() require('opencode').command('messages_copy') end";
      options.desc = "Copy last opencode response";
    }
    {
      mode = "n";
      key = "<S-C-u>";
      action.__raw = "function() require('opencode').command('messages_half_page_up') end";
      options.desc = "Messages half page up";
    }
    {
      mode = "n";
      key = "<S-C-d>";
      action.__raw = "function() require('opencode').command('messages_half_page_down') end";
      options.desc = "Messages half page down";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>aos";
      action.__raw = "function() require('opencode').select() end";
      options.desc = "Select opencode prompt";
    }
    {
      mode = "n";
      key = "<leader>aoe";
      action.__raw = "function() require('opencode').prompt('Explain @cursor and its context') end";
      options.desc = "Explain this code";
    }
  ];
}
