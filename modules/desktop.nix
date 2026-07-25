{ config, pkgs, inputs, vars, lib, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.my.hyprland.monitors = lib.mkOption {
    type = lib.types.lines;
    default = "";
    description = "Host-specific native Hyprland Lua monitor config";
  };

  config = {
    programs.hyprland.enable = true;

    environment.sessionVariables = {
      XDG_DATA_DIRS = [
        "$HOME/.local/share"
        "/usr/share"
        "/var/lib/flatpak/exports/share"
      ];
    };

    services.displayManager.ly = {
      enable = true;
      settings = { animation = "none"; clear_password = true; };
    };

    systemd.services.ly.serviceConfig = {
      Type = "idle"; StandardInput = "tty"; StandardOutput = "tty";
      TTYReset = true; TTYVHangup = true; TTYVTDisallocate = true;
    };

    fonts.packages = with pkgs; [ rubik nerd-fonts.ubuntu nerd-fonts.jetbrains-mono ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "backup";

    home-manager.users.${vars.userName} = { pkgs, ... }: {
      imports = [
        inputs.caelestia-shell.homeManagerModules.default
        inputs.spicetify-nix.homeManagerModules.default
      ];

      home.packages = with pkgs; [ nwg-look ocs-url ];
      home.sessionVariables = { QT_QPA_PLATFORM = "wayland;xcb"; };

      programs.caelestia = {
        enable = true;
        systemd = { enable = false; target = "graphical-session.target"; environment = []; };
        cli.enable = true;
      };

      programs.spicetify = let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system}; in {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [ hidePodcasts fullAppDisplay coverAmbience spicyLyrics shuffle ];
        theme = spicePkgs.themes.text;
      };

      home.file.".config/caelestia/hypr-user.lua".text = ''
        hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
        hl.config({ input = { kb_layout = "${vars.keyboardLayout}" } })

        -- NIX INJECTS NATIVE LUA HERE
        ${config.my.hyprland.monitors}

        hl.on("hyprland.start", function()
          hl.exec_cmd("''${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1")
        end)

        hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
        hl.bind("SUPER + SHIFT + left", hl.dsp.focus({ direction = "l" }))
        hl.bind("SUPER + SHIFT + right", hl.dsp.focus({ direction = "r" }))
        hl.bind("SUPER + SHIFT + up", hl.dsp.focus({ direction = "u" }))
        hl.bind("SUPER + SHIFT + down", hl.dsp.focus({ direction = "d" }))

        hl.bind("SUPER + left", hl.dsp.window.move({ direction = "l" }))
        hl.bind("SUPER + right", hl.dsp.window.move({ direction = "r" }))
        hl.bind("SUPER + up", hl.dsp.window.move({ direction = "u" }))
        hl.bind("SUPER + down", hl.dsp.window.move({ direction = "d" }))

        hl.bind("SUPER + Slash", hl.dsp.exec_cmd("kitty -e sh -c 'hyprctl binds | less'"))
      '';

      home.stateVersion = vars.systemVersion;
    };
  };
}
