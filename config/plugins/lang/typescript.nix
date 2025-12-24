{ pkgs, lib, ... }:
let
  inherit (lib) mkIf getExe;
in
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

    dap = {
      adapters = {
        servers = {
          pwa-node = {
            host = "localhost";
            port = "\${port}";
            # port = 8123;
            executable = {
              command = mkIf pkgs.stdenv.hostPlatform.isLinux (getExe pkgs.vscode-js-debug);
              args = [
                "\${port}"
                # "8123"
              ];
            };
          };
        };
      };

      configurations =
        let
          javascript-config = [
            {
              type = "pwa-node";
              request = "launch";
              name = "Launch file";
              program = "\${file}";
              cwd = "\${workspaceFolder}";
            }
            {
              type = "pwa-node";
              request = "attach";
              name = "Attach";
              processId.__raw = ''require ("dap.utils").pick_process'';
              cwd = "\${workspaceFolder}";
            }
            {
              type = "pwa-node";
              request = "attach";
              name = "Auto Attach";
              cwd.__raw = "vim.fn.getcwd()";
              protocol = "inspector";
              sourceMaps = true;
              resolveSourceMapLocations = [
                "\${workspaceFolder}/**"
                "!**/node_modules/**"
              ];
              restart = true;
            }

            {
              type = "pwa-node";
              request = "launch";
              name = "Debug Server (Production Build)";
              skipFiles = [
                "<node_internals>/**"
              ];
              program.__raw = "vim.fn.getcwd() .. '/build/server/index.js'";
              outFiles = [
                "\${workspaceFolder}/build/**/*.js"
              ];
              console = "integratedTerminal";
            }
            {
              type = "pwa-node";
              request = "launch";
              name = "Debug with Node Inspect";
              skipFiles = [
                "<node_internals>/**"
              ];
              runtimeExecutable = getExe pkgs.nodejs;
              runtimeArgs = [
                "--inspect"
                "./build/server/index.js"
              ];
              console = "integratedTerminal";
              cwd = "\${workspaceFolder}";
              sourceMaps = true;
              resolveSourceMapLocations = [
                "\${workspaceFolder}/**"
                "!**/node_modules/**"
              ];
            }
            {
              type = "pwa-node";
              request = "launch";
              name = "Debug with Node Inspect (Break)";
              skipFiles = [
                "<node_internals>/**"
              ];
              runtimeExecutable = getExe pkgs.nodejs;
              runtimeArgs = [
                "--inspect-brk"
                "./build/server/index.js"
              ];
              console = "integratedTerminal";
              cwd = "\${workspaceFolder}";
              sourceMaps = true;
              resolveSourceMapLocations = [
                "\${workspaceFolder}/**"
                "!**/node_modules/**"
              ];
            }
            {
              type = "pwa-node";
              request = "launch";
              name = "Debug Vite Dev Server";
              skipFiles = [
                "<node_internals>/**"
              ];
              runtimeExecutable = getExe pkgs.nodejs;
              runtimeArgs = [
                "--inspect"
                "node_modules/vite/bin/vite.js"
                "--host"
              ];
              console = "integratedTerminal";
              cwd = "\${workspaceFolder}";
              sourceMaps = true;
              resolveSourceMapLocations = [
                "\${workspaceFolder}/**"
                "!**/node_modules/**"
              ];
            }
            {
              type = "pwa-node";
              request = "attach";
              name = "Attach to Process";
              port = 9229;
              restart = true;
              skipFiles = [
                "<node_internals>/**"
              ];
              sourceMaps = true;
              resolveSourceMapLocations = [
                "\${workspaceFolder}/**"
                "!**/node_modules/**"
              ];
              cwd = "\${workspaceFolder}";
            }
          ];
        in
        {
          javascript = javascript-config;
          javascriptreact = javascript-config;
          typescript = javascript-config;
          typescriptreact = javascript-config;
        };
    };

    # ts-autotag.enable = true;
  };
}
