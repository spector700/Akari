{
  config,
  lib,
  ...
}:
{
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  keymaps =
    let
      normal =
        lib.mapAttrsToList
          (
            key:
            { action, ... }@attrs:
            {
              mode = "n";
              inherit action key;
              options = attrs.options or { };
            }
          )
          (
            {
              "<Space>" = {
                action = "<NOP>";
              };

              # Esc to clear search results
              "<esc>" = {
                action = "<cmd>noh<CR>";
              };

              # Copy stuff to system clipboard with <leader> + y or just y to have it just in vim
              "<leader>y" = {
                action = "\"+y";
                options = {
                  desc = "Copy to system clipboard";
                };
              };

              # fix Y behaviour
              "Y" = {
                action = "y$";
              };

              # back and fourth between the two most recent files
              "<C-c>" = {
                action = "<cmd>b#<CR>";
              };

              # navigate to left/right window
              "<C-Left>" = {
                action = "<C-w>h";
                options = {
                  desc = "Left window";
                };
              };
              "<C-Right>" = {
                action = "<C-w>l";
                options = {
                  desc = "Right window";
                };
              };
              "<C-Down>" = {
                action = "<C-w>j";
                options = {
                  desc = "Up window";
                };
              };
              "<C-Up>" = {
                action = "<C-w>k";
                options = {
                  desc = "Down window";
                };
              };

              # navigate quickfix list
              "<C-[>" = {
                action = "<cmd>cnext<CR>";
              };
              "<C-]>" = {
                action = "<cmd>cprev<CR>";
              };

              # resize with arrows
              "<C-S-Up>" = {
                action = "<cmd>resize -2<CR>";
              };
              "<C-S-Down>" = {
                action = "<cmd>resize +2<CR>";
              };
              "<C-S-Left>" = {
                action = "<cmd>vertical resize +2<CR>";
              };
              "<C-S-Right>" = {
                action = "<cmd>vertical resize -2<CR>";
              };

              "<C-s>" = {
                action = "<Cmd>w<CR><esc>";
                options = {
                  desc = "Save";
                };
              };

              "<Down>" = {
                action = "v:count == 0 ? 'gj' : 'j'";
                options = {
                  desc = "Move cursor down";
                  expr = true;
                };
              };
              "<Up>" = {
                action = "v:count == 0 ? 'gk' : 'k'";
                options = {
                  desc = "Move cursor up";
                  expr = true;
                };
              };
              "<Leader>q" = {
                action = "<Cmd>confirm q<CR>";
                options = {
                  desc = "Quit";
                };
              };
              "<C-n>" = {
                action = "<Cmd>enew<CR>";
                options = {
                  desc = "New file";
                };
              };
              "<leader>ws" = {
                action = "<Cmd>w!<CR>";
                options = {
                  desc = "Force write";
                };
              };
              "<leader>Q" = {
                action = "<Cmd>q!<CR>";
                options = {
                  desc = "Force quit";
                };
              };
              "|" = {
                action = "<Cmd>vsplit<CR>";
                options = {
                  desc = "Vertical split";
                };
              };
              "-" = {
                action = "<Cmd>split<CR>";
                options = {
                  desc = "Horizontal split";
                };
              };

              # "<leader>b]" = {
              #   action = "<cmd>bnext<CR>";
              #   options = {
              #     desc = "Next buffer";
              #   };
              # };
              "<TAB>" = {
                action = "<cmd>bnext<CR>";
                options = {
                  desc = "Next buffer (default)";
                };
              };
              # "<leader>b[" = {
              #   action = "<cmd>bprevious<CR>";
              #   options = {
              #     desc = "Previous buffer";
              #   };
              # };
              "<S-TAB>" = {
                action = "<cmd>bprevious<CR>";
                options = {
                  desc = "Previous buffer";
                };
              };
              "<leader>wd" = {
                action = "<C-W>c";
                options = {
                  desc = "Close current buffer";
                };
              };
            }
            // (lib.optionalAttrs
              (
                !(
                  config.plugins.snacks.enable
                  && lib.hasAttr "toggle" config.plugins.snacks.settings
                  && config.plugins.snacks.settings.toggle.enabled
                )
              )
              {
                "<leader>ud" = {
                  action.__raw = ''
                    function ()
                      vim.b.disable_diagnostics = not vim.b.disable_diagnostics
                      if vim.b.disable_diagnostics then
                        vim.diagnostic.disable(0)
                      else
                        vim.diagnostic.enable(0)
                      end
                      vim.notify(string.format("Buffer Diagnostics %s", bool2str(not vim.b.disable_diagnostics), "info"))
                    end'';
                  options = {
                    desc = "Buffer Diagnostics toggle";
                  };
                };

                "<leader>uD" = {
                  action.__raw = ''
                    function ()
                      vim.g.disable_diagnostics = not vim.g.disable_diagnostics
                      if vim.g.disable_diagnostics then
                        vim.diagnostic.disable()
                      else
                        vim.diagnostic.enable()
                      end
                      vim.notify(string.format("Global Diagnostics %s", bool2str(not vim.g.disable_diagnostics), "info"))
                    end'';
                  options = {
                    desc = "Global Diagnostics toggle";
                  };
                };

                "<leader>uS" = {
                  action.__raw = ''
                    function ()
                      if vim.g.spell_enabled then vim.cmd('setlocal nospell') end
                      if not vim.g.spell_enabled then vim.cmd('setlocal spell') end
                      vim.g.spell_enabled = not vim.g.spell_enabled
                      vim.notify(string.format("Spell %s", bool2str(vim.g.spell_enabled), "info"))
                    end'';
                  options = {
                    desc = "Spell toggle";
                  };
                };

                "<leader>uw" = {
                  action.__raw = ''
                    function ()
                      vim.wo.wrap = not vim.wo.wrap
                      vim.notify(string.format("Wrap %s", bool2str(vim.wo.wrap), "info"))
                    end'';
                  options = {
                    desc = "Word Wrap toggle";
                  };
                };
                "<leader>uh" = {
                  action.__raw = ''
                    function ()
                      local curr_foldcolumn = vim.wo.foldcolumn
                      if curr_foldcolumn ~= "0" then vim.g.last_active_foldcolumn = curr_foldcolumn end
                      vim.wo.foldcolumn = curr_foldcolumn == "0" and (vim.g.last_active_foldcolumn or "1") or "0"
                      vim.notify(string.format("Fold Column %s", bool2str(vim.wo.foldcolumn), "info"))
                    end'';
                  options = {
                    desc = "Fold Column toggle";
                  };
                };

                "<leader>uT" = {
                  action = "<cmd>TabsToggle<CR>";
                  options = {
                    desc = "Toggle tabs/spaces";
                  };
                };
              }
            )
            // {
              # Autoformat toggles (no snacks equivalent, always available)
              "<leader>uf" = {
                action.__raw = ''
                  function ()
                    vim.cmd('FormatToggle!')
                    vim.notify(string.format("Buffer Autoformatting %s", bool2str(not vim.b[0].disable_autoformat), "info"))
                  end'';
                options = {
                  desc = "Buffer Autoformatting toggle";
                };
              };

              "<leader>uF" = {
                action.__raw = ''
                  function ()
                    vim.cmd('FormatToggle')
                    vim.notify(string.format("Global Autoformatting %s", bool2str(not vim.g.disable_autoformat), "info"))
                  end'';
                options = {
                  desc = "Global Autoformatting toggle";
                };
              };

              # Base diff keybinds - always available
              "<leader>gdd" = {
                action = "<cmd>diffthis<CR>";
                options = {
                  desc = "Add file to diff";
                };
              };
              "<leader>gdc" = {
                action = "<cmd>diffoff<CR>";
                options = {
                  desc = "Close diff mode";
                };
              };
              "<leader>gdC" = {
                action = "<cmd>diffoff!<CR>";
                options = {
                  desc = "Close diff mode (all windows)";
                };
              };
            }
            // (lib.optionalAttrs (!config.plugins.gitsigns.enable) {
              "<leader>gD" = {
                action.__raw = ''
                  function()
                    if vim.wo.diff then
                      vim.cmd('diffoff')
                    else
                      vim.cmd('diffthis')
                    end
                  end
                '';
                options = {
                  desc = "Toggle Diff (Primary)";
                };
              };
            })
            // (lib.optionalAttrs (!config.plugins.visual-whitespace.enable) {
              "<leader>uW" = {
                action.__raw = ''
                  function ()
                    if (not vim.g.whitespace_character_enabled) then
                      vim.cmd('set listchars=eol:¬,tab:>→,trail:~,extends:>,precedes:<,space:·')
                      vim.cmd('set list')
                    else
                      vim.cmd('set nolist')
                    end
                    vim.g.whitespace_character_enabled = not vim.g.whitespace_character_enabled
                    vim.notify(string.format("Showing white space characters %s", bool2str(vim.g.whitespace_character_enabled), "info"))
                  end'';
                options = {
                  desc = "White space character toggle";
                };
              };
            })
            // (lib.optionalAttrs
              (
                !config.plugins.snacks.enable
                || (config.plugins.snacks.enable && config.plugins.snacks.settings.bufdelete.enabled)
              )
              {
                "<leader>wC" = {
                  action = "<cmd>%bd!<CR>";
                  options = {
                    desc = "Close all buffers";
                  };
                };
              }
            )
          );
      visual =
        lib.mapAttrsToList
          (
            key:
            { action, ... }@attrs:
            {
              mode = "v";
              inherit action key;
              options = attrs.options or { };
            }
          )
          {
            # Copy stuff to system clipboard with <leader> + y or just y to have it just in vim
            "<leader>y" = {
              action = "\"+y";
              options = {
                desc = "Copy to system clipboard";
              };
            };
            # Better indenting
            "<S-Tab>" = {
              action = "<gv";
              options = {
                desc = "Unindent line";
              };
            };
            "<" = {
              action = "<gv";
              options = {
                desc = "Unindent line";
              };
            };
            "<Tab>" = {
              action = ">gv";
              options = {
                desc = "Indent line";
              };
            };
            ">" = {
              action = ">gv";
              options = {
                desc = "Indent line";
              };
            };

            # Move selected line/block in visual mode
            "K" = {
              action = "<cmd>m '<-2<CR>gv=gv<cr>";
            };
            "J" = {
              action = "<cmd>m '>+1<CR>gv=gv<cr>";
            };
          };

      insert =
        lib.mapAttrsToList
          (
            key:
            { action, ... }@attrs:
            {
              mode = "i";
              inherit action key;
              options = attrs.options or { };
            }
          )
          {
            # Move selected line/block in insert mode
            "<C-Up>" = {
              action = "<C-o>gk";
            };
            "<C-Left>" = {
              action = "<Left>";
            };
            "<C-Right>" = {
              action = "<Right>";
            };
            "<C-Down>" = {
              action = "<C-o>gj";
            };
            # Select all lines in buffer
            "<C-a>" = {
              action = "<cmd> norm! ggVG<cr>";
            };
          };
    in
    lib.nixvim.keymaps.mkKeymaps { options.silent = true; } (normal ++ visual ++ insert);
}

