{ pkgs, lib, ... }:
{
  lsp.servers = {
    pyright = {
      enable = true;
      config.settings = {
        pyright.disableOrganizeImports = true;
        python.analysis = {
          # Ignore all files for analysis to exclusively use Ruff for linting
          ignore.__raw = ''{ '*' }'';
        };
      };
    };

    ruff = {
      enable = true;
      config.settings.onAttach.function = ''
        if client.name == 'ruff' then
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end
      '';
    };
  };

  plugins = {
    dap-python.enable = true;

    conform-nvim.settings = {
      formatters_by_ft.python = [
        "ruff_format"
        "ruff_organize_imports"
      ];
    };

    lint = {
      lintersByFt.python = [ "mypy" ];
      linters.mypy = {
        cmd = lib.getExe pkgs.mypy;
        args = [ "--ignore-missing-imports" ];
      };
    };
  };
}
