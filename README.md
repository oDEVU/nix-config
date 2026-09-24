# My private partially vibe coded nix-config

## Preview

![NixOS Config Preview](repo/preview.gif)

## Install

### Link files

```bash
sudo ln -s <cloned+repo> /etc/nixos
```

### Build

```bash
sudo nixos-rebuild switch --flake /etc/nixos#<configuration>
```
