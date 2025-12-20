{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) getExe;
in
{
  lsp.servers = {
    statix.enable = true;

    nixd = {
      enable = true;

      config.settings.nixd = {
        formatting = {
          command = [ "${getExe pkgs.nixfmt-rfc-style}" ];
        };
      };
    };
  };

  plugins = {
    nix.enable = true;
    # hmts.enable = true;
    direnv.enable = pkgs.stdenv.hostPlatform.isLinux;
    nix-develop.enable = true;

    conform-nvim.settings = {
      formatters_by_ft = {
        nix = [ "nixfmt" ];
      };
    };

    lint = {
      lintersByFt = {
        nix = [ "deadnix" ];
      };

      linters = {
        deadnix.cmd = getExe pkgs.deadnix;
      };
    };
  };
}
