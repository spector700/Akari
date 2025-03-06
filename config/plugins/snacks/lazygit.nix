{ config, lib, ... }:
{
  plugins.snacks = {
    enable = true;
    settings = {
      lazygit.enabled = true;
    };
  };

  keymaps = lib.mkIf config.plugins.snacks.settings.lazygit.enabled [
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>lua Snacks.lazygit()<CR>";
      options.desc = "Open lazygit";
    }
  ];
}
