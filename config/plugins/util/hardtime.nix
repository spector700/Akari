{ config, lib, ... }:
let
  cfg = config.plugins.hardtime;
  inherit (lib) mkIf;
in
{
  plugins = {
    hardtime = {
      enable = true;

      settings = {
        disable_mouse = false;
        disabled_keys.__raw = ''
          {
            -- Empty or explicitly remove arrows because I use colemak
            ["<Up>"] = {},
            ["<Down>"] = {},
            ["<Left>"] = {},
            ["<Right>"] = {},
          }
        '';

        restricted_keys = {
          "<Up>" = [ "" ];
          "<Down>" = [ "" ];
          "<Left>" = [ "" ];
          "<Right>" = [ "" ];
        };
      };
    };
  };

  keymaps = mkIf cfg.enable [
    {
      mode = "n";
      key = "<leader>uH";
      action.__raw = ''
        function ()
          vim.g.disable_hardtime = not vim.g.disable_hardtime
          if vim.g.disable_hardtime then
            vim.cmd("Hardtime disable")
          else
            vim.cmd("Hardtime enable")
          end
          vim.notify(string.format("Hardtime %s", tostring(not vim.g.disable_hardtime), "info"))
        end
      '';
      options = {
        desc = "Hardtime toggle";
        silent = true;
      };
    }
  ];
}