# {
#   globals = {
#     mapleader = " ";
#     maplocalleader = " ";
#   };
#
#   keymaps = [
#     {
#       mode = "n";
#       key = "<Space>";
#       action = "<NOP>";
#     }
#
#     # Windows
#     {
#       mode = "n";
#       key = "<C-Up>";
#       action = "<C-w>k";
#       options.desc = "Move To Window Up";
#     }
#
#     {
#       mode = "n";
#       key = "<C-Down>";
#       action = "<C-w>j";
#       options.desc = "Move To Window Down";
#     }
#
#     {
#       mode = "n";
#       key = "<C-Left>";
#       action = "<C-w>h";
#       options.desc = "Move To Window Left";
#     }
#
#     {
#       mode = "n";
#       key = "<C-Right>";
#       action = "<C-w>l";
#       options.desc = "Move To Window Right";
#     }
#
#     {
#       mode = "n";
#       key = "<leader>wd";
#       action = "<C-W>c";
#       options = {
#         silent = true;
#         desc = "Delete window";
#       };
#     }
#
#     {
#       mode = "n";
#       key = "<leader>-";
#       action = "<C-W>s";
#       options = {
#         silent = true;
#         desc = "Split window below";
#       };
#     }
#
#     {
#       mode = "n";
#       key = "<leader>|";
#       action = "<C-W>v";
#       options = {
#         silent = true;
#         desc = "Split window right";
#       };
#     }
#
#     {
#       mode = "n";
#       key = "<C-s>";
#       action = "<cmd>w<cr><esc>";
#       options = {
#         silent = true;
#         desc = "Save file";
#       };
#     }
#
#     # Quit/Session
#     {
#       mode = "n";
#       key = "<leader>qq";
#       action = "<cmd>quitall<cr><esc>";
#       options = {
#         silent = true;
#         desc = "Quit all";
#       };
#     }
#
#     {
#       mode = "n";
#       key = "<leader>ul";
#       action = ":lua ToggleLineNumber()<cr>";
#       options = {
#         silent = true;
#         desc = "Toggle Line Numbers";
#       };
#     }
#
#     {
#       mode = "n";
#       key = "<leader>uL";
#       action = ":lua ToggleRelativeLineNumber()<cr>";
#       options = {
#         silent = true;
#         desc = "Toggle Relative Line Numbers";
#       };
#     }
#
#     {
#       mode = "n";
#       key = "<leader>uw";
#       action = ":lua ToggleWrap()<cr>";
#       options = {
#         silent = true;
#         desc = "Toggle Line Wrap";
#       };
#     }
#     )
#     }
#     //
#
#     # Move Lines
#     {
#       mode = "n";
#       key = "<A-Up>";
#       action = "<cmd>m .-2<cr>==";
#       options.desc = "Move line up";
#     }
#
#     {
#       mode = "v";
#       key = "<A-Up>";
#       action = ":m '<-2<cr>gv=gv";
#       options.desc = "Move line up";
#     }
#
#     {
#       mode = "n";
#       key = "<A-Down>";
#       action = "<cmd>m .+1<cr>==";
#       options.desc = "Move line down";
#     }
#
#     {
#       mode = "v";
#       key = "<A-Down>";
#       action = ":m '>+1<cr>gv=gv";
#       options.desc = "Move line Down";
#     }
#
#     # Better indenting
#     {
#       mode = "v";
#       key = "<";
#       action = "<gv";
#     }
#
#     {
#       mode = "v";
#       key = ">";
#       action = ">gv";
#     }
#
#     {
#       mode = "i";
#       key = "<C-a>";
#       action = "<cmd> norm! ggVG<cr>";
#       options.desc = "Select all lines in buffer";
#     }
#
#     {
#       mode = "n";
#       key = "J";
#       action = "mzJ`z";
#       options.desc = "Allow cursor to stay in the same place after appending to current line ";
#     }
#
#     # {
#     #   mode = "n";
#     #   key = "<C-d>";
#     #   action = "<C-d>zz";
#     #   options.desc = "Allow C-d and C-u to keep the cursor in the middle";
#     # }
#     #
#     # {
#     #   mode = "n";
#     #   key = "<C-u>";
#     #   action = "<C-u>zz";
#     #   options.desc = "Allow C-d and C-u to keep the cursor in the middle";
#     # }
#
#     {
#       mode = "n";
#       key = "n";
#       action = "nzzzv";
#       options.desc = "Allow search terms to stay in the middle";
#     }
#
#     {
#       mode = "n";
#       key = "N";
#       action = "Nzzzv";
#       options.desc = "Allow search terms to stay in the middle";
#     }
#
#     # Clear search with ESC
#     {
#       mode = [
#         "n"
#         "i"
#       ];
#       key = "<esc>";
#       action = "<cmd>noh<cr><esc>";
#       options = {
#         silent = true;
#         desc = "Escape and clear hlsearch";
#       };
#     }
#
#     # Paste stuff without saving the deleted word into the buffer
#     {
#       mode = "x";
#       key = "p";
#       action = "\"_dP";
#       options.desc = "Deletes to void register and paste over";
#     }
#
#     # Copy stuff to system clipboard with <leader> + y or just y to have it just in vim
#     {
#       mode = [
#         "n"
#         "v"
#       ];
#       key = "<leader>y";
#       action = "\"+y";
#       options.desc = "Copy to system clipboard";
#     }
#
#     # Delete to void register
#     {
#       mode = [
#         "n"
#         "v"
#       ];
#       key = "<leader>D";
#       action = "\"_d";
#       options.desc = "Delete to void register";
#     }
#   ];
#   extraConfigLua = ''
#     function ToggleLineNumber()
#     if vim.wo.number then
#       vim.wo.number = false
#     else
#       vim.wo.number = true
#       vim.wo.relativenumber = false
#       end
#     end
#
#     function ToggleRelativeLineNumber()
#     if vim.wo.relativenumber then
#       vim.wo.relativenumber = false
#     else
#       vim.wo.relativenumber = true
#       vim.wo.number = false
#       end
#     end
#
#     function ToggleWrap()
#         vim.wo.wrap = not vim.wo.wrap
#     end
#
#      if vim.lsp.inlay_hint then
#        vim.keymap.set('n', '<leader>uh', function()
#          vim.lsp.inlay_hint(0, nil)
#        end, { desc = 'Toggle Inlay Hints' })
#      end
#   '';
# }
