{
  lsp.servers = {
    jsonls.enable = true;
  };

  plugins = {
    conform-nvim.settings = {
      formatters_by_ft = {
        json = [ "jq" ];
      };
    };
  };
}
