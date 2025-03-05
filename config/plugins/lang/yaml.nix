{ pkgs, lib, ... }:
{
  plugins = {
    lsp.servers.yamlls = {
      enable = true;
      extraOptions = {
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false;
              lineFoldingOnly = true;
            };
          };
        };
      };
    };

    conform-nvim.settings = {
      formatters_by_ft.yaml = [ "yamlfmt" ];

      formatters = {
        yamlfmt.command = lib.getExe pkgs.yamlfmt;
      };
    };
  };
}
