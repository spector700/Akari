{ pkgs, lib, ... }:
let
  inherit (lib) getExe';
in
{
  lsp.servers = {
    cmake.enable = true;

    clangd = {
      enable = true;
      config = {
        settings.init_options = {
          usePlaceholders = true;
          completeUnimported = true;
          clangdFileStatus = true;
        };
        cmd = [
          "${getExe' pkgs.clang-tools "clangd"}"
          "--background-index"
          "--clang-tidy"
          "--header-insertion=iwyu"
          "--completion-style=detailed"
          "--function-arg-placeholders"
          "--fallback-style=llvm"
        ];

        onAttach.function = ''
          vim.keymap.set('n', 'gh', "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch Source/Header (C/C++)", buffer = bufnr })

          require("clangd_extensions.inlay_hints").setup_autocmd()
          require("clangd_extensions.inlay_hints").set_inlay_hints()
        '';
      };
    };
  };

  plugins = {
    conform-nvim.settings = {
      formatters_by_ft = {
        cpp = [ "clang-format" ];
        cmake = [ "cmake-format" ];
      };
    };

    lint = {
      lintersByFt = {
        cpp = [ "clangtidy" ];
        cmake = [ "cmakelint" ];
      };

      linters = {
        clangtidy.cmd = getExe' pkgs.clang-tools "clang-tidy";
        cmakelint.cmd = getExe' pkgs.cmake-format "cmake-lint";
      };
    };

    clangd-extensions = {
      enable = true;
      settings = {
        inlay_hints = {
          inline = false;
        };
        codelens.enable = true;

        ast = {
          roleIcons = {
            type = "";
            declaration = "";
            expression = "";
            specifier = "";
            statement = "";
            templateArgument = "";
          };
          kindIcons = {
            compound = "";
            recovery = "";
            translationUnit = "";
            packExpansion = "";
            templateTypeParm = "";
            templateTemplateParm = "";
            templateParamObject = "";
          };
        };
      };
    };

    dap = {
      adapters.executables.lldb.command = "${pkgs.lldb}/bin/lldb-vscode";

      configurations.cpp = [
        {
          name = "C++";
          type = "lldb";
          request = "launch";
          cwd = "\${workspaceFolder}";
          program.__raw = ''
            function()
              return vim.fn.input('Executable path: ', vim.fn.getcwd() .. '/', 'file')
            end
          '';
        }
      ];
    };
  };
}
