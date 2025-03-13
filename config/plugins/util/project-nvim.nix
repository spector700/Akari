{ lib, config, ... }:
{
  plugins = {
    project-nvim = {
      enable = true;
      enableTelescope = config.plugins.telescope.enable;
    };
  };
  keymaps = lib.mkIf (config.plugins.telescope.enable && config.plugins.project-nvim.enable) [
    {
      mode = "n";
      key = "<leader>fp";
      action = "<cmd>Telescope projects<CR>";
      options = {
        desc = "Find projects";
      };
    }
  ];
}
