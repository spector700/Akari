{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) getExe;
in
{
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

    lsp.servers = {
      statix.enable = true;

      nixd = {
        enable = true;

        settings = {
          formatting = {
            command = [ "${getExe pkgs.nixfmt-rfc-style}" ];
          };
        };
      };
    };
  };
}
