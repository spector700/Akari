{ config, lib, ... }:
{
  plugins.noice = {
    enable = true;
    settings = {
      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
        notify.enabled = true;
        progress.enabled = true;
        signature.enabled = !config.plugins.lsp-signature.enable;
      };

      presets = {
        bottom_search = false;
        command_palette = true;
        long_message_to_split = true;
        inc_rename = true;
        lsp_doc_border = true;
      };

      routes = [
        {
          filter = {
            event = "msg_show";
            any = [
              { find = "%d+L, %d+B"; }
              { find = "; after #%d+"; }
              { find = "; before #%d+"; }
            ];
          };
          view = "mini";
        }
      ];
    };
  };
  keymaps = lib.mkIf (config.plugins.telescope.enable && config.plugins.noice.enable) [
    {
      mode = "n";
      key = "<leader>sn";
      action = "<cmd>Telescope noice<CR>";
      options = {
        desc = "Find notifications";
      };
    }
  ];
}
