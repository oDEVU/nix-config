{ config, pkgs, vars, ... }:

{
  # Przypisanie grupy z użyciem dynamicznej zmiennej
  users.users.${vars.userName}.extraGroups = [ "adbusers" ];

  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="OnePlus-Webcam"
  '';

  # Dodano android-tools w zastępstwie programs.adb.enable
  environment.systemPackages = with pkgs; [
    scrcpy
    v4l-utils
    android-tools
  ];
}
