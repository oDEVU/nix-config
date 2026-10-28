missing: tree, grim + hyprland shortcut (win+shift+s),

I use a modular NixOS configuration built with flakes, `home-manager`, and per-host/software modules.

**Requirements:**

1. **Package Tiers:**
* Core system and development tools must use `nixos-26.05` (stable).

* Userland applications (Hyprland, browsers, less important apps) must use `nixos-unstable`.
* Gaming must remain bleeding edge (utilizing my existing mesa-git and cachyos kernel (only exception from stable core, since cachyos kernel is stable enough) setups.

2. **Login Manager:**
* Replace the existing `ly` configuration.

* Configure `greetd` to launch `noctalia-greeter-session` for the user, leveraging the existing Noctalia flake inputs.

noctaila greetd docs:
```
nixpkgs module
Noctalia Greeter is packaged in nixpkgs unstable. The nixpkgs module installs the package, enables greetd, Polkit, and AccountsService, and configures the greeter session:

services.displayManager.noctalia-greeter = {
  enable = true;
  settings = {
    cursor.size = 24;
    keyboard.layout = "us";
  };
  cursorTheme = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
  };
};

Project flake module
The project flake is an alternative for channels that do not yet contain the package or for following the greeter repository directly. Add it to flake.nix:

inputs.noctalia-greeter = {
  url = "github:noctalia-dev/noctalia-greeter";
  inputs.nixpkgs.follows = "nixpkgs";
};

Import inputs.noctalia-greeter.nixosModules.default, then enable the project module:

services.displayManager.noctalia-greeter = {
  enable = true;
  settings = {
    cursor = {
      theme = "Bibata-Modern-Ice";
      size = 24;
      path = pkgs.bibata-cursors;
    };
  };
};

The project module enables greetd, AccountsService, and Polkit, and configures greetd to launch the packaged noctalia-greeter-session. The two modules use different option paths and cursor-theme interfaces, so enable only one.

Rebuild and reboot through the normal NixOS workflow to verify that the greeter starts and lists the installed desktop sessions.
```

BTW on my desktop i use dynamic theeme from wallpaper idk if greetd supports it.

3. **Nix-ld.**
* Fill remaining libs for proper apps execution, (optionally do sub module structure for that cause current nix-ld is minimal to run one app)

[nix-shell:~/Documents/Projects/nix-config]$ tree
.
├── flake.lock
├── flake.nix
├── hosts
│   ├── laptop
│   │   ├── default.nix
│   │   └── hardware.nix
│   └── pc
│       ├── default.nix
│       └── hardware.nix
├── modules
│   ├── apps
│   │   ├── ai.nix
│   │   ├── android-webcam.nix
│   │   ├── core.nix
│   │   ├── creative.nix
│   │   ├── dev
│   │   │   ├── android.nix
│   │   │   ├── c-cpp.nix
│   │   │   ├── devshells
│   │   │   │   └── cpp.nix
│   │   │   ├── godot.nix
│   │   │   ├── java.nix
│   │   │   ├── python.nix
│   │   │   ├── tools.nix
│   │   │   └── vbox.nix
│   │   ├── gaming
│   │   │   ├── heroic.nix
│   │   │   ├── logitech.nix
│   │   │   ├── minecraft.nix
│   │   │   ├── overlay.nix
│   │   │   ├── reshade.nix
│   │   │   ├── valve.nix
│   │   │   └── vr.nix
│   │   ├── kdeconnect.nix
│   │   ├── media
│   │   │   └── spotify.nix
│   │   ├── nix-ld.nix
│   │   ├── office.nix
│   │   ├── oneplus
│   │   │   └── deeptest.nix
│   │   ├── ricing
│   │   │   └── wallpaper-engine.nix
│   │   ├── social.nix
│   │   ├── utils.nix
│   │   └── wine.nix
│   ├── desktop
│   │   ├── appearance.nix
│   │   ├── default.nix
│   │   ├── file-manager.nix
│   │   ├── hyprland.nix
│   │   ├── login.nix
│   │   ├── noctalia.nix
│   │   └── permissions.nix
│   ├── home.nix
│   └── user.nix
├── README.md
├── repo
│   ├── ezgif-18e9c288a7fdb695.gif
│   └── preview.gif
├── todo.md
└── vars.nix

14 directories, 48 files

[nix-shell:~/Documents/Projects/nix-config]$
