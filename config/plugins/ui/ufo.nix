{ lib, ... }:
let
  inherit (lib.nixvim) mkRaw;
in
{
  autoCmd = [
    {
      event = [
        "BufEnter"
        "BufNew"
      ];
      desc = "disable statuscolumn for neo-tree and dashboard";
      callback = mkRaw ''
        function()
          local ft_ignore = { "dashboard", "neo-tree" }
          if vim.tbl_contains(ft_ignore, vim.bo.filetype) then
            vim.cmd("setlocal foldcolumn=0")
          end
        end
      '';
    }
  ];

  plugins = {
    statuscol = {
      enable = true;
      settings = {
        relculright = true;
        ft_ignore = [
          "dashboard"
          "neo-tree"
        ];
        segments = [
          {
            click = "v:lua.ScFa";
            text = [ (mkRaw "require('statuscol.builtin').foldfunc") ];
          }
          {
            click = "v:lua.ScSa";
            text = [ " %s" ];
          }
          {
            click = "v:lua.ScLa";
            text = [
              (mkRaw "require('statuscol.builtin').lnumfunc")
              " "
            ];
          }
        ];
      };
    };

    nvim-ufo = {
      enable = true;
      settings = {
        provider_selector = # lua
          ''
            function()
              return { "lsp", "indent" }
            end
          '';
        preview.mappings = {
          close = "q";
          switch = "K";
        };
      };
    };
  };

  opts = {
    foldcolumn = "1";
    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;
    fillchars = mkRaw "[[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]";
  };

  keymaps = [
    {
      mode = "n";
      key = "zR";
      action = mkRaw "function() require('ufo').openAllFolds() end";
      options.desc = "open all folds";
    }
    {
      mode = "n";
      key = "zM";
      action = mkRaw "function() require('ufo').closeAllFolds() end";
      options.desc = "close all folds";
    }
    {
      mode = "n";
      key = "zK";
      action = mkRaw "function() local winid = require('ufo').peekFoldedLinesUnderCursor() if not winid then vim.lsp.buf.hover() end end";
      options.desc = "Peek Folded Lines";
    }
  ];

}
