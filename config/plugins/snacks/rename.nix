{
  config,
  lib,
  ...
}:
{
  plugins = {
    snacks = {
      settings = {
        rename.enabled = true;
      };
    };
  };

  # Integration with file explorers
  autoGroups = {
    snacks_rename_integration = {
      clear = true;
    };
  };

  keymaps =
    lib.mkIf
      (
        config.plugins.snacks.enable
        && lib.hasAttr "rename" config.plugins.snacks.settings
        && config.plugins.snacks.settings.rename.enabled
      )
      [
        {
          mode = "n";
          key = "<leader>cr";
          action = "<cmd>lua Snacks.rename.rename_file()<CR>";
          options = {
            desc = "Rename File";
          };
        }
      ];
}
