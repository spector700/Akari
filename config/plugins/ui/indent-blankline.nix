{
  plugins = {
    indent-blankline = {
      enable = false;
      settings = {
        indent = {
          char = "│"; # "│" or "▎"
          tab_char = "│";
        };
        scope.enabled = false;
        exclude = {
          buftypes = [
            "terminal"
            "nofile"
          ];
          filetypes = [
            "help"
            "alpha"
            "dashboard"
            "neo-tree"
            "Trouble"
            "trouble"
            "lazy"
            "mason"
            "notify"
            "toggleterm"
            "lazyterm"
          ];
        };
      };
    };
  };
}
