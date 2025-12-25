{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./blink-sources.nix
    ./blink-community-plugins.nix
  ];

  extraPackages = lib.mkIf config.plugins.blink-cmp.enable (
    with pkgs;
    [
      # blink-cmp-git
      gh
      # blink-cmp-dictionary
      wordnet
      glab
    ]
  );

  extraPlugins = with pkgs.vimPlugins; [
    blink-cmp-conventional-commits
    blink-cmp-npm-nvim
    blink-cmp-yanky
    blink-nerdfont-nvim
  ];

  plugins = {
    blink-cmp = {
      enable = true;

      lazyLoad.settings.event = [
        "InsertEnter"
        "CmdlineEnter"
      ];

      settings = {
        cmdline = {
          completion = {
            list.selection = {
              preselect = false;
            };
            menu.auto_show = true;
          };

          keymap = {
            preset = "enter";
            "<CR>" = [
              "accept_and_enter"
              "fallback"
            ];
          };
        };

        completion = {
          accept.auto_brackets = {
            override_brackets_for_filetypes = {
              lua = [
                "{"
                "}"
              ];
              nix = [
                "{"
                "}"
              ];
            };
          };

          ghost_text.enabled = true;

          trigger = {
            prefetch_on_insert = true;
            show_on_backspace = true;
            # Disabled: Prefer manual completion control with <C-.>
            # Uncomment to auto-show after typing these characters:
            # show_on_x_blocked_trigger_characters = [
            #   " "
            #   ";"
            # ];
          };

          documentation = {
            auto_show = true;
            window.border = "rounded";
          };

          list.selection = {
            preselect = false;
          };

          menu = {
            border = "rounded";
            direction_priority.__raw = ''
              function()
                local ctx = require('blink.cmp').get_context()
                local item = require('blink.cmp').get_selected_item()
                if ctx == nil or item == nil then return { 's', 'n' } end

                local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
                local is_multi_line = item_text:find('\n') ~= nil

                -- after showing the menu upwards, we want to maintain that direction
                -- until we re-open the menu, so store the context id in a global variable
                if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
                  vim.g.blink_cmp_upwards_ctx_id = ctx.id
                  return { 'n', 's' }
                end
                return { 's', 'n' }
              end
            '';

            draw = {
              snippet_indicator = "◦";
              treesitter = [ "lsp" ];
              columns.__raw = ''
                function()
                    return {
                      { "label" },
                      { "kind_icon", "kind", gap = 1 },
                      { "source_name", gap = 1 }
                    }
                end
              '';

              components = {
                kind_icon = {
                  ellipsis = false;
                  text.__raw = ''
                    function(ctx)
                      local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                      -- Check for both nil and the default fallback icon
                      if not kind_icon or kind_icon == '󰞋' then
                        -- Use our configured kind_icons
                        return require('blink.cmp.config').appearance.kind_icons[ctx.kind] or ""
                      end
                      return kind_icon
                    end,
                    -- Optionally, you may also use the highlights from mini.icons
                    highlight = function(ctx)
                      local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                      return hl
                    end
                  '';
                };
              };
            };
          };
        };

        fuzzy = {
          implementation = "rust";
          sorts = [
            "exact"
            "score"
            "sort_text"
          ];
          prebuilt_binaries = {
            download = false;
          };
        };

        appearance = {
          kind_icons = {
            Copilot = "";
            Text = "";
            Field = "";
            Variable = "";

            Class = "";
            Interface = "";

            TypeParameter = "";
          };
        };

        keymap = {
          preset = "enter";
          "<C-.>" = [
            "show"
            "show_documentation"
            "hide_documentation"
          ];
          "<C-Up>" = [
            "snippet_forward"
            "fallback"
          ];
          "<C-Down>" = [
            "snippet_backward"
            "fallback"
          ];
          # "<Tab>" = [
          #   "select_next"
          #   "fallback"
          # ];
          # "<S-Tab>" = [
          #   "select_prev"
          #   "fallback"
          # ];
          "<C-y>" =
            lib.optionals config.plugins.sidekick.enable [
              {
                __raw = ''
                  function()
                    return require("sidekick").nes_jump_or_apply()
                  end
                '';
              }
            ]
            ++ lib.optionals config.plugins.copilot-lua.enable [
              {
                __raw = ''
                  function(cmp)
                    if vim.b[vim.api.nvim_get_current_buf()].nes_state then
                      cmp.hide()
                      return (
                        require("copilot-lsp.nes").apply_pending_nes()
                        and require("copilot-lsp.nes").walk_cursor_end_edit()
                      )
                    end
                    if cmp.snippet_active() then
                      return cmp.accept()
                    else
                      return cmp.select_and_accept()
                    end
                  end
                '';
              }
            ]
            ++ [ "fallback" ];
        };

        signature = {
          enabled = true;
          window.border = "rounded";
        };

        snippets.preset = "mini_snippets";
      };
    };
  };
}
