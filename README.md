# nix-config

## Install

### Link files

```bash
sudo ln -s <cloned+repo> /etc/nixos
```

### Build

```bash
sudo nixos-rebuild switch --flake /etc/nixos#<configuration>
```

### Finish

```bash
caelestia-shell install #apply dots
```

## TODO

- Create laptop config
- Create generic template.
- Split more stuff into modules like apps by categories
