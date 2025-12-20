{
  config,
  lib,
  pkgs,
  ...
}:
{
  lsp = {
    inlayHints.enable = true;

    servers = {
      "*" = {
        config = {
          capabilities = {
            textDocument = {
              semanticTokens = {
                multilineTokenSupport = true;
              };
            };
          };
          root_markers = [
            ".git"
          ];
        };
      };

      typos_lsp = {
        enable = true;
        config = {
          init_options = {
            diagnosticSeverity = "Hint";
          };
          filetypes = [
            "markdown"
            "text"
            "gitcommit"
            "gitrebase"
            "mail"
          ];
        };
      };

      nushell.enable = true;
      qmlls.enable = pkgs.stdenv.hostPlatform.isLinux;
      sqls.enable = true;
      taplo.enable = true;
    };

    # keymaps.lspBuf = {
    #   "<c-k>" = "signature_help";
    #   "gi" = "implementation";
    # };
  };

  keymapsOnEvents.LspAttach = [
    # Diagnostic keymaps
    {
      key = "<leader>lH";
      mode = "n";
      action = lib.nixvim.mkRaw "vim.diagnostic.open_float";
      options = {
        silent = true;
        desc = "Lsp diagnostic open_float";
      };
    }
  ]
  ++
    lib.optionals
      (
        !config.plugins.fzf-lua.enable
        || (config.plugins.snacks.enable && lib.hasAttr "picker" config.plugins.snacks.settings)
      )
      [
        # Code action keymap (if fzf-lua is not enabled)
        {
          key = "<leader>la";
          mode = "n";
          action = lib.nixvim.mkRaw "vim.lsp.buf.code_action";
          options = {
            silent = true;
            desc = "Lsp buf code_action";
          };
        }
      ];

  plugins = {
    lspconfig.enable = true;
    lint = {
      enable = true;

      lazyLoad.settings.event = "DeferredUIEnter";
    };

    lsp-signature.enable = true;

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>l";
        group = "LSP";
        icon = " ";
        mode = [
          "n"
          "v"
        ];
      }
      {
        __unkeyed-1 = "<leader>l[";
        desc = "Prev";
      }
      {
        __unkeyed-1 = "<leader>l]";
        desc = "Next";
      }
      {
        __unkeyed-1 = "<leader>la";
        desc = "Code Action";
      }
      {
        __unkeyed-1 = "<leader>ld";
        desc = "Definition";
      }
      {
        __unkeyed-1 = "<leader>lD";
        desc = "References";
      }
      # {
      #   __unkeyed-1 = "<leader>lf";
      #   desc = "Format";
      # }
      {
        __unkeyed-1 = "<leader>lh";
        desc = "Lsp Hover";
      }
      {
        __unkeyed-1 = "<leader>lH";
        desc = "Diagnostic Hover";
      }
      {
        __unkeyed-1 = "<leader>li";
        desc = "Implementation";
      }
      {
        __unkeyed-1 = "<leader>lr";
        desc = "Rename";
      }
      {
        __unkeyed-1 = "<leader>lt";
        desc = "Type Definition";
      }
    ];
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>cl";
      action = "<cmd>LspInfo<cr>";
      options.desc = "Lsp Info";
    }
  ];
}
