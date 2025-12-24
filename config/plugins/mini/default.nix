{ lib, config, ... }:
{
  imports = [
    ./hipatterns.nix
    ./move.nix
    ./splitjoin.nix
  ];

  plugins = {
    mini.enable = true;

    mini-ai.enable = true;
    mini-basics.enable = true;
    mini-bracketed.enable = true;

    mini-comment = {
      enable = true;
      # settings = {
      #   mappings = {
      #     comment = "<leader>/";
      #     comment_line = "<leader>/";
      #     comment_visual = "<leader>/";
      #     textobject = "<leader>/";
      #   };
      # };
    };

    mini-icons = {
      enable = true;
      mockDevIcons = true;
    };

    # Keymaps:
    # visual:
    # <C-j>: open snippet selections / expand snippet
    # <Tab>: jump next
    # <S-Tab>: jump previous
    # <C-c>: stop
    # Start session at first tabstop. Type text to replace placeholder. When finished with current tabstop, jump to next with <C-l>. Repeat. If changed mind about some previous tabstop, jump back with <C-h>. Jumping also wraps around the edge (first tabstop is next after final).
    # If tabstop has choices, use <C-n> / <C-p> to select next / previous item.

    mini-snippets = {
      enable = true;
      settings = {
        snippets = {
          __unkeyed-1.__raw = lib.mkIf config.plugins.friendly-snippets.enable "require('mini.snippets').gen_loader.from_file('${config.plugins.friendly-snippets.package}/snippets/global.json')";
          __unkeyed-2.__raw = "require('mini.snippets').gen_loader.from_lang()";
        };
      };
    };
  };
}
