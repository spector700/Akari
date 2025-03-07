{ pkgs, lib, ... }:
{
  plugins = {
    conform-nvim.settings = {
      formatters_by_ft = {
        json = [ "jq" ];
      };

      formatters = {
        jq = {
          command = lib.getExe pkgs.jq;
        };
      };
    };

    lint = {
      lintersByFt = {
        json = [ "jsonlint" ];
      };

      linters = {
        jsonlint = {
          cmd = lib.getExe pkgs.nodePackages_latest.jsonlint;
        };
      };
    };

    lsp.servers.jsonls = {
      enable = true;
    };
  };
}
