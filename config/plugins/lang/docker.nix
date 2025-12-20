{ pkgs, lib, ... }:
{
  lsp.servers = {
    dockerls.enable = true;
  };

  plugins = {
    lint = {
      lintersByFt = {
        docker = [ "hadolint" ];
      };

      linters = {
        hadolint.cmd = lib.getExe pkgs.hadolint;
      };
    };
  };
}
