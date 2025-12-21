{ config, lib, ... }:
{
  extraConfigLuaPre = lib.mkIf (config.plugins.mini-hipatterns.enable) ''
    local function in_comment(pattern)
      return function(buf_id)
        local cs = vim.bo[buf_id].commentstring
        if cs == nil or cs == "" then cs = '# %s' end

        -- Extract left and right part relative to '%s'
        local left, right = cs:match('^(.*)%%s(.-)$')
        left, right = vim.trim(left), vim.trim(right)
        -- General ideas:
        -- - Line is commented if it has structure
        -- "whitespace - comment left - anything - comment right - whitespace"
        -- - Highlight pattern only if it is to the right of left comment part
        --   (possibly after some whitespace)
        -- Example output for '/* %s */' commentstring: '^%s*/%*%s*()TODO().*%*/%s*'
        return string.format('^%%s*%s%%s*()%s().*%s%%s*$', vim.pesc(left), pattern, vim.pesc(right))
      end
    end
  '';

  plugins.mini-hipatterns = {
    enable = true;
    settings = {
      highlighters = {
        hex_color.__raw = ''require("mini.hipatterns").gen_highlighter.hex_color()'';
      };
    };
  };
}
