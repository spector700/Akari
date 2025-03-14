{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  plugins.telescope = {
    extensions = {
      manix.enable = true;
    };
  };

  keymaps = mkIf config.plugins.telescope.enable [
    (mkIf config.plugins.telescope.extensions.manix.enable {
      mode = "n";
      key = "<leader>fM";
      action = "<cmd>Telescope manix<CR>";
      options = {
        desc = "Search manix";
      };
    })
  ];
}
