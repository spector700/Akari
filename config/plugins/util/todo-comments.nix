{ config, lib, ... }:
let
  inherit (lib) mkIf optional optionalString;
in
{
  plugins.todo-comments = {
    enable = true;

    lazyLoad = {
      # NOTE: Plugin highlighting feature not used until loaded.
      enable = false;
      settings = {
        before.__raw = mkIf config.plugins.lz-n.enable (
          ''
            function()
          ''
          + optionalString config.plugins.trouble.enable ''
            require('lz.n').trigger_load('trouble.nvim')
          ''
          + optionalString config.plugins.snacks.enable ''
            require('lz.n').trigger_load('snacks.nvim')
          ''
          + ''
            end
          ''
        );
        keys = mkIf (config.khanelivim.picker.tool == "snacks") [
          {
            __unkeyed-1 = "<leader>ft";
            __unkeyed-2 = ''<CMD>lua Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" }})<CR>'';
            desc = "Find TODOs";
          }
        ];
        cmd = [
          "TodoLocList"
          "TodoQuickFix"
        ]
        ++ optional config.plugins.trouble.enable "TodoTrouble";
      };
    };

    keymaps = {
      todoTrouble.key = mkIf config.plugins.trouble.enable "<leader>xq";
      # Fallback if snacks picker not enabled
    };
  };
}
