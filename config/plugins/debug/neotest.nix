{
  config,
  lib,
  ...
}:
{
  plugins = {
    neotest = {
      enable = true;

      lazyLoad = {
        settings = {
          keys = [
            {
              __unkeyed-1 = "<leader>tt";
              __unkeyed-3 = "<CMD>Neotest summary<CR>";
              desc = "Summary toggle";
            }
            {
              __unkeyed-1 = "<leader>dn";
              __unkeyed-3.__raw = ''
                function()
                  require("neotest").run.run({strategy = "dap"})
                end
              '';
              desc = "Neotest Debug";
            }
            {
              __unkeyed-1 = "<leader>ta";
              __unkeyed-3 = "<CMD>Neotest attach<CR>";
              desc = "Attach";
            }
            {
              __unkeyed-1 = "<leader>td";
              __unkeyed-3.__raw = ''
                function()
                  require("neotest").run.run({strategy = "dap"})
                end
              '';
              desc = "Debug";
            }
            {
              __unkeyed-1 = "<leader>th";
              __unkeyed-3 = "<CMD>Neotest output<CR>";
              desc = "Output";
            }
            {
              __unkeyed-1 = "<leader>to";
              __unkeyed-3 = "<CMD>Neotest output-panel<CR>";
              desc = "Output Panel toggle";
            }
            {
              __unkeyed-1 = "<leader>tr";
              __unkeyed-3 = "<CMD>Neotest run<CR>";
              desc = "Run (Nearest Test)";
            }
            {
              __unkeyed-1 = "<leader>tR";
              __unkeyed-3.__raw = ''
                function()
                  require("neotest").run.run(vim.fn.expand("%"))
                end
              '';
              desc = "Run (File)";
            }
            {
              __unkeyed-1 = "<leader>ts";
              __unkeyed-3 = "<CMD>Neotest stop<CR>";
              desc = "Stop";
            }
          ];
        };
      };

      adapters = lib.mkIf (config.plugins.treesitter.enable && config.plugins.neotest.enable) {
        bash.enable = true;
        deno.enable = true;
        go.enable = true;
        java.enable = true;
        # NOTE: just run NeotestJava setup
        # java.settings = {
        # Not sure why this wasn't working
        # junit_jar =
        #   pkgs.fetchurl
        #     {
        #       url = "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.10.1/junit-platform-console-standalone-1.10.1.jar";
        #       hash = "sha256-tC6qU9E1dtF9tfuLKAcipq6eNtr5X0JivG6W1Msgcl8=";
        #     }
        #     .outPath;
        # };
        jest.enable = true;
        playwright.enable = true;
        plenary.enable = true;
        python.enable = true;
        rust.enable = true;
        zig.enable = true;
      };
    };

    which-key.settings.spec = lib.optionals config.plugins.neotest.enable [
      {
        __unkeyed-1 = "<leader>t";
        group = "Test";
        icon = "󰙨";
      }
    ];
  };
}
