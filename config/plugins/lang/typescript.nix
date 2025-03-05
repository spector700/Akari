{ pkgs, lib, ... }:
{

  plugins = {
    conform-nvim.settings = {
      formatters_by_ft = {
        javascript = [ "eslint_d" ];
        javascriptreact = [ "eslint_d" ];
        typescript = [ "eslint_d" ];
        typescriptreact = [ "eslint_d" ];
        svelte = [ "eslint_d" ];
      };

      formatters.eslint_d = {
        command = lib.getExe pkgs.eslint_d;
      };
    };

    lsp.servers = {
      svelte.enable = true;

      eslint = {
        enable = true;
        filetypes = [
          "javascript"
          "javascriptreact"
          "javascript.jsx"
          "typescript"
          "typescriptreact"
          "typescript.tsx"
          "vue"
          "html"
          "markdown"
          "json"
          "jsonc"
          "yaml"
          "toml"
          "xml"
          "gql"
          "graphql"
          "svelte"
          "css"
          "less"
          "scss"
          "pcss"
          "postcss"
        ];
      };

      ts_ls = {
        enable = true;
        filetypes = [
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
          "svelte"
        ];

        settings = {
          complete_function_calls = true;
          vtsls = {
            autoUseWorkspaceTsdk = true;
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true;
              };
            };
          };

          typescript = {
            updateImportsOnFileMove.enabled = "always";
            suggest = {
              completeFunctionCalls = true;
            };

            inlayHints = {
              enumMemberValues.enabled = true;
              functionLikeReturnTypes.enabled = true;
              parameterNames.enabled = "literals";
              parameterTypes.enabled = true;
              propertyDeclarationTypes.enabled = true;
              variableType.enabled = false;
            };
          };
        };
      };
    };

    ts-autotag.enable = true;
  };
}
