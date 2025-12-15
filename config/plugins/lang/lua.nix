{ pkgs, lib, ... }:
{
  plugins = {
    lsp.servers.lua_ls.enable = true;

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
