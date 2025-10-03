{ pkgs, lib, ... }:
{
  plugins = {
    conform-nvim.settings = {
      formatters_by_ft.html = {
        __unkeyed-1 = "prettierd";
        __unkeyed-2 = "prettier";
        timeout_ms = 2000;
        stop_after_first = true;
      };

      formatters = {
        prettierd.command = lib.getExe pkgs.prettierd;
        prettier.command = lib.getExe pkgs.nodePackages.prettier;
      };
    };

    lsp = {
      servers = {
        html = {
          enable = true;
          cmd = [
            "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server"
            "--stdio"
          ];
        };
      };

      # enabledServers = [
      #   {
      #     name = "emmet_language_server";
      #     extraOptions = {
      #       cmd = [
      #         (lib.getExe pkgs.emmet-language-server)
      #         "--stdio"
      #       ];
      #       filetypes = [ "html" ];
      #     };
      #   }
      # ];
    };
  };
}
