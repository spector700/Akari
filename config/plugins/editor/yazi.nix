{
  plugins.yazi.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Yazi<cr>";
      options = {
        desc = "Yazi toggle";
        silent = true;
      };
    }
  ];
}
