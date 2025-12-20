{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    # Image conversion (required for image module)
    imagemagick
    # PDF rendering
    ghostscript
    # Math expression rendering
    typst
    # LaTeX for math expressions
    tectonic
  ];

  plugins = {
    snacks = {
      settings = {
        image = {
          enabled = true;
          doc = {
            enabled = true;
            inline = true;
            float = true;
            max_width = 100;
            max_height = 50;
          };
        };
      };
    };
  };
}
