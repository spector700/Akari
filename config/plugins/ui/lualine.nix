{ icons, ... }:
{
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        always_divide_middle = true;
        ignore_focus = [ "neo-tree" ];
        globalstatus = true; # have a single statusline at bottom of neovim instead of one for every window
        disabled_filetypes.statusline = [
          "dashboard"
          "alpha"
        ];
        section_separators = {
          left = "";
          right = "";
        };
      };
      extensions = [ "fzf" ];
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];

        lualine_y = [
          {
            __unkeyed = "progress";
            separator = "";
          }
          {
            __unkeyed = "location";
            separator = "";
            padding = {
              left = 0;
              right = 1;
            };
          }
        ];
        lualine_z = [
          ''"${icons.ui.Time}" .. os.date("%R")''
        ];
      };
    };
  };
  extraConfigLua = ''
      local ui = {}

      function ui.fg(name)
        local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
        local fg = hl and (hl.fg or hl.foreground)
        return fg and { fg = string.format("#%06x", fg) } or nil
      end

      ---@param opts? {relative: "cwd"|"root", modified_hl: string?}
      function ui.pretty_path(opts)
        opts = vim.tbl_extend("force", {
          relative = "cwd",
          modified_hl = "Constant",
        }, opts or {})

        return function(self)
          local path = vim.fn.expand("%:p") --[[@as string]]

          if path == "" then
            return ""
          end

          local bufname = vim.fn.bufname(vim.fn.bufnr())
          local sep = package.config:sub(1, 1)

          local root = (opts.relative == "root") and vim.fn.getcwd() or vim.fn.fnamemodify(bufname, ":h")
          local cwd = vim.fn.getcwd()

          path = (opts.relative == "cwd" and path:find(cwd, 1, true) == 1) and path:sub(#cwd + 2) or path:sub(#root + 2)

          local parts = vim.split(path, "[\\/]")
          if #parts > 3 then
            parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
          end

          if opts.modified_hl and vim.bo.modified then
            local modified_hl_fg = ui.fg(opts.modified_hl)
            if modified_hl_fg then
              parts[#parts] = string.format("%%#%s#%s%%*", opts.modified_hl, parts[#parts])
            end
          end

          return table.concat(parts, sep)
        end
      end

      require("lualine").setup({
          sections = {
            lualine_c = {
                {
                  "diagnostics",
                  symbols = {
                    error = "${icons.diagnostics.Error}",
                    warn  = "${icons.diagnostics.Warning}",
                    hint  = "${icons.diagnostics.Hint}",
                    info  = "${icons.diagnostics.BoldInformation}",
                  },
                  separator = ")"
                },
                { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                { ui.pretty_path() },
            },

          lualine_x = {
              {
                function() return require("noice").api.status.command.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                color = ui.fg("Statement"),
                separator = "(",
              },
              {
                function() return require("noice").api.status.mode.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                color = ui.fg("Constant"),
                separator = "(",
              },
              {
                function() return "${icons.diagnostics.Debug}" .. require("dap").status() end,
                cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
                color = ui.fg("Debug"),
                separator = "(",
              },
              {
                  function()
                      local msg = ""
                      local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                      local clients = vim.lsp.get_clients()
                      if next(clients) == nil then
                          return msg
                      end
                      for _, client in ipairs(clients) do
                          local filetypes = client.config.filetypes
                          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                              return client.name
                          end
                      end
                      return msg
                  end,

                  color = ui.fg("StatusLine"),
                  separator = "(",
              },
              {
              "diff",
              symbols = {
                added = "${icons.git.LineAdded}",
                modified = "${icons.git.LineModified}",
                removed= "${icons.git.LineRemoved}",
                },
              },
          }
      }
    })
  '';
}
