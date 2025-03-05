{ pkgs, lib, ... }:
{
  plugins = {
    conform-nvim.settings = {
      formatters_by_ft = {
        sh = [ "shfmt" ];
      };
      formatters = {
        shfmt.command = lib.getExe pkgs.shfmt;
      };
    };

    lsp.servers.bashls.enable = true;
  };
}
