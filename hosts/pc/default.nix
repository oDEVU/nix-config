{ config, pkgs, lib, vars, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/user.nix
    ../../modules/desktop.nix
    ../../modules/gaming.nix
    ../../modules/apps.nix
  ];

  time.timeZone = vars.timezone;
  console.keyMap = "${vars.keyboardLayout}2";
  services.xserver.xkb.layout = vars.keyboardLayout;

  system.stateVersion = vars.systemVersion;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
