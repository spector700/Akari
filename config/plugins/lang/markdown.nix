{
  lib,
  pkgs,
  ...
}:
{
  lsp.servers = {
    marksman.enable = true;
  };

  plugins = {
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
