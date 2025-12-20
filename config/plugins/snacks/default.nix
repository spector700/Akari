{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./bufdelete.nix
    ./dim.nix
    ./gitbrowse.nix
    ./image.nix
    ./picker.nix
    ./profiler.nix
    ./lazygit.nix
    ./terminal.nix
    ./toggle.nix
  ];

  extraConfigLuaPre = lib.mkOrder 1 (
    lib.optionalString
      (config.plugins.snacks.enable && config.plugins.snacks.settings.profiler.enabled) # Lua
      ''
        if vim.env.PROF then
          local snacks = "${pkgs.vimPlugins.snacks-nvim}"
          vim.opt.rtp:append(snacks)
          require("snacks.profiler").startup({
            startup = {
              -- event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
              event = "UIEnter",
              -- event = "VeryLazy",
            },
          })
        end
      ''
  );

  plugins = {
    snacks = {
      enable = true;

      settings = {
        indent.enabled = true;
        input.enabled = true;
        scroll.enabled = true;
      };
    };
  };
}
