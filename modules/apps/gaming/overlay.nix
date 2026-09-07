{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mangohud
    vkbasalt
    goverlay
  ];
}
