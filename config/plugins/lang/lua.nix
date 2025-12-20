{ pkgs, lib, ... }:
{
  lsp.servers = {
    emmylua_ls.enable = true;
  };

  plugins = {
    conform-nvim.settings = {
      formatters_by_ft = {
        lua = [ "stylua" ];
      };
    };

    lint = {
      lintersByFt.lua = [ "luacheck" ];
      linters.luacheck.cmd = lib.getExe pkgs.lua54Packages.luacheck;
    };
  };
}
