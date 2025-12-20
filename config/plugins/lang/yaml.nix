{
  lsp.servers = {
    yamlls.enable = true;
  };

  plugins = {
    conform-nvim.settings = {
      formatters_by_ft.yaml = [ "yamlfmt" ];
    };
  };
}
