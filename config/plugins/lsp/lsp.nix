{
  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;

      servers.typos_lsp = {
        enable = true;
        extraOptions = {
          init_options.diagnosticSeverity = "Hint";
        };
      };

      keymaps.lspBuf = {
        "<c-k>" = "signature_help";
        "gi" = "implementation";
      };
    };
    lint.enable = true;

    lsp-signature.enable = true;
    lsp-lines.enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>cl";
      action = "<cmd>LspInfo<cr>";
      options.desc = "Lsp Info";
    }
  ];
}
