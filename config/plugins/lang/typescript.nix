{ pkgs, ... }:
{
  lsp.servers = {
    biome = {
      enable = true;
      config.filetypes = [
        "javascript"
        "javascriptreact"
        "typescript"
        "typescriptreact"
        "json"
        "jsonc"
        "css"
        "html"
      ];
    };

    eslint.enable = true;
  };

  plugins = {
    conform-nvim.settings = {
      formatters_by_ft = {
        javascript = [ "eslint_d" ];
        javascriptreact = [ "eslint_d" ];
        typescript = [ "eslint_d" ];
        typescriptreact = [ "eslint_d" ];
        svelte = [ "eslint_d" ];
      };
    };

    typescript-tools = {
      enable = true;

      lazyLoad.settings.ft = [
        "typescript"
        "javascript"
        "typescriptreact"
        "javascriptreact"
      ];

      settings = {
        settings = {
          code_lens = "off";
          complete_function_calls = false;
          disable_member_code_lens = true;
          expose_as_code_action = "all";
          include_completions_with_insert_text = true;
          publish_diagnostic_on = "insert_leave";
          separate_diagnostic_server = true;
          tsserver_locale = "en";
          tsserver_max_memory = "auto";
          tsserver_path = "${pkgs.typescript}/lib/node_modules/typescript/lib/tsserver.js";
          jsx_close_tag = {
            enable = false;
            filetypes = [
              "javascriptreact"
              "typescriptreact"
            ];
          };
        };
      };
    };

    # ts-autotag.enable = true;
  };
}
