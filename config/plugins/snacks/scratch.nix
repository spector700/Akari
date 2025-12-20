{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf hasAttr;
in
{
  plugins = {
    snacks = {
      settings = {
        scratch.enabled = true;
      };
    };

    which-key.settings.spec =
      mkIf
        (
          config.plugins.snacks.enable
          && hasAttr "scratch" config.plugins.snacks.settings
          && config.plugins.snacks.settings.scratch.enabled
        )
        [
          {
            __unkeyed-1 = "<leader>n";
            group = "Notes";
            icon = " ";
          }
        ];
  };

  keymaps =
    mkIf
      (
        config.plugins.snacks.enable
        && hasAttr "scratch" config.plugins.snacks.settings
        && config.plugins.snacks.settings.scratch.enabled
      )
      [
        {
          mode = "n";
          key = "<leader>nn";
          action = "<cmd>lua Snacks.scratch()<CR>";
          options = {
            desc = "New Scratch Buffer";
          };
        }
        {
          mode = "n";
          key = "<leader>ns";
          action = "<cmd>lua Snacks.scratch.select()<CR>";
          options = {
            desc = "Select Scratch Buffer";
          };
        }
      ];
}
