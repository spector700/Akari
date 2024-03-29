{
  plugins.toggleterm = {
    enable = true;
    size = ''
      function(term)
        if term.direction == "horizontal" then
          return 30
      elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end
    '';
    openMapping = "<C-/>";
    shadeTerminals = true;
    startInInsert = true;
    terminalMappings = true;
    persistMode = true;
    insertMappings = true;
    closeOnExit = true;
    shell = "zsh";
    direction = "horizontal"; # 'vertical' | 'horizontal' | 'tab' | 'float'
    floatOpts = {
      border = "single"; # 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      width = 80;
      height = 20;
      winblend = 0;
    };
  };
}
