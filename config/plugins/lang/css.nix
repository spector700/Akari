{
  lsp.servers = {
    cssls.enable = true;
    stylelint_lsp.enable = true;

    tailwindcss = {
      enable = true;
      config.filetypes = [
        "css"
        "scss"
        "sass"
        "html"
        "javascriptreact"
        "typescriptreact"
        "vue"
        "svelte"
      ];
    };
  };

  plugins = {
    conform-nvim.settings = {
      formatters_by_ft.css = {
        __unkeyed-1 = "prettierd";
        __unkeyed-2 = "prettier";
        timeout_ms = 2000;
        stop_after_first = true;
      };
    };
  };
}
