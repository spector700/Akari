{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) optionals mkIf;
in
{
  extraPlugins = optionals config.plugins.copilot-lua.enable (
    with pkgs.vimPlugins;
    optionals config.plugins.lualine.enable [
      copilot-lualine
    ]
  );

  plugins = {
    copilot-lua = {
      enable = true;

      lazyLoad.settings = {
        event = [ "InsertEnter" ];
      };

      settings = {
        nes = mkIf (!config.plugins.sidekick.enable) {
          enabled = true;
          keymap = {
            accept_and_goto = "<TAB>";
            accept = false;
            dismiss = "<Esc>";
          };
        };

        filetypes = {
          yaml = false;
          markdown = false;
          json = false;
          help = false;
          gitcommit = false;
          gitrebase = false;
        };
      };
    };
  };

  autoCmd = mkIf (config.plugins.copilot-lua.enable && config.plugins.blink-cmp.enable) [
    {
      event = "User";
      pattern = "BlinkCmpMenuOpen";
      callback.__raw = ''
        function()
          vim.b.copilot_suggestion_hidden = true
        end
      '';
    }

    {
      event = "User";
      pattern = "BlinkCmpMenuClose";
      callback.__raw = ''
        function()
          vim.b.copilot_suggestion_hidden = false
        end
      '';
    }
  ];
}
