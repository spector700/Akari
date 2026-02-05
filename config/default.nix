{ pkgs, ... }:
{
  enableMan = false;
  # Import all your configuration modules here
  imports = [
    ./autocmd.nix
    ./keymaps.nix
    ./settings.nix
    ./plugins
  ];

  extraPackages = with pkgs; [
    ripgrep
    lazygit
    fzf
    fd
  ];
}
