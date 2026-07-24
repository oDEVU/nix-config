{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ blender obs-studio ];
}