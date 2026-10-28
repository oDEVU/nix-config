{ pkgsUnstable, ... }:
{
  environment.systemPackages = with pkgsUnstable; [ blender obs-studio ];
}