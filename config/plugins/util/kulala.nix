{ pkgs, ... }:
let

  kulala = pkgs.vimUtils.buildVimPlugin {
    name = "kulala-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "mistweaverco";
      repo = "kulala.nvim";
      rev = "7649576ca459146658b4c415d1a320bbedc3f564";
      hash = "sha256-lsct1/VGj0rtX3xzoSKQD7Rji7zsNrWSsHyZr1fdU44=";
    };
    dependencies = with pkgs; [
      libxml2
      jq
    ];
  };

in
{
  lsp.servers = {
    kulala_lsp.enable = true;
  };

  extraPlugins = [ kulala ];

  extraConfigLua = ''
    require("kulala").setup({})
  '';
}
