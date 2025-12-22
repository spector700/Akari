{ config, lib, ... }:
{
  plugins = {
    treesitter = {
      enable = true;
      # folding.enable = true;

      grammarPackages =
        let
          # Large grammars that are not used
          excludedGrammars = [
            "agda-grammar"
            "cuda-grammar"
            "d-grammar"
            "fortran-grammar"
            "gnuplot-grammar"
            "haskell-grammar"
            "hlsl-grammar"
            "julia-grammar"
            "koto-grammar"
            "lean-grammar"
            "nim-grammar"
            "scala-grammar"
            "slang-grammar"
            "systemverilog-grammar"
            "tlaplus-grammar"
            "verilog-grammar"
          ];
        in
        lib.filter (
          g: !(lib.elem g.pname excludedGrammars)
        ) config.plugins.treesitter.package.passthru.allGrammars;

      settings = {
        highlight = {
          additional_vim_regex_highlighting = true;
          enable = true;
          disable = # Lua
            ''
              function(lang, bufnr)
                return vim.api.nvim_buf_line_count(bufnr) > 10000
              end
            '';
        };

        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<A-o>";
            node_incremental = "<A-o>";
            scope_incremental = "<A-O>";
            node_decremental = "<A-i>";
          };
        };
        indent.enable = true;
      };
      nixvimInjections = true;
    };

    treesitter-context = {
      inherit (config.plugins.treesitter) enable;
      lazyLoad.settings.event = "DeferredUIEnter";

      settings = {
        max_lines = 4;
        min_window_height = 40;
        multiwindow = true;
        separator = "-";
      };
    };

    treesitter-refactor = {
      inherit (config.plugins.treesitter) enable;

      settings = {
        highlightDefinitions = {
          enable = true;
          clearOnCursorMove = true;
        };
        smartRename = {
          enable = true;
          keymaps = {
            smart_rename = "gR";
          };
        };
        navigation.enable = true;
      };
    };
  };

  keymaps = lib.mkIf config.plugins.treesitter-context.enable [
    {
      mode = "n";
      key = "<leader>ut";
      action = "<cmd>TSContext toggle<cr>";
      options.desc = "Treesitter Context toggle";
    }
  ];
}
