{
  plugins.which-key = {
    enable = true;

    settings = {
      icons = {
        breadcrumb = "»";
        group = "+";
        separator = ""; # ➜
      };
      win = {
        border = "rounded";
        padding = [
          1
          1
        ];
      };

      spec = [
        # General Mappings
        {
          __unkeyed-1 = "<leader>c";
          mode = [
            "n"
            "v"
          ];
          group = "Code";
        }

        {
          __unkeyed-1 = "<leader>f";
          mode = "n";
          group = "Find";
        }

        {
          __unkeyed-1 = "<leader>g";
          mode = [
            "n"
            "v"
          ];
          group = "Git";
        }

        {
          __unkeyed-1 = "<leader>q";
          mode = "n";
          group = "Quit/Session";
        }

        {
          __unkeyed-1 = "<leader>s";
          mode = "n";
          group = "Search";
        }

        {
          __unkeyed-1 = "<leader>u";
          mode = "n";
          group = "UI/UX";
        }

        {
          __unkeyed-1 = "<leader>w";
          mode = "n";
          group = "Windows";
        }

        {
          __unkeyed-1 = "<leader>b";
          mode = "n";
          group = "Buffers";
        }
      ];
    };
  };
}
