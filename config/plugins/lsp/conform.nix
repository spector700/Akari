{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkIf optionals;
in
{
  plugins = {
    conform-nvim = {
      enable = true;

      autoInstall = {
        enable = true;
        overrides = {
          swift_format = mkIf pkgs.stdenv.hostPlatform.isLinux null;
        };
      };

      lazyLoad.settings = {
        cmd = [ "ConformInfo" ];
        event = [ "BufWritePre" ];
      };

      luaConfig.pre = ''
        local slow_format_filetypes = {}
      '';

      settings = {
        default_format_opts = {
          lsp_format = "fallback";
        };

        format_on_save = {
          lspFallback = true;
          timeoutMs = 500;
        };

        formatters_by_ft = {
          # Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
          "_" = [
            "squeeze_blanks"
            "trim_whitespace"
            "trim_newlines"
          ];
        };

        formatters = {
          biome = {
            env = {
              BIOME_CONFIG_PATH = pkgs.writeTextFile {
                name = "biome.json";
                text = lib.generators.toJSON { } {
                  "$schema" = "${pkgs.biome}/node_modules/@biomejs/biome/configuration_schema.json";
                  formatter.useEditorconfig = true;
                };
              };
            };
          };
        };
      };
    };
  };

  keymaps = optionals config.plugins.conform-nvim.enable [
    {
      action.__raw = ''
        function(args)
         vim.cmd({cmd = 'Conform', args = args});
        end
      '';
      mode = "v";
      key = "<leader>lf";
      options = {
        silent = true;
        buffer = false;
        desc = "Format selection";
      };
    }
    {
      action.__raw = ''
        function()
          vim.cmd('Conform');
        end
      '';
      key = "<leader>lf";
      options = {
        silent = true;
        desc = "Format buffer";
      };
    }
  ];

  userCommands = lib.mkIf config.plugins.conform-nvim.enable {
    Conform = {
      desc = "Formatting using conform.nvim";
      range = true;
      command.__raw = ''
        function(args)
          ${lib.optionalString config.plugins.lz-n.enable "require('lz.n').trigger_load('conform.nvim')"}
          local range = nil
          if args.count ~= -1 then
            local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
            range = {
              start = { args.line1, 0 },
              ["end"] = { args.line2, end_line:len() },
            }
          end
          require("conform").format({ async = true, lsp_format = "fallback", range = range },
          function(err)
            if not err then
              local mode = vim.api.nvim_get_mode().mode
              if vim.startswith(string.lower(mode), "v") then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
              end
            end
          end)
        end
      '';
    };
  };
}
