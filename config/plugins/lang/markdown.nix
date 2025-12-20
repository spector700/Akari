{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.nixvim) enableExceptInTests;
in
{
  lsp.servers = {
    marksman.enable = true;
  };

  plugins = {
    clipboard-image = {
      enable = true;
      clipboardPackage = pkgs.wl-clipboard;
    };

    image = {
      enable = enableExceptInTests;
      settings = {
        integrations.markdown = {
          clearInInsertMode = true;
          onlyRenderImageAtCursor = true;
        };
      };
    };

    markdown-preview = {
      enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft.markdown = [ "deno_fmt" ];
    };

    lint = {
      lintersByFt.markdown = [ "markdownlint" ];
      linters.markdownlint.cmd = lib.getExe pkgs.markdownlint-cli;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>m";
      action = "<cmd>MarkdownPreviewToggle<cr>";
      options = {
        silent = true;
        desc = "Toggle markdown preview";
      };
    }
  ];
}
