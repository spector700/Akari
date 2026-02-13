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
        lib.filter (g: !(lib.elem g.pname excludedGrammars)) config.plugins.treesitter.package.allGrammars;

      nixvimInjections = true;
      highlight.enable = true;
      indent.enable = true;
    };

    treesitter-context = {
      inherit (config.plugins.treesitter) enable;
      lazyLoad.settings.event = [
        "BufReadPost"
        "BufNewFile"
      ];

      settings = {
        max_lines = 4;
        min_window_height = 40;
        multiwindow = true;
        separator = "-";
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
