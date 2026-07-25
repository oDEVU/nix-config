{ config, pkgs, lib, vars, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/user.nix
    ../../modules/desktop.nix
    ../../modules/gaming.nix
    ../../modules/apps/core.nix
    ../../modules/apps/utils.nix
    ../../modules/apps/creative.nix
    ../../modules/apps/social.nix
    ../../modules/apps/dev/tools.nix
    ../../modules/apps/dev/c-cpp.nix
    ../../modules/apps/dev/android.nix
  ];

    my.hyprland.monitors = ''
      hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@75", position = "1080x450", scale = 1 })
      hl.monitor({ output = "DP-3", mode = "1920x1080@60", position = "0x0", scale = 1, transform = 1 })
    '';

  networking.hostName = "nixospc";
  time.timeZone = vars.timezone;
  console.keyMap = "${vars.keyboardLayout}2";
  services.xserver.xkb.layout = vars.keyboardLayout;

  system.stateVersion = vars.systemVersion;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
