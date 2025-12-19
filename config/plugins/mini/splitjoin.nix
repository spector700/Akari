{ config, lib, ... }:
{
  plugins.mini-splitjoin = {
    enable = true;
    settings = {
      mappings = {
        toggle = "gs"; # Toggle split/join
      };
    };
  };

  plugins.which-key.settings.spec = lib.mkIf config.plugins.mini-splitjoin.enable [
    {
      __unkeyed-1 = "gs";
      desc = "Toggle split/join";
      icon = "󰘞";
    }
  ];
}
