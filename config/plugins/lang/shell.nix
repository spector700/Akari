{
  lsp.servers = {
    bashls.enable = true;
  };

  plugins = {
    conform-nvim.settings = {
      formatters_by_ft = {
        sh = [ "shfmt" ];
      };
    };
  };
}
