<h1 align="center">
      <img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake-colours.svg" width="96px" height="96px" />
      <br>

Akari

<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px" />
<br>

<div align="center">

<div align="center">
   <p></p>
   <a href="https://github.com/sioodmy/dotfiles/">
      <img src="https://img.shields.io/github/repo-size/spector700/Akari?color=ea999c&labelColor=303446&style=for-the-badge">
   </a>
      <a = href="https://nixos.org">
      <img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor=303446&logo=NixOS&logoColor=white&color=91D7E3">
    </a>
   <br>
</div>
</h1>
<p align=center>Standalone Nixvim flake based on Lazyvim with some more changes.</p>

---

<br>
</div>

![neovim-pic-1](./.github/assets/neovim-pic-1.png)
![neovim-pic-2](./.github/assets/neovim-pic-2.png)
![neovim-pic-3](./.github/assets/neovim-pic-3.png)

<p align="center"> Screenshots Circa: 2024-4-9</p>

---

# 🔨 Installation

If you'd like to give it a try before installing:
`nix run github:spector700/Akari`

### Adding it as a flake

1: Go to the flake.nix and add `Akari.url = "github:spector700/Akari"` to your
inputs.

```nix
# flake
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    Akari.url = "github:spector700/Akari";
  };
}
```

2: Run nix flake update

3: Install it by adding `inputs.Akari.packages.${system}.default` to your
environment.systemPackages or home.packages. If you're using home-manager.

```nix
# packages
{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    inputs.Akari.packages.${system}.default
  ];
}
```

4: Rebuild your system.

</details>

# ⚙️ Configuration

To start configuring, add or modify the nix files in `./config`. If you add a
new configuration file, remember to add it to the
[`config/default.nix`](./config/default.nix) file

## Testing your new configuration

To test your configuration simply run the following command

```
nix run .
```

# :bookmark_tabs: Resources

Some sick ass Nixvim setups that I use from.

- [khaneliman/khanelivim](https://github.com/khaneliman/khanelivim/tree/main)
- [niksingh710/nvix](https://github.com/niksingh710/nvix)
