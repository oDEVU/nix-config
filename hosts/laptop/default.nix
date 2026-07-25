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
  ];

  networking.hostName = "nixoslaptop";
  time.timeZone = vars.timezone;
  console.keyMap = "${vars.keyboardLayout}2";
  services.xserver.xkb.layout = vars.keyboardLayout;

  system.stateVersion = vars.systemVersion;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
