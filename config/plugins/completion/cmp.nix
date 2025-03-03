{ lib, helpers, ... }:
{
  plugins = {
    cmp = {
      enable = false;
      autoEnableSources = true;

      cmdline = {
        "/" = {
          mapping.__raw = "cmp.mapping.preset.cmdline()";
          sources = [ { name = "buffer"; } ];
        };
        ":" = {
          mapping.__raw = "cmp.mapping.preset.cmdline()";
          sources = [
            { name = "path"; }
            {
              name = "cmdline";
              option.ignore_cmds = [
                "Man"
                "!"
              ];
            }
          ];
        };
      };

      filetype = {
        sql.sources = [
          { name = "buffer"; }
          { name = "vim-dadbod-completion"; }
        ];
      };

      settings = {
        # Preselect first entry
        completion.completeopt = "menu,menuone,noinsert";
        sources = [
          {
            name = "nvim_lsp";
            priority = 100;
          }
          {
            name = "nvim_lsp_signature_help";
            priority = 100;
          }
          {
            name = "nvim_lsp_document_symbol";
            priority = 100;
          }
          {
            name = "treesitter";
            priority = 80;
          }
          {
            name = "luasnip";
            priority = 70;
          }
          {
            name = "codeium";
            priority = 60;
          }
          {
            name = "buffer";
            priority = 50;
            # Words from other open buffers can also be suggested.
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            keywordLength = 3;
          }
          {
            name = "path";
            priority = 30;
          }
          {
            name = "git";
            priority = 20;
          }
          {
            name = "npm";
            priority = 20;
          }
          {
            name = "zsh";
            priority = 20;
          }
          {
            name = "calc";
            priority = 10;
          }
          {
            name = "emoji";
            priority = 5;
          }

          # Disable this if running tests with nix flake check
          (lib.mkIf helpers.enableExceptInTests { name = "nixpkgs_maintainers"; })
        ];

        window = {
          completion.border = "rounded";
          documentation.border = "rounded";
        };
        experimental.ghost_text = true;

        mapping = {
          "<Tab>".__raw = ''
            cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if luasnip.locally_jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';

          "<S-Tab>".__raw = ''
            cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';

          "<C-n>" = # lua
            "cmp.mapping(cmp.mapping.select_next_item())";
          "<C-p>" = # lua
            "cmp.mapping(cmp.mapping.select_prev_item())";
          "<C-e>" = # lua
            "cmp.mapping.abort()";
          "<C-d>" = # lua
            "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = # lua
            "cmp.mapping.scroll_docs(4)";
          "<Up>" = # lua
            "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Down>" = # lua
            "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<CR>" = # lua
            "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
          "<C-Space>" = # lua
            "cmp.mapping.complete()";
        };

        snippet.expand = # lua
          ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
      };
    };
  };
}
