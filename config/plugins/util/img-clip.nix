{
  plugins = {
    img-clip = {
      enable = true;
      lazyLoad.settings = {
        event = [ "DeferredUIEnter" ];
        keys = [
          {
            __unkeyed-1 = "<leader>P";
            __unkeyed-2 = "<cmd>PasteImage<cr>";
            desc = "Paste image from system clipboard";
          }
        ];
      };

      settings = {
        default = {
          prompt_for_file_name = false;
          drag_and_drop = {
            enabled = true;
            insert_mode = true;
          };
        };
      };
    };
  };
}
