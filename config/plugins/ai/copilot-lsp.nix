{ config, ... }:
{
  plugins = {
    copilot-lsp = {
      inherit (config.plugins.copilot-lua) enable;

      lazyLoad.settings = {
        event = [ "InsertEnter" ];
      };

      settings = {
        nes = {
          move_count_threshold = 3;
        };
      };
    };
  };
}
