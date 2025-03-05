{ pkgs, lib, ... }:
{
  plugins = {
    lsp.servers = {
      dockerls.enable = true;
      docker_compose_language_service.enable = true;
    };

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
