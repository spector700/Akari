{
  self,
  pkgs,
  lib,
  ...
}:
{
  plugins = {
    nix.enable = true;
    hmts.enable = true;
    nix-develop.enable = true;

    conform-nvim.settings = {
      formatters_by_ft = {
        nix = [ "nixfmt" ];
      };

      formatters = {
        nixfmt.command = lib.getExe pkgs.nixfmt-rfc-style;
      };
    };

    lint = {
      lintersByFt = {
        nix = [ "statix" ];
      };

      linters = {
        statix.cmd = lib.getExe pkgs.statix;
      };
    };

    lsp.servers.nixd = {
      enable = true;
      settings =
        let
          flake = ''(builtins.getFlake "${self}")'';
          system = ''''${builtins.currentSystem}'';
        in
        {
          formatting = {
            command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
          };
          nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
          options = {
            nixvim.expr = ''${flake}.packages.${system}.nvim.options'';
            # NOTE: These will be passed in from outside using `.extend` from the flake installing this package
            # nix-darwin.expr = ''${flake}.darwinConfigurations.khanelimac.options'';
            # nixos.expr = ''${flake}.nixosConfigurations.khanelinix.options'';
            # home-manager.expr = ''${nixos.expr}.home-manager.users.type.getSubOptions [ ]'';
          };
        };
    };
  };
}
