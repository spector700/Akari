{
  lsp.servers = {
    html.enable = true;
  };

  plugins = {
    conform-nvim.settings = {
      formatters_by_ft.html = {
        __unkeyed-1 = "prettierd";
        __unkeyed-2 = "prettier";
        timeout_ms = 2000;
        stop_after_first = true;
      };
    };
  };
}
