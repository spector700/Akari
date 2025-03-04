{ config, lib, ... }:
{
  plugins = {
    copilot-lua = {
      enable = true;
      settings = {
        panel.enabled = !config.plugins.blink-cmp-copilot.enable;
        suggestion.enabled = !config.plugins.blink-cmp-copilot.enable;
      };
    };

    copilot-chat = {
      inherit (config.plugins.copilot-lua) enable;
    };

    # which-key.settings.spec = [
    #   {
    #     __unkeyed-1 = "<leader>a";
    #     mode = "n";
    #     icon = "";
    #     group = "+ai";
    #   }
    # ];
  };

  # keymaps = lib.mkIf config.plugins.copilot-chat.enable [
  #   {
  #     mode = "n";
  #     key = "<leader>ac";
  #     action = "<cmd>CopilotChatToggle<CR>";
  #     options.desc = "Toggle Coilot Chat Window";
  #   }
  #   {
  #     mode = "n";
  #     key = "<leader>aq";
  #     action.__raw = ''
  #       function()
  #         local input = vim.fn.input("Quick Chat: ")
  #         if input ~= "" then
  #           require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  #         end
  #       end
  #     '';
  #     options.desc = "Quick Chat";
  #   }
  #   {
  #     mode = "n";
  #     key = "<leader>ah";
  #     action.__raw = ''
  #       function()
  #         local actions = require("CopilotChat.actions")
  #         require("CopilotChat.integrations.telescope").pick(actions.help_actions())
  #       end
  #     '';
  #     options.desc = "Help Actions";
  #   }
  #   {
  #     mode = "n";
  #     key = "<leader>ap";
  #     action.__raw = ''
  #       function()
  #         local actions = require("CopilotChat.actions")
  #         require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
  #       end
  #     '';
  #     options.desc = "Prompt Actions";
  #   }
  #   {
  #     mode = "n";
  #     key = "<leader>aa";
  #     action = "<cmd>CopilotChatAgents<CR>";
  #     options.desc = "List Available Agents";
  #   }
  #   {
  #     mode = "n";
  #     key = "<leader>al";
  #     action = "<cmd>CopilotChatLoad<CR>";
  #     options.desc = "Load Chat History";
  #   }
  #   {
  #     mode = "n";
  #     key = "<leader>am";
  #     action = "<cmd>CopilotChatModels<CR>";
  #     options.desc = "List Available Models";
  #   }
  # ];
}
